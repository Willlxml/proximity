import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:proximity/pages/landingpage_company.dart';
import 'package:proximity/pages/landingpage_worker.dart';
import 'package:proximity/pages/login.dart';
import 'package:proximity/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors/color.dart';

class LoginController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String? _token, role, nama, emaill;



  Future<void> loginWithEmail(
      String email, String password, BuildContext context) async {
    Map<String, String> headers = {
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginEmail);
      final request = http.MultipartRequest('POST', url);
      // request
      request.fields["email"] = email;
      request.fields["password"] = password;
      // request send
      final streamres = await request.send();
      final response = await http.Response.fromStream(streamres);
      print(response.body);

      // jika email tidak ditemukan
      if (response.statusCode == 302) {
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
                  "Invalid email or password, Please try again!",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ));
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(snackBar);
      }
      // jika berhasil
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        if (responseData['message'] == 'Success') {
          _token = responseData['token'];
          role = responseData['data']['role'];
          emaill = responseData['data']['email'];
          nama = responseData['data']['nama'];
          final SharedPreferences? prefs = await _prefs;
          await saveToken(_token!);
          await SaveData(role!, emaill!, nama!);
          prefs?.reload();
          // menentukan role
          if (role! == 'pekerja') {
            Get.off(LandingPageWorker());
            final snackBar = SnackBar(
                duration: 3.seconds,
                elevation: 0,
                backgroundColor: Colors.blue,
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
                      "Successfully logged in as Pekerja",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ));
            ScaffoldMessenger.of(context)
              ..hideCurrentMaterialBanner()
              ..showSnackBar(snackBar);
          } else {
            Get.off(LandingPageCompany());
            final snackBar = SnackBar(
                duration: 3.seconds,
                elevation: 0,
                backgroundColor: Colors.amber,
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
                      "Successfully logged in as Mitra",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ));
            ScaffoldMessenger.of(context)
              ..hideCurrentMaterialBanner()
              ..showSnackBar(snackBar);
          }
        } else {
          throw jsonDecode(response.body)["message"];
        }
      } else {}
    } catch (error) {
      // jika terjadi error
      print(error);
    }
  }

  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
  }

  // Future<String> getAuthToken() async {
  //   final pref = await SharedPreferences.getInstance();
  //   final authToken = pref.getString('token');
  //   return authToken!;
  // }

  Future<void> SaveData(String role, String emaill, String nama) async{
    final pref = await SharedPreferences.getInstance();
    await pref.setString('nama', nama);
    await pref.setString('email', emaill);
    await pref.setString('role', role);
  }

  Future<void> removeAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('emaill');
  await prefs.remove('role');
  await prefs.remove('nama');
}


  Future<void> Logout() async {
    // menghapus token dari local state
    final pref = await SharedPreferences.getInstance();
    final tokens = pref.getString('token');
    // print(_token);
    // menghapus token dari server
    Uri url = Uri.parse('http://103.179.86.77:4567/api/logout');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $tokens'});
    if (response.statusCode >= 200 && response.statusCode < 300) {
     await removeAuthToken();
    } else {
      throw Exception('gagal logout');
    }
  }
}
