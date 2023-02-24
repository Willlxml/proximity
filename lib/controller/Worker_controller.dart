import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/model/worker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WorkerController extends GetxController {
  var data = [];
  List<Datum> _allDatum = [];
  List<Datum> get allDatum => _allDatum;

  Datum selectById(String id) =>
      _allDatum.firstWhere((element) => element.id == id);

  Future<Map<String, dynamic>> editUser(
      String id,
      String nama,
      String location,
      String jabatan,
      String desc_jabatan,
      String keahlian,
      String desc_keahlian,
      String pengalaman,
      String kontak,
      String pendidikanTerakhir,
      BuildContext context) async {
    Uri url = Uri.parse('http://103.179.86.77:4567/api/pekerjaupdate/');

    final pref = await SharedPreferences.getInstance();
    String? tokens = pref.getString('token');
    final UploadRequest = http.MultipartRequest('PATCH', url);
    // final file = await http.MultipartFile.fromPath('file', image.path);

    UploadRequest.headers["authorization"] = tokens!;
    UploadRequest.fields["nama_lengkap"] = nama;
    UploadRequest.fields["lokasi"] = location;
    UploadRequest.fields["jabatan"] = jabatan;
    UploadRequest.fields["desc_jabatan"] = desc_jabatan;
    UploadRequest.fields["keahlian"] = keahlian;
    UploadRequest.fields["desc_keahlian"] = desc_keahlian;
    UploadRequest.fields["pendidikan_terakhir"] = pendidikanTerakhir;
    UploadRequest.fields["pengalaman_kerja"] = pengalaman;
    UploadRequest.fields["kontak"] = kontak;
    // UploadRequest.files.add(file);

    final StreamedResponse = await UploadRequest.send();
    final response = await http.Response.fromStream(StreamedResponse);
    if (response.statusCode == 201) {
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text("Your data successfully uploaded"),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Text("Failed to upload your data"),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    }
    final Map<String, dynamic> responseData = json.decode(response.body);

    return responseData;
  }

  Future<List<Datum>> getFetchData({String? query}) async {
    Uri url = Uri.parse('http://103.179.86.77:4567/api/pekerja');
    final pref = await SharedPreferences.getInstance();
    String? tokens = pref.getString('token');
    final response = await http.get(url, headers: {'Authorization': 'Bearer $tokens'});
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        _allDatum = data.map((e) => Datum.fromJson(e)).toList();
        if (query != null) {
          _allDatum = allDatum
              .where((element) => element.namaLengkap
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('api error');
      }
    } on Exception catch (e) {
      print('error : $e');
    }
    return _allDatum;
  }

  Future<void> delete(String id) async {
    final pref = await SharedPreferences.getInstance();
    final tokens = pref.getString('token');
    Uri url = Uri.parse(
      "http://103.179.86.77:4567/api/pekerjadelete",
    );
    return http.delete(url, headers: {'Authorization' : 'Bearer $tokens'}).then(
      (response) {
        _allDatum.removeWhere((element) => element.id == id);
      },
    );
  }
}
