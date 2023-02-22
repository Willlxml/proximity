import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:proximity/controller/Worker_controller.dart';
import 'package:http/http.dart' as http;
import 'package:proximity/controller/databasehelper.dart';
import '../../../colors/color.dart';

class FavoriteDetail extends StatefulWidget {
  const FavoriteDetail({super.key});

  @override
  State<FavoriteDetail> createState() => _FavoriteDetailState();
}

class _FavoriteDetailState extends State<FavoriteDetail> {
  List<dynamic> _dataPendidikan = [];
  String? _valPendidikan;
  File? _image;
  bool Clicked = true;

  String text = "Kosong";

  var data = [
    "default",
    "SD",
    "SMP",
    "SMA",
    "D1",
    "D2",
    "D3",
    "S1",
    "S2",
    "S3"
  ];

  void changeText() {
    setState(() {
      text = data[int.parse('${Get.arguments[7]}')];
    });
  }

  var id = Get.arguments[0];
  bool isIniate = true;


  @override
  void initState() {
    changeText();
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isIniate) {
      return null;
    }
    isIniate = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    isIniate = true;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: skyBlue,
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () async {
                  await DatabaseHelper.instace
                      .remove(int.parse(id))
                      .then((value) {
                    final snackBar = SnackBar(
                      duration: 3.seconds,
                      elevation: 0,
                      backgroundColor: Colors.red,
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
                            "Removed from Favorites",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentMaterialBanner()
                      ..showSnackBar(snackBar);
                  });
                  setState(() {
                    Clicked = !Clicked;
                  });
                },
                icon: Icon(
                  (Clicked == true) ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                style: IconButton.styleFrom(
                  elevation: 5,
                ),
              ),
            )
          ],
          title: Text(
            "Profile of ${Get.arguments[1]}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 15, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                  shape: BoxShape.circle),
                              child: CircleAvatar(
                                backgroundImage: Image.network(
                                  '${Get.arguments[10]}',
                                  fit: BoxFit.cover,
                                ).image,
                              )),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text("${Get.arguments[1]}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20)),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                            indent: 30,
                            endIndent: 30,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Jabatan yang di inginkan: ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "${Get.arguments[3]}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black))
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Deskripsi jabatan: ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "${Get.arguments[4]}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black))
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Lokasi Kerja: ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "${Get.arguments[2]}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black))
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                ),
                                child: Container(
                                  width: 330,
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Keahlian: ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "${Get.arguments[5]}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black))
                                        ]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                ),
                                child: Container(
                                  width: 330,
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Deskripsi Keahlian: ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "${Get.arguments[6]}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black))
                                        ]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Pendidikan Terakhir: ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: text,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black))
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Pengalaman Kerja: ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "${Get.arguments[8]}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black))
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  bottom: 5,
                                  top: 5,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Kontak: ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "${Get.arguments[9]}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black))
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: SizedBox(
                  width: 330,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Hire",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 5, backgroundColor: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
