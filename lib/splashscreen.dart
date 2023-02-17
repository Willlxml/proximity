import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/pages/welcome_page.dart';


class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    _navigatehome();
  }

  _navigatehome() async{
    await Future.delayed(Duration(seconds: 3), () {});
    Get.off(WelcomePage());
  }
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
