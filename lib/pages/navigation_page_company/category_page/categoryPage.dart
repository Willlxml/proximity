import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/model/worker.dart';
import 'package:proximity/controller/Worker_controller.dart';
import 'package:http/http.dart' as http;

import '../../../colors/color.dart';

class CategoryPageMitra extends StatefulWidget {
  @override
  State<CategoryPageMitra> createState() => _CategoryPageMitraState();
}

class _CategoryPageMitraState extends State<CategoryPageMitra> {
  final controller = Get.put(WorkerController());
  List<dynamic> users = [];
  Future<dynamic>? userData;
  bool isIniate = true;

  @override
  void didChangeDependencies() {
    if (isIniate) {
      userData = fetchUsers();
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

  Future fetchUsers() async {
    // Get Data
    Uri url = Uri.parse('http://103.179.86.77:4567/api/pekerja');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    setState(() {
      users = json['data'];
    });
    print(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: skyBlue,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
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
        title: Text("List Worker"),
      ),
      body: FutureBuilder(
        future: userData,
          builder: (context, snapshot) {
            // making loading screen
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else{
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
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(image)),
                          title: Text(nama),
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          subtitle: Text(jabatan),
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
