import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:proximity/controller/databasehelperr.dart';
import 'package:proximity/model/favorite.dart';
import 'package:proximity/model/favoriteworker.dart';

import '../../../colors/color.dart';

class CategoryDetailPekerja extends StatefulWidget {
  const CategoryDetailPekerja({super.key});

  @override
  State<CategoryDetailPekerja> createState() => _CategoryDetailPekerjaState();
}

class _CategoryDetailPekerjaState extends State<CategoryDetailPekerja> {
  String textCat = "kosong";
  bool Clicked = true;

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
  final TextEditingController syaratC =
      TextEditingController(text: "${Get.parameters["syarat"]}");
  final TextEditingController sopC =
      TextEditingController(text: "${Get.parameters["sop"]}");
  final TextEditingController gajiC =
      TextEditingController(text: "${Get.parameters["gaji"]}");
  final TextEditingController contactC =
      TextEditingController(text: "${Get.parameters["kontak"]}");
  final TextEditingController imageC =
      TextEditingController(text: "${Get.parameters["image"]}");
  final TextEditingController categoryC =
      TextEditingController(text: "${Get.parameters["category"]}");

  var dataCat = [
    "default",
    "Health",
    "Entertainment",
    "Culinary",
    "Management",
    "Content Creator",
    "Law",
    "Otomotive",
    "Marketing",
    "Goverment",
  ];

  void changeText() {
    setState(() {
      textCat = dataCat[int.parse('${Get.parameters['category']}')];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeText();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (Clicked == false) {
      Clicked == false;
    } else {
      Clicked == true;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var idd = Get.parameters["idd"];
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
                onPressed: () async {
                  await DatabaseHelperr.instace
                      .add(FavoriteWorker(
                          id: int.parse(idd!),
                          nama: nameC.text,
                          lokasi: lokasiC.text,
                          jabatan: jabatanC.text,
                          descJabatan: descJabatanC.text,
                          keahlian: keahlianC.text,
                          descKeahlian: descKeahlianC.text,
                          syarat: syaratC.text,
                          gaji: gajiC.text,
                          sop: sopC.text,
                          kontak: contactC.text,
                          image: imageC.text,
                          category: int.parse(categoryC.text)))
                      .then((value) {
                    final snackBar = SnackBar(
                      duration: 3.seconds,
                      elevation: 0,
                      backgroundColor: Colors.greenAccent,
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
                icon: Icon(
                  (Clicked == false) ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                style: IconButton.styleFrom(
                  elevation: 5,
                ),
              ),
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
            Padding(
              padding: const EdgeInsets.only(right: 0, left: 0),
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 5,
                margin: EdgeInsets.only(right: 10, left: 10),
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
                                  '${Get.parameters["image"]}',
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
                            child: Text("${Get.parameters["name"]}",
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
                                      text: "Jabatan yang dicari: ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "${Get.parameters['jabatan']}",
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
                                  overflow: TextOverflow.clip,
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
                                                "${Get.parameters['desc_jabatan']}",
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
                                            text: "${Get.parameters['lokasi']}",
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
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: "Keahlian yang diperlukan: ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "${Get.parameters['keahlian']}",
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
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(
                                        text: "Deskripsi Keahlian: ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                              text:
                                                  "${Get.parameters['desc_keahlian']}",
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
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(
                                        text: "SOP: ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: "${Get.parameters['sop']}",
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
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(
                                        text: "Gaji: ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: "${Get.parameters['gaji']}",
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
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(
                                        text: "Syarat: ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                              text:
                                                  "${Get.parameters['syarat']}",
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
                                      text: "Kontak: ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "${Get.parameters['kontak']}",
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
                                      text: "Bidang: ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: textCat,
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
                        elevation: 5, backgroundColor: Colors.greenAccent),
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
