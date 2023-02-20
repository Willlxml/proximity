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
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Container(
              height: 330,
              width: 340,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                color: skyBlue,
              ),
              child: Image(
                image: NetworkImage(
                    "https://media.discordapp.net/attachments/1059838671144108122/1076035467075653662/how-it-works-animation_2.png?width=766&height=670"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 45),
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
          SizedBox(height: 30),
          Text(
            "Or",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
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
