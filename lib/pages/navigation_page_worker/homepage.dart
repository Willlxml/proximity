import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faker/faker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   String? nama;

  Future<dynamic>? userData;

  Future<void> GetData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString('nama');
    });
  }

  @override
  void initState() {
    userData = GetData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3FC5F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 110,
        leading: Container(),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 185, 0),
              child: Text(
                "Hi, $nama!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 92, 0),
              child: Text(
                "Welcome to Proximity!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
              child: Text(
                "Find your exellent job here.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(90),
            ),
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 170, 0),
            child: Text(
              "Nearest Job Category",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/kategori/${index+1}');
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
