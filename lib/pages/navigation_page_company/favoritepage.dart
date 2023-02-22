import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:proximity/controller/databasehelper.dart';
import 'package:proximity/model/favorite.dart';
import 'package:sqflite/sqflite.dart';
import '../../colors/color.dart';

class FavoritePageCompany extends StatefulWidget {
  @override
  State<FavoritePageCompany> createState() => _FavoritePageCompanyState();
}

class _FavoritePageCompanyState extends State<FavoritePageCompany> {
  // final controller = Get.put(FavouriteController());
  @override
  void initState() {
    // TODO: implement initState
    DatabaseHelper.instace.getFavorite();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final fav = controller.favorite;
    return Scaffold(
      backgroundColor: skyBlue,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        centerTitle: true,
        leading: Container(),
        backgroundColor: Colors.white,
        title: Text(
          "Favorite",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Favorite>>(
          future: DatabaseHelper.instace.getFavorite(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Favorite>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.map((favorite) {
                final id = favorite.id;
                final nama = favorite.namaLengkap;
                final lokasi = favorite.lokasi;
                final jabatan = favorite.jabatan;
                final descJabatan = favorite.descJabatan;
                final keahlian = favorite.keahlian;
                final descKeahlian = favorite.descKeahlian;
                final pendidikanTerakhir = favorite.pendidikanTerakhir;
                final pengalaman = favorite.pengalamanKerja;
                final kontak = favorite.kontak;
                final image = favorite.image;
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        onTap: () {
                          Get.toNamed('/favoriteDetail/', arguments: [
                            id,
                            nama, // 1
                            lokasi, // 2
                            jabatan, // 3
                            descJabatan, // 4
                            keahlian, // 5
                            descKeahlian, // 6
                            pendidikanTerakhir, // 7
                            pengalaman, // 8
                            kontak, // 9
                            image // 10
                          ])!.then((v) {
                            setState(() {
                              
                            });
                          });
                          print(favorite.pendidikanTerakhir);
                        },
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(favorite.image!)),
                        title: Text(favorite.namaLengkap!),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        subtitle: Text(favorite.jabatan!),
                        trailing: IconButton(
                          onPressed: () async {
                            setState(() {
                              DatabaseHelper.instace
                                  .remove(favorite.id!)
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentMaterialBanner()
                                  ..showSnackBar(snackBar);
                              });
                            });
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          style: IconButton.styleFrom(
                            elevation: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
