

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:proximity/colors/color.dart';
import 'package:proximity/controller/Company_controller.dart';
import 'package:proximity/pages/navigation_page_company/edit_page/editpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPageMitra extends StatefulWidget {
  const ListPageMitra({super.key});

  @override
  State<ListPageMitra> createState() => _ListPageMitraState();
}

class _ListPageMitraState extends State<ListPageMitra> {
   final controller = Get.put(CompanyController());
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

    Future fetchUsers({int maxRetries = 5}) async {
    // Get Data
    final pref = await SharedPreferences.getInstance();
    final tokens = await pref.getString('token');
    int retryCount = 0;
    while (retryCount < maxRetries) {
      Uri url = Uri.parse('http://103.179.86.77:4567/api/mitra');
      final response = await http.get(url, headers: {'Authorization': 'Bearer $tokens'} );
      if (response.statusCode >= 200 && response.statusCode < 300) {
          final json = jsonDecode(response.body);
          setState(() {
            users = json['data'];
          });
          return response;
      } else {
        await Future.delayed(Duration(seconds: 3));
        retryCount++;
        print(retryCount);
      }
    }
    throw Exception('Failed to get response after $maxRetries retries.');
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
        title: Text("Edit Company"),
      ),
      body: FutureBuilder(
          future: userData,
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
                  final nama = user['nama'];
                  final lokasi = user['lokasi'];
                  final jabatan = user['jabatan'];
                  final descJabatan = user['desc_jabatan'];
                  final keahlian = user['keahlian'];
                  final descKeahlian = user['desc_keahlian'];
                  final syarat = user['syarat'];
                  final sop = user['sop'];
                  final category = user['category_id'];
                  final gaji = user['gaji'];
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
                            Get.off(EditPageCompany(), arguments: [
                              id, // 0
                              nama, // 1
                              lokasi, // 2
                              jabatan, // 3
                              descJabatan, // 4
                              keahlian, // 5
                              descKeahlian, // 6
                              syarat, // 7
                              gaji, // 8
                              sop, // 9
                              kontak, // 10
                              image, // 11
                              category, // 12
                            ])!.then((value) {
                              setState(() {
                                
                              });
                            });
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