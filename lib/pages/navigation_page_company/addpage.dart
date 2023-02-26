import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proximity/controller/AddPageCompany_controller.dart';
import 'package:proximity/model/company.dart';
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
  File? _image, _file;
  final controller = Get.put(AddPageCompanyController());
  List<Company> _allCompanys = [];
  List<Company> get allCompanys => _allCompanys;
  List<dynamic> _dataCategory = [];
    String? _valCategory;

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController namaC = TextEditingController();
  final TextEditingController lokasiC = TextEditingController();
  final TextEditingController jabatanC = TextEditingController();
  final TextEditingController descJabatanC = TextEditingController();
  final TextEditingController keahlianC = TextEditingController();
  final TextEditingController descKeahlianC = TextEditingController();
  final TextEditingController gajiC = TextEditingController();
  final TextEditingController sopC = TextEditingController();
  final TextEditingController contactC = TextEditingController();

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

  @override
  void initState() {
    getCategory();
    // TODO: implement initState
    super.initState();
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
        child: Form(
          key: _formState,
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
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: namaC,
                  validator: (value) =>
                      value!.isEmpty ? 'Nama perusahaan cannot be empty' : null,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(FontAwesomeIcons.industry),
                    hintText: "Nama Perusahaan",
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
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: lokasiC,
                  validator: (value) =>
                      value!.isEmpty ? 'Lokasi cannot be empty' : null,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.pin_drop),
                    hintText: "Lokasi Perusahaan",
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
                child: TextFormField(
                  controller: jabatanC,
                  validator: (value) =>
                      value!.isEmpty ? 'Jabatan cannot be empty' : null,
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
                child: TextFormField(
                  controller: descJabatanC,
                  validator: (value) => value!.isEmpty
                      ? 'Deskripsi jabatan cannot be empty'
                      : null,
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
                child: TextFormField(
                  controller: keahlianC,
                  validator: (value) =>
                      value!.isEmpty ? 'Keahlian khusus cannot be empty' : null,
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
                child: TextFormField(
                  controller: descKeahlianC,
                  validator: (value) => value!.isEmpty
                      ? 'Deskripsi keahlian cannot be empty'
                      : null,
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
                child: SizedBox(
                  width: 360,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => UploadFile(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.file,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        _file != null
                            ? Text(
                                "${_file!.path.split(Platform.pathSeparator).last}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              )
                            : Text(
                                "Terms & Rules",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 5, backgroundColor: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: gajiC,
                  validator: (value) =>
                      value!.isEmpty ? 'Gaji cannot be empty' : null,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(FontAwesomeIcons.dollarSign),
                    hintText: "Gaji Bulanan",
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
                child: TextFormField(
                  controller: sopC,
                  validator: (value) =>
                      value!.isEmpty ? 'SOP cannot be empty' : null,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(FontAwesomeIcons.fileContract),
                    hintText: "SOP",
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
                child: TextFormField(
                  controller: contactC,
                  validator: (value) =>
                      value!.isEmpty ? 'Contact cannot be empty' : null,
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
                    if (_formState.currentState!.validate()) {
                      controller.addCompany(
                          _file!,
                          _image!,
                          namaC.text,
                          lokasiC.text,
                          jabatanC.text,
                          descJabatanC.text,
                          keahlianC.text,
                          descKeahlianC.text,
                          gajiC.text,
                          sopC.text,
                          contactC.text,
                          _valCategory!,
                          context);
                    }
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
      ),
    );
  }
}
