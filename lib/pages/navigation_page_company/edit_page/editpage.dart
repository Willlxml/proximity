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
import 'package:proximity/pages/navigation_page_company/edit_page/listpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../colors/color.dart';

class EditPageCompany extends StatefulWidget {
  const EditPageCompany({super.key});

  @override
  State<EditPageCompany> createState() => _EditPageState();
}

class _EditPageState extends State<EditPageCompany> {
  List<dynamic> _dataPendidikan = [];
  List<dynamic> _dataCategory = [];
  String? _valPendidikan;
  String? _valCategory;
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
  final TextEditingController syaratC =
      TextEditingController(text: "${Get.arguments[7]}");
  final TextEditingController sopC =
      TextEditingController(text: "${Get.arguments[8]}");
  final TextEditingController gajiC =
      TextEditingController(text: "${Get.arguments[9]}");
  final TextEditingController contactC =
      TextEditingController(text: "${Get.arguments[10]}");

  void getCategory() async {
    final url = Uri.parse('http://103.179.86.77:4567/api/category/');
    final pref = await SharedPreferences.getInstance();
    final tokens = pref.getString('token');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $tokens'});
    var listCategory = jsonDecode(response.body);

    setState(() {
      _dataCategory = listCategory;
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

  Future<void> deleteUser() async {
    final pref = await SharedPreferences.getInstance();
    final tokens = pref.getString('token');
    final idd = Get.arguments[0].toString();
    Uri url = Uri.parse(
      "http://103.179.86.77:4567/api/mitradelete/$idd",
    );

    final response = await http.delete(url, headers: {'Authorization': 'Bearer $tokens'});
    if (response.statusCode >= 200 && response.statusCode < 300){
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        behavior: SnackBarBehavior.floating,
        content: Text("This Job Vacancy successfully deleted."),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        content: Text("Failed delete this Job Vacancy"),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    }
  }

  Future<Map<String, dynamic>> editUser(
      String nama,
      String location,
      String jabatan,
      String desc_jabatan,
      String keahlian,
      String desc_keahlian,
      String syarat,
      String gaji,
      String sop,
      String contact,
      String category,
      BuildContext context) async {
     
    final idd = Get.arguments[0].toString();
    Uri url = Uri.parse(
        'http://103.179.86.77:4567/api/mitraupdate/$idd');

    final pref = await SharedPreferences.getInstance();
    final tokens = pref.getString('token');
    Map<String, String> headers = {'Authorization': 'Bearer $tokens'};
    final UploadRequest = http.MultipartRequest('POST', url);
    // final file = await http.MultipartFile.fromPath('file', image.path);

    UploadRequest.headers.addAll(headers);
    UploadRequest.fields["nama"] = nama;
    UploadRequest.fields["lokasi"] = location;
    UploadRequest.fields["jabatan"] = jabatan;
    UploadRequest.fields["desc_jabatan"] = desc_jabatan;
    UploadRequest.fields["keahlian"] = keahlian;
    UploadRequest.fields["desc_keahlian"] = desc_keahlian;
    UploadRequest.fields["syarat"] = syarat;
    UploadRequest.fields["gaji"] = gaji;
    UploadRequest.fields["sop"] = sop;
    UploadRequest.fields["kontak"] = contact;
    UploadRequest.fields["category_id"] = category;
    // UploadRequest.files.add(file);

    final StreamedResponse = await UploadRequest.send();
    final response = await http.Response.fromStream(StreamedResponse);
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text("Your data successfully uploaded"),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    } else {
      print(idd);
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Text("Failed to upload your data"),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    }
    final Map<String, dynamic> responseData = json.decode(response.body);

    return responseData;
  }

  @override
  void didChangeDependencies() {
    getCategory();
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
          leading: IconButton(onPressed:() => Get.off(ListPageMitra()), icon: Icon(Icons.arrow_back)),
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
                          '${Get.arguments[11]}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
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
              child: TextField(
                controller: syaratC,
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10),
                validator: (value) => value!.isEmpty
                    ? 'Category pekerjaan cannot be empty'
                    : null,
                isExpanded: true,
                menuMaxHeight: 150,
                decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    hintText: "Category Pekerjaan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(FontAwesomeIcons.list),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0))),
                value: _valCategory,
                items: _dataCategory.map((item) {
                  return DropdownMenuItem(
                    child: Text(item['name']),
                    value: item['id'].toString(),
                  );
                }).toList(),
                onChanged: (v) {
                  setState(() {
                    _valCategory = v;
                    print(_valCategory);
                  });
                },
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                //   print("clicked");
                  editUser(nameC.text, lokasiC.text, jabatanC.text, descJabatanC.text, keahlianC.text, descKeahlianC.text, syaratC.text, gajiC.text, sopC.text, contactC.text, _valCategory!, context).then((value) => Get.off(ListPageMitra()));
                },
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.greenAccent,
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
                  deleteUser().then((value) => Get.off(ListPageMitra()));
                },
                child: Text(
                  "Delete this Job Vacancy",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.redAccent,
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
