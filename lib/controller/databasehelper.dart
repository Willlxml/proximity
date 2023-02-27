import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:proximity/model/favorite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instace = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'favorite.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS favorite(
    id INTEGER PRIMARY KEY NOT NULL,
    nama_lengkap TEXT,
    lokasi TEXT,
    jabatan TEXT,
    desc_jabatan TEXT,
    keahlian TEXT,
    desc_keahlian TEXT,
    pendidikan_terakhir INTEGER,
    pengalaman_kerja TEXT,
    kontak TEXT,
    image TEXT,
    category_id INTEGER)
''');
  }

  Future<List<Favorite>> getFavorite() async {
    Database db = await instace.database;
    var favorites = await db.query('favorite', orderBy: 'nama_lengkap');
    List<Favorite> favoriteList = favorites.isNotEmpty
        ? favorites.map((c) => Favorite.fromMap(c)).toList()
        : [];
    return favoriteList;
  }

  Future<int> add(Favorite favorite) async {
    Database db = await instace.database;
    return await db.insert('favorite', favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> remove(int id) async {
    Database db = await instace.database;
    return await db.delete('favorite', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> dropDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'favorite.db');

    // Delete the database file.
    await deleteDatabase(path);
  }
}
