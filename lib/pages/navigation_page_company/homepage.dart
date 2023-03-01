import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/controller/Login_controller.dart';
import 'package:proximity/controller/category_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/category.dart';

class HomePageCompany extends StatefulWidget {
  @override
  State<HomePageCompany> createState() => _HomePageCompanyState();
}

class _HomePageCompanyState extends State<HomePageCompany> {
  String? nama;
  Future<dynamic>? userData;
  bool isLoggedin = false;
  List<dynamic> categories = [];
  final controllerCat = Get.put(CategoryController());

  Future<void> GetData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString('nama');
      print(nama);
    });
  }

  @override
  void initState() {
    super.initState();
    userData = GetData();
    controllerCat.getCategory().then((response) {
      setState(() {
        categories = response;
      });
    });
  }

  @override
  void didChangeDependencies() {
    userData = GetData();

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3FC5F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: SizedBox(),
        leadingWidth: 0,
        toolbarHeight: 110,
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
              padding: EdgeInsets.fromLTRB(0, 2, 55, 0),
              child: Text(
                "Find your best worker here.",
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
            padding: EdgeInsets.fromLTRB(0, 30, 130, 0),
            child: Text(
              "Nearest Worker Category",
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
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final id = category['id'];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                    child: InkWell(
                      onTap: () =>
                          Get.toNamed('/kategoriMitra/$id', arguments: [id]),
                      child: Image.asset('lib/asset/image/$index.jpg'),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
