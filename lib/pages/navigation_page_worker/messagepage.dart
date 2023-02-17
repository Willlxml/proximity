import 'package:flutter/material.dart';
import 'package:proximity/colors/color.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        centerTitle: true,
        backgroundColor: skyBlue,
        title: Text(
          "Chats",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text("Company"),
            subtitle: Text(
              "Apakah anda pengangguran?",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(),
            trailing: Text("10:00 PM"),
            // dense: true,
            onTap: () {},
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
