import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity/pages/login.dart';
import 'package:proximity/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../colors/color.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String finalToken;
  

  @override
  void initState() {
    getValidation().whenComplete(() async{
      Timer(Duration(seconds: 3), () => Get.off(finalToken == null ? WelcomePage() : LoginPage()));
    });
    super.initState();
  }
  Future getValidation() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainToken = sharedPreferences.getString('token');
    setState(() {
      finalToken = obtainToken.toString();
    });
    print(finalToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skyBlue,
      body: Container(
        decoration: BoxDecoration(
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
              child: Container(
                width: 4000,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  color: Colors.white,
                ),
                child: Image.asset('lib/asset/image/logo.png'),
              ),
            ),
            SizedBox(height: 150),
            CircularProgressIndicator(color: Colors.white,),
          ],
        ),
      ),
    );
  }
}
