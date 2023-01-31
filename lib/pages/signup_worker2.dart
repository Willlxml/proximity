import 'package:flutter/material.dart';

class SignupWorker2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3FC5F0),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Registration",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 180, 20, 0),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.pin),
                  hintText: "NIK",
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 2.0))),
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            width: 350,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.credit_card, color: Colors.black54),
                  SizedBox(width: 15),
                  Text(
                    "KTP PHOTO",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              style: btnStyle,
            ),
          ),
          SizedBox(height: 85),
          SizedBox(
            width: 300,
            height: 35,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  color: Colors.black,
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

final ButtonStyle btnStyle = ElevatedButton.styleFrom(
  minimumSize: Size(350, 55),
  elevation: 0,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);

final ButtonStyle primmaryButtons = ElevatedButton.styleFrom(
  minimumSize: Size(300, 35),
  elevation: 0,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);
