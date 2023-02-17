import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/pages/welcome_page.dart';
import 'package:get/get.dart';
import './routes/page_route.dart';
import './pages/../pages/navigation_page_worker/settingpage.dart';

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
