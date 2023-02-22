import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:proximity/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import './routes/page_route.dart';

void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      openDatabase(join(await getDatabasesPath(), 'favorite_database.db'));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      title: "Proximity",
      initialRoute: '/',
      getPages: AppPage.pages,
    );
  }
}
