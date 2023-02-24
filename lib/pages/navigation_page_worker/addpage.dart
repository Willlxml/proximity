import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proximity/controller/AddPageWorker_controller.dart';
import 'package:proximity/pages/landingpage_worker.dart';
import 'package:proximity/pages/navigation_page_worker/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors/color.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AddPage extends StatefulWidget {
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File? _image;
  List<Worker> _allWorkers = [];
  List<Worker> get allWorkers => _allWorkers;
  List<dynamic> _dataPendidikan = [];
  List<dynamic> _dataCategory = [];
  String? _valPendidikan;
  String? _valCategory;
  String? nama,
      location,
      jabatan,
      desc_jabatan,
      keahlian,
      desc_keahlian,
      pengalaman,
      kontak;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final controller = Get.put(AddPageWorkerController());
  final TextEditingController namaC = TextEditingController();
  final TextEditingController lokasiC = TextEditingController();
  final TextEditingController jabatanC = TextEditingController();
  final TextEditingController descJabatanC = TextEditingController();
  final TextEditingController keahlianC = TextEditingController();
  final TextEditingController descKeahlianC = TextEditingController();
  final TextEditingController pengalamanC = TextEditingController();
  final TextEditingController contactC = TextEditingController();

  void getPendidikan() async {
    final url = Uri.parse('http://103.179.86.77:4567/api/terakhir');
    final pref = await SharedPreferences.getInstance();
    final tokens = pref.getString('token');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $tokens'});
    var listdata = json.decode(response.body);
    print("data : $listdata");

    setState(() {
      _dataPendidikan = listdata;
    });
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
  void didChangeDependencies() {
    getPendidikan();
    getCategory();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    Get.toNamed('/listPage');
                  },
                  icon: Icon(Icons.edit, color: Colors.black)),
            )
          ],
          title: Text(
            "Tambah Pencari Kerja",
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
                                    "Upload your photo",
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
                      value!.isEmpty ? 'Nama cannot be empty' : null,
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
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Lokasi cannot be empty' : null,
                  textInputAction: TextInputAction.next,
                  controller: lokasiC,
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
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: jabatanC,
                  validator: (value) =>
                      value!.isEmpty ? 'Jabatan cannot be empty' : null,
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
                      ? 'Deskripsi Jabatan cannot be empty'
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
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isEmpty ? 'Keahlian Khusus cannot be empty' : null,
                  controller: keahlianC,
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
                  textInputAction: TextInputAction.next,
                  controller: descKeahlianC,
                  validator: (value) => value!.isEmpty
                      ? 'Deskripsi Keahlian cannot be empty'
                      : null,
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
                  validator: (value) => value!.isEmpty
                      ? 'Pendidikan Terakhir cannot be empty'
                      : null,
                  isExpanded: true,
                  menuMaxHeight: 150,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Pendidikan Terakhir",
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
                  value: _valPendidikan,
                  items: _dataPendidikan.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['nama']),
                      value: item['id'].toString(),
                    );
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      _valPendidikan = v;
                      print(_valPendidikan);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: pengalamanC,
                  validator: (value) =>
                      value!.isEmpty ? 'Pengalaman cannot be empty' : null,
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
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: contactC,
                  validator: (value) =>
                      value!.isEmpty ? 'Kontak cannot be empty' : null,
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
                      controller.addWorker(
                          namaC.text,
                          lokasiC.text,
                          jabatanC.text,
                          descJabatanC.text,
                          keahlianC.text,
                          descKeahlianC.text,
                          pengalamanC.text,
                          contactC.text,
                          _valPendidikan!,
                          _valCategory!,
                          _image!,
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
