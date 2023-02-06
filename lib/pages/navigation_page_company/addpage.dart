import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proximity/pages/landingpage_worker.dart';
import 'package:proximity/pages/navigation_page_worker/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors/color.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AddPageCompany extends StatefulWidget {
  @override
  State<AddPageCompany> createState() => _AddPageCompanyState();
}

class _AddPageCompanyState extends State<AddPageCompany> {
  File? _image;
  String? status = '';
  String? base64image;
  File? tempFile;
  String? error = 'error';
  TextEditingController nameC = TextEditingController();

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
        Uri.parse('https://webhook.site/2b52220e-c683-44a3-95f4-095908cb11a3');

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
    var _value = "-1";
    return Scaffold(
      backgroundColor: skyBlue,
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.help, color: Colors.black)),
            )
          ],
          title: Text(
            "Tambah Lowongan Kerja",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            _image != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.file(
                          _image!,
                          width: 350,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          onPressed: () {
                            getImageGalery();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ],
                          ))
                    ],
                  )
                : SizedBox(
                    width: 300,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            getImageGalery();
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Upload your company's photo",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: nameC,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.person),
                  hintText: "Nama Lengkap",
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.pin_drop),
                  hintText: "Lokasi Kerja",
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.briefcase),
                  hintText: "Jabatan",
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.briefcase),
                  hintText: "Deskripsi Jabatan",
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.trophy),
                  hintText: "Keahlian Khusus",
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.trophy),
                  hintText: "Deskripsi Keahlian",
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                menuMaxHeight: 150,
                decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(FontAwesomeIcons.userGraduate),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0))),
                value: _value,
                items: [
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("Pendidikan Terakhir"),
                      ),
                      value: "-1"),
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("SD"),
                      ),
                      value: "1"),
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("SMP"),
                      ),
                      value: "2"),
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("SMA"),
                      ),
                      value: "3"),
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("D1"),
                      ),
                      value: "4"),
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("D2"),
                      ),
                      value: "5"),
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("D3"),
                      ),
                      value: "6"),
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("S1"),
                      ),
                      value: "7"),
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("S2"),
                      ),
                      value: "8"),
                  DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text("S3"),
                      ),
                      value: "9"),
                ],
                onChanged: (v) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.history),
                  hintText: "Pengalaman Kerja",
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.idCard),
                  hintText: "Contact",
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  _start();
                },
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
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
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
