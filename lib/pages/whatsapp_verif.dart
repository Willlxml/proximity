import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import '../colors/color.dart';
import 'package:get/get.dart';

class WhatsAppVerif extends StatefulWidget {
  @override
  State<WhatsAppVerif> createState() => _WhatsAppVerifState();
}

class _WhatsAppVerifState extends State<WhatsAppVerif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Text(
              "Whatsapp Verification",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "We have sent 4 digit verification number to your WhatsApp. Please input the 4 digit number here!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 100),
          VerificationCode(
            textStyle: TextStyle(fontSize: 20.0, color: Colors.blue),
            keyboardType: TextInputType.number,
            underlineColor: Colors.blue,
            length: 4,
            cursorColor: Colors.blue,
            onCompleted: (String value) {
              setState(() {});
            },
            onEditing: (bool value) {
              setState(() {});
            },
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 120, 0),
            child: Text(
              "Didn't get the number yet?",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 170, 0),
            child: Text(
              "resent the number",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 110),
          SizedBox(
            width: 300,
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                Get.offAllNamed("LoginPage");
              },
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: primmaryButtons,
            ),
          ),
        ],
      ),
    );
  }
}

final ButtonStyle primmaryButtons = ElevatedButton.styleFrom(
  minimumSize: Size(300, 35),
  elevation: 0,
  backgroundColor: skyBlue,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);

