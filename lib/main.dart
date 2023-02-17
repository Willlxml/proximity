import 'package:animated_splash_screen/animated_splash_screen.dart';
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
      home: AnimatedSplashScreen(
        splashIconSize: double.infinity,
          splash: Image(image: NetworkImage("https://cdn.discordapp.com/attachments/1027407023752622080/1076020493360054312/1_1.png"),),
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: WelcomePage()),
      title: "Proximity",
      initialRoute: '/',
      getPages: AppPage.pages,
    );
  }
}
