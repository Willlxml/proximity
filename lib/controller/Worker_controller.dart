import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/model/worker.dart';
import 'package:http/http.dart' as http;

class WorkerController extends GetxController {
  List<Workerrr> _allWorkers = [];
  List<Datum> _allDatum = [];
  List<Datum> get allDatum => _allDatum;
  List<Workerrr> get allWorkers => _allWorkers;

  Future getData() async {
    var response =
        await http.get(Uri.parse('http://103.179.86.77:4567/api/pekerja'));
    // var dataResponseString = jsonDecode(response.body).toString();
    String responseString = response.body;
    var dataResponse = jsonDecode(responseString) as Map<String, dynamic>;
    dataResponse.forEach(
      (key, value) {
        _allDatum.add(
          Datum(
            id: key,
            namaLengkap: value["nama"],
            lokasi: value["lokasi"],
            jabatan: value["jabatan"],
            descJabatan: value["desc_jabatan"],
            keahlian: value["keahlian"],
            descKeahlian: value["desc_keahlian"],
            pendidikanTerakhir: value["pendidikan_terakhir"],
            pengalamanKerja: value["pengalaman_kerja"],
            kontak: value["kontak"],
            image: value["image"],
          ),
        );
      },
    );
    print("Masuk List");
  }
}
