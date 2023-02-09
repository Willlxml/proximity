import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:proximity/routes/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class RegisterMitraV2 extends StatefulWidget {
  @override
  State<RegisterMitraV2> createState() => _RegisterMitraV2State();
}

class _RegisterMitraV2State extends State<RegisterMitraV2> {
  File? _image, _file;
  String? status = '';
  String? base64image;
  String? error = 'error';

  void getImageGalery() async {
       FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _image = File(result.files.single.path!); 
      final filetemporary = File(result.files.single.path!);

      setState(() {
        this._image = filetemporary;  
      });

    } else {
      print("File not found");
      // User canceled the picker
    }
  }

  void UploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _file = File(result.files.single.path!); 
      final filetemporary = File(result.files.single.path!);

      setState(() {
        this._file = filetemporary;  
      });

    } else {
      print("File not found");
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3FC5F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: Container(),
        title: Text(
          "Register Company",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.idCard),
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
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                getImageGalery();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image != null
                      ? Text(
                          "${_image!.path.split(Platform.pathSeparator).last}",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        )
                      : Text(
                          "Foto KTP pemilik",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () => UploadFile(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _file != null
                      ? Text(
                          "${_file!.path.split(Platform.pathSeparator).last}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        )
                      : Text(
                          "Foto Surat Izin Usaha",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                Get.offNamed(RouteName.landingpagecompany);
              },
              child: Text(
                "SUBMIT",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget CustomButton(
    {required String? title,
    required IconData? icon,
    required VoidCallback? onClick}) {
  return Container(
    width: 300,
    child: ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 20,
          ),
          Text(
            title!,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          )
        ],
      ),
    ),
  );
}
