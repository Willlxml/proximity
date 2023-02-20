import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:proximity/pages/welcome_page.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:get/get.dart';
import 'colors/color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
        backgroundColor: skyBlue,
          splashIconSize: double.infinity,
          splash: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(170),
                      color: Colors.white,
                    ),
                    child: Image.asset('lib/asset/image/logo.png')),
              ),
              SizedBox(height: 110),
              LoadingAnimationWidget.discreteCircle(color: Colors.white, size: 60)
            ],
          ),
          duration: 3000,
          nextScreen: WelcomePage()),
      title: "Proximity",
      initialRoute: '/',
      getPages: AppPage.pages,
    );
  }
}
