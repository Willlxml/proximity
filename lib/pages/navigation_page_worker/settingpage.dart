import 'package:flutter/material.dart';
import 'package:proximity/colors/color.dart';
import 'package:negative_padding/negative_padding.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skyBlue,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        foregroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                              "https://media.discordapp.net/attachments/1059838671144108122/1060455011877928960/IMG_20211120_121211.jpg"),
                        ),
                      ),
                      NegativePadding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: skyBlue),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 70, 50, 0),
                        child: Text(
                          "William",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                        child: Text(
                          "william@gmail.com",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 350,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.info_rounded, color: Colors.black54),
                  SizedBox(width: 15),
                  Text(
                    "Information Center",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              style: stylebutton,
            ),
          ),
          SizedBox(height: 13),
          SizedBox(
            width: 350,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.contact_phone, color: Colors.black54),
                  SizedBox(width: 15),
                  Text(
                    "Contact Admin",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              style: stylebutton,
            ),
          ),
          SizedBox(height: 13),
          SizedBox(
            width: 350,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.login, color: Colors.black54),
                  SizedBox(width: 15),
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              style: stylebutton,
            ),
          ),
        ],
      ),
    );
  }
}
final ButtonStyle stylebutton = ElevatedButton.styleFrom(
  elevation: 0,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);