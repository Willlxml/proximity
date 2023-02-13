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
  @override
  void initState() {
    fetchUsers();
    // TODO: implement initState
    super.initState();
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
        title: Text("${Get.parameters}"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final nama = user['nama_lengkap'];
          final image = user['image'];
          final jabatan = user['jabatan'];
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(image)),
            title: Text(nama),
            subtitle: Text(jabatan),
          );
        },
      ),
    );
  }
}
