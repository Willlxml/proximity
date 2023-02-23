import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:proximity/pages/landingpage_worker.dart';
import 'package:proximity/pages/login.dart';
import 'package:proximity/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String? _token;

  String? get bearer{
    if (_token != null){
      return _token!;
    }else{
      return null;
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
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
      // jika berhasil
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 0) {
           _token = responseData['token'];
          print(_token);
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', _token!);

          Get.offAll(LandingPageWorker());

        } else {
          throw jsonDecode(response.body)["message"];
        }
      } else {
        // invalid response
        Get.back();
        showDialog(context: Get.context!, builder: (context) {
          return SimpleDialog(
            title: Text("Error"),
            contentPadding: EdgeInsets.all(20),
            children: [Text("Login Failed Email Or Password Invalid")],
          );
        });
      }
    } catch (error) {
      // jika error
      showDialog(context: Get.context!, builder: (context) {
        return SimpleDialog(
          title: Text("Error"),
          contentPadding: EdgeInsets.all(20),
          children: [Text("Login Failed, Email Or Password Invalid")],
        );
      });
    }
  }

  Future <void> Logout() async {
    // menghapus token dari local state
    final pref = await SharedPreferences.getInstance();
    _token = '';
    final tokens = pref.remove('token');
    print(_token);

  }
}

