import 'package:flutter/material.dart';
import '../colors/color.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Container(
              height: 400,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Image(image: NetworkImage("https://cdn.discordapp.com/attachments/1027407023752622080/1075944982034268161/WhatsApp_Image_2023-01-30_at_14.32.28_1.jpg")),
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "FIND WORKER JOB OR SEARCH YOUR JOB HERE!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "This app will help you find your best job! sign in or sign up and find it by yourself",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: buttonPrimary,
            onPressed: () {
              Get.toNamed("LoginPage");
            },
            child: Text(
              "SIGN IN",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Or",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Get.toNamed(RouteName.signup_as);
            },
            child: Text(
              "Create new Account",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(324, 40),
  elevation: 0,
  backgroundColor: skyBlue,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  ),
);
