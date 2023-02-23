import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proximity/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../colors/color.dart';
import '../../controller/Login_controller.dart';

class SettingPageCompany extends StatefulWidget {
  @override
  State<SettingPageCompany> createState() => _SettingPageCompanyState();
}

class _SettingPageCompanyState extends State<SettingPageCompany> {
  final controller = Get.put(LoginController());
  Future<dynamic>? userData;
  String? nama, email;

  File? _image;

  String? status = '';

  String? base64image;

  File? tempFile;

  String? error = 'error';

  TextEditingController nameC = TextEditingController();

  Future<void> GetData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString('nama');
      email = pref.getString('email');
    });
  }

  @override
  void initState() {
    userData = GetData();
    // TODO: implement initState
    super.initState();
  }

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
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidht = MediaQuery.of(context).size.width;
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
      body: FutureBuilder(
          future: userData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // ini card untuk profile
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 20, 0, 0),
                        child: Container(
                          height: mediaQueryHeight * 0.3,
                          width: mediaQueryWidht * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _image != null
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: CircleAvatar(
                                          radius: 55,
                                          backgroundColor: Colors.grey,
                                          backgroundImage:
                                              Image.file(_image!).image),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: CircleAvatar(
                                        radius: 55,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage(
                                            "https://media.discordapp.net/attachments/745141993948053598/1071953402218684496/default-avatar-profile-icon-of-social-media-user-vector.png?width=670&height=670"),
                                      ),
                                    ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 70, 80, 0),
                                    child: Text(
                                      nama!,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text(
                                      email!,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                        child: SizedBox(
                          width: mediaQueryWidht * 0.9,
                          height: mediaQueryHeight * 0.05,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.edit, color: Colors.black54),
                                SizedBox(width: 15),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            style: stylebutton,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                        child: SizedBox(
                          width: mediaQueryWidht * 0.9,
                          height: mediaQueryHeight * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed('/InformationCenter');
                            },
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
                      ),
                      SizedBox(height: 13),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                        child: SizedBox(
                          width: mediaQueryWidht * 0.9,
                          height: mediaQueryHeight * 0.05,
                          child: ElevatedButton(
                            onPressed: () async {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.contact_phone,
                                    color: Colors.black54),
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
                      ),
                      SizedBox(height: 13),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                        child: SizedBox(
                          width: mediaQueryWidht * 0.9,
                          height: mediaQueryHeight * 0.05,
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller.Logout().then((value) {
                                Get.off(LoginPage());
                                final snackBar = SnackBar(
                                    duration: 3.seconds,
                                    elevation: 0,
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.info,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Successfully logged out",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ));
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentMaterialBanner()
                                  ..showSnackBar(snackBar);
                              });
                            },
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
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
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
