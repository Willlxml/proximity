import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:proximity/controller/databasehelper.dart';
import 'package:proximity/model/favorite.dart';
// import 'package:proximity/controller/Favourite_controller.dart';

import '../../../colors/color.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({super.key});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  List<dynamic> _dataPendidikan = [];
  // final controller = Get.put(FavouriteController());
  bool Clicked = true;
  @override
  void didChangeDependencies() {
    if(Clicked ==  false){
      Clicked == false;
    }else{
     Clicked == true;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  final TextEditingController nameC =
      TextEditingController(text: "${Get.parameters['name']}");
 
  final TextEditingController lokasiC =
      TextEditingController(text: "${Get.parameters['lokasi']}");
  final TextEditingController jabatanC =
      TextEditingController(text: "${Get.parameters['jabatan']}");
  final TextEditingController descJabatanC =
      TextEditingController(text: "${Get.parameters['desc_jabatan']}");
  final TextEditingController keahlianC =
      TextEditingController(text: "${Get.parameters['keahlian']}");
  final TextEditingController descKeahlianC =
      TextEditingController(text: "${Get.parameters["desc_keahlian"]}");
  final TextEditingController pengalamanC =
      TextEditingController(text: "${Get.parameters["pengalaman_kerja"]}");
  final TextEditingController contactC =
      TextEditingController(text: "${Get.parameters["kontak"]}");
  final TextEditingController pendidikanTerakhir =
      TextEditingController(text: "${Get.parameters["pendidikan"]}");
  final TextEditingController imageC =
      TextEditingController(text: "${Get.parameters["image"]}");

  @override
  Widget build(BuildContext context) {
    var _value = "-1";
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  onPressed: () {
                    // controller.createTable();
                  },
                  icon: Icon(Icons.help, color: Colors.black)),
            )
          ],
          title: Text(
            "Profile of ${Get.parameters['name']}",
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
            Center(
              child: Container(
                width: 300,
                child: Image.network(
                  '${Get.parameters['image']}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
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
                  IconButton(
                    onPressed: () async {
                      await DatabaseHelper.instace
                          .add(Favorite(
                              id: null,
                              namaLengkap: nameC.text,
                              lokasi: lokasiC.text,
                              jabatan: jabatanC.text,
                              descJabatan: descJabatanC.text,
                              keahlian: keahlianC.text,
                              descKeahlian: descKeahlianC.text,
                              pendidikanTerakhir: pendidikanTerakhir.text,
                              pengalamanKerja: pengalamanC.text,
                              kontak: contactC.text,
                              image: imageC.text))
                          .then((value) {
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
                                "Added to Favorites",
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
                    icon: Icon((Clicked == false) ? Icons.favorite : Icons.favorite_border , color: Colors.red,),
                    style: IconButton.styleFrom(
                      elevation: 5,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameC,
                enabled: false,
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
                enabled: false,
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
                enabled: false,
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
                enabled: false,
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
                enabled: false,
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
                enabled: false,
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
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(FontAwesomeIcons.userGraduate),
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                value: _value = Get.parameters['pendidikan']!,
                items: [
                  DropdownMenuItem(
                      child: Text(
                        'SD',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _value = 1.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'SMP',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _value = 2.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'SMA',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _value = 3.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'D1',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _value = 4.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'D2',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _value = 5.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'D3',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _value = 6.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'S1',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _value = 7.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'S2',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _value = 8.toString()),
                  DropdownMenuItem(
                      child: Text(
                        'S3',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _value = 9.toString()),
                ],
                onChanged: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: pengalamanC,
                enabled: false,
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
                enabled: false,
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
          ],
        ),
      ),
    );
  }
}
