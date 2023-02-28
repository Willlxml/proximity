import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proximity/model/worker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddPageWorkerController extends GetxController {
  List<Workerrr> _allWorkers = [];

  List<Workerrr> get allWorkers => _allWorkers;

  Future<Map<String, dynamic>> addWorker(
      String nama,
      String location,
      String jabatan,
      String desc_jabatan,
      String keahlian,
      String desc_keahlian,
      String pengalaman,
      String kontak,
      String pendidikanTerakhir,
      String category,
      File image,
      BuildContext context) async {
    Uri url =
        Uri.parse(
          // "https://webhook.site/2b52220e-c683-44a3-95f4-095908cb11a3"
            "http://103.179.86.77:4567/api/pekerjacreate",
            );
    final pref = await SharedPreferences.getInstance();
    final tokens = pref.getString('token');
    Map<String, String> headers = {'Authorization' : 'Bearer $tokens'};
  


    final UploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', image.path);
    

    UploadRequest.headers.addAll(headers);
    UploadRequest.fields["nama_lengkap"] = nama;
    UploadRequest.fields["lokasi"] = location;
    UploadRequest.fields["jabatan"] = jabatan;
    UploadRequest.fields["desc_jabatan"] = desc_jabatan;
    UploadRequest.fields["keahlian"] = keahlian;
    UploadRequest.fields["desc_keahlian"] = desc_keahlian;
    UploadRequest.fields["pendidikan_terakhir"] = pendidikanTerakhir;
    UploadRequest.fields["pengalaman_kerja"] = pengalaman;
    UploadRequest.fields["kontak"] = kontak;
    UploadRequest.fields["category_id"] = category;
    UploadRequest.files.add(file);

    final StreamedResponse = await UploadRequest.send();
    final response = await http.Response.fromStream(StreamedResponse);
    if (response.statusCode == 201) {
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(Icons.info, color: Colors.white,),
            SizedBox(width: 10,),
            Text("Your data successfully uploaded!", style: TextStyle(fontWeight: FontWeight.w600),),
          ],
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    } else {
      print(response.statusCode);
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(Icons.info, color: Colors.white,),
            SizedBox(width: 10,),
            Text("Failed to upload your data", style: TextStyle(fontWeight: FontWeight.w600),),
          ],
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    return responseData;
  }
}
