import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class AddPageCompanyController extends GetxController {
  void UploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      print(file);
    } else {
      print("File not found");
      // User canceled the picker
    }
  }
}
