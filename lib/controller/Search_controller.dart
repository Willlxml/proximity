import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/controller/Worker_controller.dart';

class SearchController extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios_new));
  }

    final controller = Get.put(WorkerController());
    List<dynamic> users = [];
    Future<dynamic>? userData;
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder( 
        future: controller.getFetchData(query: query),
        builder: (context, snapshot) {
          // making loading screen
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: users.length,
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
                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: ListTile(
                        leading:
                            CircleAvatar(backgroundImage: NetworkImage(image)),
                        title: Text(nama),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        subtitle: Text(jabatan),
                        onTap: () {
                          Get.toNamed(
                              '/kategoriDetail/:id?idd=$id&name=$nama&lokasi=$lokasi&jabatan=$jabatan&desc_jabatan=$descJabatan&keahlian=$keahlian&desc_keahlian=$descKeahlian&pendidikan=$pendidikanTerakhir&pengalaman_kerja=$pengalaman&kontak=$kontak&image=$image',
                              arguments: users);
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search Workers"),
    );
  }
}
