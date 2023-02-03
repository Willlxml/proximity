import 'dart:convert';
import 'dart:io';
import 'dart:async';

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
  File? _image;
  String? status = '';
  String? base64image;
  File? tempFile;
  String? error = 'error';

  Future getImageGalery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imagePermanent = await saveFilePermanently(image.path);
      print(imagePermanent);

      // final imageTemporary = File(image.path);
      // print(imageTemporary);

      setState(() {
        this._image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future<Map<String, dynamic>> _uploadImage(File? image) async {
    SharedPreferences imageData = await SharedPreferences.getInstance();
    var uri =
        Uri.parse('https://webhook.site/9760b12e-193f-4d42-b0fc-91d597b4f099');

    final imageUploadRequest = http.MultipartRequest('POST', uri);
    imageUploadRequest.fields['name'] = "Static Title";
    final file = await http.MultipartFile.fromPath('images[0]', image!.path);

    imageUploadRequest.files.add(file);

    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      print("Uploaded");
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    return responseData;
  }

  void _start() async {
    final Map<String, dynamic> response = await _uploadImage(_image);
    print(response);
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
          _image != null
              ? Image.file(
                  _image!,
                  width: 250,
                  height: 0,
                  fit: BoxFit.contain,
                )
              : Text("No Image"),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                getImageGalery();
              },
              child: Text(
                "Foto KTP pemilik",
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
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                getImageGalery();
              },
              child: Text(
                "Foto Surat Ijin Usaha",
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
