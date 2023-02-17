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
import '../../../colors/color.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<dynamic> _dataPendidikan = [];
  String? _valPendidikan;
  File? _image;
  final id = Get.parameters[0].toString();
  final controller = Get.put(WorkerController());
  final TextEditingController nameC =
      TextEditingController(text: "${Get.arguments[1]}");
  final TextEditingController lokasiC =
      TextEditingController(text: "${Get.arguments[2]}");
  final TextEditingController jabatanC =
      TextEditingController(text: "${Get.arguments[3]}");
  final TextEditingController descJabatanC =
      TextEditingController(text: "${Get.arguments[4]}");
  final TextEditingController keahlianC =
      TextEditingController(text: "${Get.arguments[5]}");
  final TextEditingController descKeahlianC =
      TextEditingController(text: "${Get.arguments[6]}");
  final TextEditingController pengalamanC =
      TextEditingController(text: "${Get.arguments[8]}");
  final TextEditingController contactC =
      TextEditingController(text: "${Get.arguments[9]}");

  void getPendidikan() async {
    final url = Uri.parse('http://103.179.86.77:4567/api/terakhir');
    final response = await http.get(url);
    var listdata = json.decode(response.body);
    print("data : $listdata");

    setState(() {
      _dataPendidikan = listdata;
    });
  }

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

  @override
  void didChangeDependencies() {
    getPendidikan();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
              // child: IconButton(
              //     onPressed: () {},
              //     icon: Icon(Icons.help, color: Colors.black)),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
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
                      ])
                : Center(
                    child: Container(
                      width: 300,
                      child: InkWell(
                        onTap: () {
                          getImageGalery();
                        },
                        child: Image.network(
                          '${Get.arguments[10]}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, top: 10),
            //   child: Row(
            //     children: [
            //       SizedBox(
            //         width: 100,
            //         child: ElevatedButton(
            //           onPressed: () {},
            //           child: Text(
            //             "Hire",
            //             style: TextStyle(
            //                 color: Colors.black, fontWeight: FontWeight.w600),
            //           ),
            //           style: ElevatedButton.styleFrom(
            //               elevation: 5, backgroundColor: Colors.white),
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(FontAwesomeIcons.heart),
            //         style: IconButton.styleFrom(
            //           elevation: 5,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),``
            _image != null
                ? SizedBox(
                    height: 0,
                  )
                : SizedBox(
                    height: 10,
                  ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameC,
                enabled: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: Colors.black,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: lokasiC,
                enabled: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.pin_drop),
                  prefixIconColor: Colors.black,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: jabatanC,
                enabled: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.briefcase),
                  prefixIconColor: Colors.black,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: descJabatanC,
                enabled: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.briefcase),
                  prefixIconColor: Colors.black,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: keahlianC,
                enabled: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.trophy),
                  prefixIconColor: Colors.black,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: descKeahlianC,
                enabled: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.trophy),
                  prefixIconColor: Colors.black,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
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
                value: _valPendidikan = Get.arguments[7].toString(),
                items: [
                  DropdownMenuItem(
                      child: Text(
                        'SD',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _valPendidikan = 1.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'SMP',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _valPendidikan = 2.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'SMA',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _valPendidikan = 3.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'D1',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _valPendidikan = 4.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'D2',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _valPendidikan = 5.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'D3',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _valPendidikan = 6.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'S1',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _valPendidikan = 7.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'S2',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _valPendidikan = 8.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'S3',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _valPendidikan = 9.toString()),
                ],
                onChanged: (selectedValue) {
                  setState(() {
                    _valPendidikan = selectedValue.toString();
                    print(selectedValue);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: pengalamanC,
                enabled: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.history),
                  prefixIconColor: Colors.black,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: contactC,
                enabled: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.idCard),
                  prefixIconColor: Colors.black,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  print("clicked");
                  controller.editUser(
                      id,
                      nameC.text,
                      lokasiC.text,
                      jabatanC.text,
                      descJabatanC.text,
                      keahlianC.text,
                      descKeahlianC.text,
                      pengalamanC.text,
                      contactC.text,
                      _valPendidikan!,
                      context);
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
