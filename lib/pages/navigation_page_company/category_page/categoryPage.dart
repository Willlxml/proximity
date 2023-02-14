import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/model/worker.dart';
import 'package:proximity/controller/Worker_controller.dart';
import 'package:http/http.dart' as http;

class CategoryPageMitra extends StatefulWidget {
  @override
  State<CategoryPageMitra> createState() => _CategoryPageMitraState();
}

class _CategoryPageMitraState extends State<CategoryPageMitra> {
  final controller = Get.put(WorkerController());
  List<dynamic> users = [];
  bool isIniate = true;
 
  @override
  void didChangeDependencies() {
    if (isIniate){
      fetchUsers();
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
  
  
  void fetchUsers() async {
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
      appBar: AppBar(
        title: Text("List Worker"),
      ),
      body: ListView.builder(
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
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(image)),
            title: Text(nama),
            subtitle: Text(jabatan),
            onTap: () {
              Get.toNamed(
                  '/kategoriDetail/:id?idd=$id&name=$nama&lokasi=$lokasi&jabatan=$jabatan&desc_jabatan=$descJabatan&keahlian=$keahlian&desc_keahlian=$descKeahlian&pendidikan=$pendidikanTerakhir&pengalaman_kerja=$pengalaman&kontak=$kontak&image=$image');
            },
          );
        },
      ),
    );
  }
}
