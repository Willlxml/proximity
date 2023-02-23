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

class LoginController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String? _token, role, nama, emaill;

  String? get bearer {
    if (_token != null) {
      return _token!;
    } else {
      return null;
    }
  }

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

      // jika email tidak ditemukan
      if (response.statusCode >= 300 && response.statusCode < 500) {
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
                  "Email not found, Please try again!",
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
          await prefs?.setString('role', role!);
          await prefs?.setString('token', _token!);
          await prefs?.setString('email', emaill!);
          await prefs?.setString('nama', nama!);
          // menentukan role
          if (role! == 'pekerja') {
            Get.off(LandingPageWorker());
          } else {
            Get.off(LandingPageCompany());
          }
        } else {
          throw jsonDecode(response.body)["message"];
        }
      } 
    } catch (error) {
      // jika terjadi error
      print(error);
    }
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
      _token = '';
      pref.clear();
    } else {
      throw Exception('gagal logout');
    }
  }
}
