import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/colors/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CategoryPageWorker extends StatefulWidget {
  @override
  State<CategoryPageWorker> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPageWorker> {
  List<dynamic> users = [];
  Future<dynamic>? userData;
  bool isIniate = true;

  Future fetchUsers({int maxRetries = 5}) async {
    // Get Data
    final id = Get.arguments[0];
    final pref = await SharedPreferences.getInstance();
    final tokens = await pref.getString('token');
    int retryCount = 0;
    while (retryCount < maxRetries) {
      Uri url = Uri.parse('http://103.179.86.77:4567/api/listmitra?category=$id');
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $tokens'});
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchUsers();
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
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: IconButton(
          //       onPressed: () {
          //         showSearch(context: context, delegate: SearchController());
          //       },
          //       icon: Icon(Icons.search, color: Colors.black)),
          // )
        ],
        title: Text("List Company"),
      ),
      body: FutureBuilder(
        future: userData,
        builder: (context, snapshot) {
          // making loading screen
          // var data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if(!snapshot.hasData){
            return Center(child: Text("Empty"),);
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
                              '/kategoriDetailWorker/:id?idd=$id&name=$nama&lokasi=$lokasi&jabatan=$jabatan&desc_jabatan=$descJabatan&keahlian=$keahlian&desc_keahlian=$descKeahlian&syarat=$syarat&gaji=$gaji&sop=$sop&kontak=$kontak&image=$image&category=$category',
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
      ),
    );
  }
}
