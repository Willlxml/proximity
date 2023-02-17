import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:proximity/controller/Favourite_controller.dart';
import '../../colors/color.dart';

class FavoritePageCompany extends StatefulWidget {
  @override
  State<FavoritePageCompany> createState() => _FavoritePageCompanyState();
}

class _FavoritePageCompanyState extends State<FavoritePageCompany> {
  List<dynamic> users = [];
  Future<dynamic>? userData;
  bool isIniate = true;
  final controller = Get.put(FavouriteController());
  @override
  void didChangeDependencies() {
    
    if (isIniate) {
    final fav = controller.favorite;
      // userData = fetchUsers();
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

  // Future fetchUsers() async {
  //   // Get Data
  //   Uri url = Uri.parse('http://103.179.86.77:4567/api/pekerja');
  //   final response = await http.get(url);
  //   final json = jsonDecode(response.body);
  //   setState(() {
  //     users = json['data'];
  //   });
  //   print(json);
  // }

  @override
  Widget build(BuildContext context) {
  final fav = controller.favorite;
    return Scaffold(
      backgroundColor: skyBlue,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        centerTitle: true,
        leading: Container(),
        backgroundColor: Colors.white,
        title: Text(
          "Favourite",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          // future: userData,
          builder: (context, snapshot) {
            // making loading screen
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: fav.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final id = user['id'];
                  final nama = user['nama_lengkap'];
                  final lokasi = user['lokasi'];
                  final jabatan = user['jabatan'];
                  final descJabatan = user['desc_jabatan'];
                  final keahlian = user['keahlian'];
                  final descKeahlian = user['desc_keahlian'];
                  final pendidikanTerakhir = user['pendidikan_terakhir'];
                  final pengalaman = user['pengalaman_kerja'];
                  final kontak = user['kontak'];
                  final image = user['image'];
                  final favo = fav[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: ListTile(
                          // leading: CircleAvatar(
                          //     backgroundImage: NetworkImage(image)),
                          title: Text(favo),
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          // subtitle: Text(jabatan),
                          onTap: () {
                            Get.toNamed(
                                '/kategoriDetail/:id?idd=$id&name=$nama&lokasi=$lokasi&jabatan=$jabatan&desc_jabatan=$descJabatan&keahlian=$keahlian&desc_keahlian=$descKeahlian&pendidikan=$pendidikanTerakhir&pengalaman_kerja=$pengalaman&kontak=$kontak&image=$image');
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
