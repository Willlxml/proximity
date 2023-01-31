import 'package:flutter/material.dart';
import 'package:proximity/routes/route_name.dart';
import '../colors/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
            "What you want to do?",
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
              onPressed: () {},
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
          SizedBox(height: 80),
          Text(
            "Or you want to enter as guest?",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 300,
            height: 40,
            child: ElevatedButton(
              style: buttonPrimarys,
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20),
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
  shape: RoundedRectangleBorder(

  ),
);
