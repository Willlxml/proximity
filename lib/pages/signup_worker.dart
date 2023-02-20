import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:get/get.dart';
import 'package:proximity/controller/Regisworker_controller.dart';
import '../routes/route_name.dart';

class SignupWorker extends StatefulWidget {
  @override
  State<SignupWorker> createState() => _SignupWorkerState();
}

class _SignupWorkerState extends State<SignupWorker> {
  TextEditingController nameC = TextEditingController();
  TextEditingController nikC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController pinC = TextEditingController();
  late bool _passwordVisible, _pinVisible;
  File? _image;
  String? status = '';
  String? base64image;
  String? error = 'error';

  void getImageGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _image = File(result.files.single.path!);
      final filetemporary = File(result.files.single.path!);

      setState(() {
        this._image = filetemporary;
      });
    } else {
      print("File Not Found");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
    _pinVisible = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Colors.white,
                ),
                child: Image.asset('lib/asset/image/logo.png'),
              ),
            ),
            SizedBox(height: 15),
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Divider(
                  thickness: 3,
                  color: Colors.black,
                ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: TextField(
                controller: nameC,
                decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.person),
                    hintText: "Full Name",
                    prefixIconColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.black, width: 2.0))),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: TextField(
                controller: nikC,
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
                        borderSide: BorderSide(
                            color: Colors.black, width: 2.0))),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: TextField(
                controller: phoneC,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Phone Number",
                    prefixIconColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.black, width: 2.0))),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: TextField(
                controller: emailC,
                decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                    prefixIconColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.black, width: 2.0))),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: TextField(
                controller: passC,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.key),
                    hintText: "Password",
                    prefixIconColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.black, width: 2.0))),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: TextField(
                controller: pinC,
                keyboardType: TextInputType.number,
                obscureText: !_pinVisible,
                decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.keyboard),
                    hintText: "PIN",
                    prefixIconColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _pinVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _pinVisible = !_pinVisible;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.black, width: 2.0))),
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: mediaQueryWidht * 0.9,
              height: mediaQueryHeight * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  getImageGallery();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.credit_card, color: Colors.black45,),
                    SizedBox(width: 10),
                    _image != null
                        ? Text(
                      "${_image!
                          .path
                          .split(Platform.pathSeparator)
                          .last}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    )
                        : Text(
                      "KTP Photo",
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: CheckboxListTileFormField(
                title: Text(
                  "I Agree with application terms & rules",
                  style: TextStyle(color: Colors.white),
                ),
                activeColor: Colors.green,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 300,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Get.offNamed(RouteName.whatsapp_verif);
                },
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
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

final ButtonStyle primmaryButtons = ElevatedButton.styleFrom(
  minimumSize: Size(300, 35),
  elevation: 5,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);
