import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/company.dart';

class AddPageCompanyController extends GetxController {

  Future<Map<String, dynamic>> addCompany(
      File image,
      String nama,
      String location,
      String jabatan,
      String desc_jabatan,
      String keahlian,
      String desc_keahlian,
      String syarat,
      String gaji,
      String sop,
      String contact,
      String category,
      BuildContext context) async {
    Uri url = Uri.parse(
      // "https://webhook.site/2b52220e-c683-44a3-95f4-095908cb11a3"
      "http://103.179.86.77:4567/api/mitrapost"
    );
    final UploadRequest = http.MultipartRequest('POST', url);

    final pref = await SharedPreferences.getInstance();
    final tokens = pref.getString('token');
    Map<String, String> headers = {'Authorization': 'Bearer $tokens'};

    final FileFolder = await http.MultipartFile.fromPath('file', image.path);

    UploadRequest.headers.addAll(headers);
    UploadRequest.fields["nama"] = nama;
    UploadRequest.fields["lokasi"] = location;
    UploadRequest.fields["jabatan"] = jabatan;
    UploadRequest.fields["desc_jabatan"] = desc_jabatan;
    UploadRequest.fields["keahlian"] = keahlian;
    UploadRequest.fields["desc_keahlian"] = desc_keahlian;
    UploadRequest.fields["syarat"] = syarat;
    UploadRequest.fields["gaji"] = gaji;
    UploadRequest.fields["sop"] = sop;
    UploadRequest.fields["kontak"] = contact;
    UploadRequest.fields["category_id"] = category;
    UploadRequest.files.add(FileFolder);

    final StreamedResponse = await UploadRequest.send();
    final response = await http.Response.fromStream(StreamedResponse);
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Your data successfully uploaded!",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
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
        content: Row(
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Failed to upload your data",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
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
