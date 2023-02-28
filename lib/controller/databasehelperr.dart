import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:proximity/model/favoriteworker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperr {
  DatabaseHelperr._privateConstructor();
  static final DatabaseHelperr instace = DatabaseHelperr._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'favoriteworker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS favoriteworker(
    id INTEGER PRIMARY KEY NOT NULL,
    nama TEXT,
    lokasi TEXT,
    jabatan TEXT,
    desc_jabatan TEXT,
    keahlian TEXT,
    desc_keahlian TEXT,
    sop TEXT,
    gaji TEXT,
    syarat TEXT,
    kontak TEXT,
    image TEXT,
    category_id INTEGER)
''');
  }

  Future<List<FavoriteWorker>> getFavorite() async {
    Database db = await instace.database;
    var favorites = await db.query('favoriteworker', orderBy: 'nama');
    List<FavoriteWorker> favoriteList = favorites.isNotEmpty
        ? favorites.map((c) => FavoriteWorker.fromMap(c)).toList()
        : [];
    return favoriteList;
  }

  Future<int> add(FavoriteWorker favorite) async {
    Database db = await instace.database;
    return await db.insert('favoriteworker', favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> remove(int id) async {
    Database db = await instace.database;
    return await db.delete('favoriteworker', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> dropDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'favoriteworker.db');

    // Delete the database file.
    await deleteDatabase(path);
  }
}
