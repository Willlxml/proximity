import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../model/company.dart';

class AddPageCompanyController extends GetxController {
  List<Company> _allCompanys = [];
  List<Company> get allCompanys => _allCompanys;

  Future<Map<String, dynamic>> addCompany(
      File file,
      File image,
      String nama,
      String location,
      String jabatan,
      String desc_jabatan,
      String keahlian,
      String desc_keahlian,
      String gaji,
      String sop,
      String contact) async {
    Uri url =
        Uri.parse("https://webhook.site/2b52220e-c683-44a3-95f4-095908cb11a3");
    final UploadRequest = http.MultipartRequest('POST', url);
    
    final imageFile = await http.MultipartFile.fromPath('image', image.path);
    final FileFolder = await http.MultipartFile.fromPath('file', file.path);

    UploadRequest.fields["nama"] = nama;
    UploadRequest.fields["lokasi"] = location;
    UploadRequest.fields["jabatan"] = jabatan;
    UploadRequest.fields["desc_jabatan"] = desc_jabatan;
    UploadRequest.fields["keahlian"] = keahlian;
    UploadRequest.fields["desc_keahlian"] = desc_keahlian;
    UploadRequest.fields["gaji"] = gaji;
    UploadRequest.fields["sop"] = sop;
    UploadRequest.fields["kontak"] = contact;
    UploadRequest.files.add(imageFile);
    UploadRequest.files.add(FileFolder);
    
    final StreamedResponse = await UploadRequest.send();
    final response = await http.Response.fromStream(StreamedResponse);
    if (response.statusCode == 201) {
      print("Succesfully uploaded");
    }else{
      print("Failed");
    }
    final Map<String, dynamic> responseData = json.decode(response.body);

    return responseData;
  }
}
