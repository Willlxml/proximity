import 'package:flutter/material.dart';
import 'package:proximity/pages/welcome_page.dart';
import 'package:get/get.dart';
import './routes/page_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:WelcomePage(),
      initialRoute: '/',
      getPages: AppPage.pages,
    );
  }
}
