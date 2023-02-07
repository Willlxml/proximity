import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:proximity/model/worker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

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
      File image,
      BuildContext context) async{

    Uri url = Uri.parse(
      "https://webhook.site/2b52220e-c683-44a3-95f4-095908cb11a3",
    );
    final nameFile = basename(image.path);
    final UploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('image', image.path);

    UploadRequest.fields["nama_file"] = nameFile;
    UploadRequest.fields["nama_lengkap"] = nama;
    UploadRequest.fields["lokasi"] = location;
    UploadRequest.fields["jabatan"] = nama;
    UploadRequest.fields["desc_jabatan"] = desc_jabatan;
    UploadRequest.fields["keahlian"] = keahlian;
    UploadRequest.fields["desc_keahlian"] = desc_keahlian;
    UploadRequest.fields["pengalaman_kerja"] = pengalaman;
    UploadRequest.fields["kontak"] = kontak;
    UploadRequest.files.add(file);

    final StreamedResponse = await UploadRequest.send();
    final response = await http.Response.fromStream(StreamedResponse);
    if (response.statusCode == 200){
      print("Uploaded");
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    
    return responseData;
  }
}
