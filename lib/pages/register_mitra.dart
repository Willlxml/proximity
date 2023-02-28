import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:proximity/pages/whatsapp_verif.dart';

class RegisterMitra extends StatefulWidget {
  const RegisterMitra({super.key});

  @override
  State<RegisterMitra> createState() => _RegisterMitraState();
}

class _RegisterMitraState extends State<RegisterMitra> {
  late bool _passwordVisible, _pinVisible;
  File? _image, _file;
  String? status = '';
  String? base64image;
  String? error = 'error';

  void getImageGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _image = File(result.files.single.path!);
      final imagetemp = File(result.files.single.path!);

      setState(() {
        this._image = imagetemp;
      });
    } else {
      print("File not found");
    }
  }

  void UploadFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _file = File(result.files.single.path!);
      final filetemp = File(result.files.single.path!);

      setState(() {
        this._file = filetemp;
      });
    } else {
      print("File not found");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
    _pinVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidht = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff3FC5F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          "Company Registration",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
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
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Divider(
                  thickness: 3,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(20),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.person),
                      hintText: "Owner Full Name",
                      prefixIconColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0))),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
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
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0))),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(20),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Phone",
                      prefixIconColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0))),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding:EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(20),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.email),
                      hintText: "Company's email address",
                      prefixIconColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0))),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: TextField(
                  obscureText: !_passwordVisible,
                  textInputAction: TextInputAction.done,
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: TextFormField(
                  obscureText: !_pinVisible,
                  keyboardType: TextInputType.number,
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _pinVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _pinVisible = !_pinVisible;
                          });
                        },
                      )),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: mediaQueryWidht * 0.9,
                height: mediaQueryHeight * 0.07,
                child: ElevatedButton(
                  onPressed: () => UploadFiles(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.quick_contacts_mail_outlined,
                          color: Colors.black38),
                      SizedBox(width: 10),
                      _image != null
                          ? Text(
                              "${_image!.path.split(Platform.pathSeparator).last}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              "Photo of Business License",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black38,
                              ),
                            )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: mediaQueryWidht * 0.9,
                height: mediaQueryHeight * 0.07,
                child: ElevatedButton(
                  onPressed: () => UploadFiles(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: Colors.black38,
                      ),
                      SizedBox(width: 10),
                      _image != null
                          ? Text(
                              "${_file!.path.split(Platform.pathSeparator).last}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              "Owner's KTP Photo",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black38,
                              ),
                            )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(height: 15),
              CheckboxListTileFormField(
                title: Text(
                  'I agree with application terms & rules',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
                activeColor: Colors.greenAccent,
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(WhatsAppVerif());
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
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
