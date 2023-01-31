import 'package:flutter/material.dart';
import '../colors/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';

class SignupAs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 80, 40, 0),
            child: Text(
              "BEST PLACE TO FIND YOUR JOB OR WORKER",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 90),
          Text(
            "What do you want to do?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(RouteName.signup_worker);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.table),
                  SizedBox(width: 25),
                  Text("SIGN IN AS WORKER")
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          Text(
            "Or",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/RegisterMitra');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.building),
                  SizedBox(width: 25),
                  Text("SIGN IN AS COMPANY")
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Divider(
            height: 50,
            thickness: 1.5,
            color: Colors.black,
            indent: 30,
            endIndent: 30,
          ),
          Text(
            "Do you want to enter as a guest?",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: 300,
            height: 40,
            child: ElevatedButton(
              style: buttonPrimarys,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.userSecret,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Enter Guest Mode",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

final ButtonStyle buttonPrimarys = ElevatedButton.styleFrom(
  minimumSize: Size(324, 40),
  elevation: 0,
  backgroundColor: grayy,
  shape: RoundedRectangleBorder(),
);
