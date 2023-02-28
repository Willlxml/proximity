import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/colors/color.dart';
import 'package:proximity/controller/databasehelperr.dart';
import 'package:proximity/model/favoriteworker.dart';
import 'package:proximity/pages/navigation_page_worker/favoritedetail.dart';

class FavoritePageWorker extends StatefulWidget {
  @override
  State<FavoritePageWorker> createState() => _FavoritePageWorkerState();
}

class _FavoritePageWorkerState extends State<FavoritePageWorker> {

  @override
  void initState() {
    // TODO: implement initState
    DatabaseHelperr.instace.getFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        child: FutureBuilder<List<FavoriteWorker>>(
          future: DatabaseHelperr.instace.getFavorite(),
          builder:
              (BuildContext context, AsyncSnapshot<List<FavoriteWorker>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Empty data"),
              );
            }
            return ListView(
              children: snapshot.data!.map((favorite) {
                final id = favorite.id;
                final nama = favorite.nama;
                final lokasi = favorite.lokasi;
                final jabatan = favorite.jabatan;
                final descJabatan = favorite.descJabatan;
                final keahlian = favorite.keahlian;
                final descKeahlian = favorite.descKeahlian;
                final sop = favorite.sop;
                final gaji = favorite.gaji;
                final syarat = favorite.syarat;
                final kontak = favorite.kontak;
                final image = favorite.image;
                final category = favorite.category;
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(FavoriteDetailWorker(), arguments: [
                            id, // 0
                            nama, // 1
                            lokasi, // 2
                            jabatan, // 3
                            descJabatan, // 4
                            keahlian, // 5
                            descKeahlian, // 6
                            sop, // 7
                            gaji, // 8
                            syarat, // 9
                            kontak, // 10
                            image, // 11
                            category, // 12
                          ])!.then((v) {
                            setState(() {
                              
                            });
                          });
                        },
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(favorite.image!)),
                        title: Text(favorite.nama!),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        subtitle: Text(favorite.jabatan!),
                        trailing: IconButton(
                          onPressed: () async {
                            setState(() {
                              DatabaseHelperr.instace
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
