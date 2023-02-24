import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:proximity/controller/Login_controller.dart';
import 'package:proximity/pages/landingpage_company.dart';
import 'package:proximity/pages/landingpage_worker.dart';
import 'package:proximity/pages/login.dart';
import 'package:proximity/pages/splash_screen.dart';
import 'package:proximity/pages/welcome_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import './routes/page_route.dart';

void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(join(await getDatabasesPath(), 'favorite.db'));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.put(LoginController());
  // String? role;

  // Future<void> GetData() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     role = pref.getString('role');
  //   });
  // }

  @override
  void initState() {
    // GetData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
      title: "Proximity",
      initialRoute: '/',
      getPages: AppPage.pages,
    );
  }
}
