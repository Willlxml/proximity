import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:proximity/pages/welcome_page.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import './routes/page_route.dart';

void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(join(await getDatabasesPath(), 'favorite.db'));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      title: "Proximity",
      initialRoute: '/',
      getPages: AppPage.pages,
    );
  }
}
