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

  Future<void> loginWithEmail(String email, String password) async {
    Map<String, String> headers = {
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginEmail);

      final request = http.MultipartRequest('POST', url);

      request.fields["email"] = email;
      request.fields["password"] = password;

      final streamres = await request.send();
      final response = await http.Response.fromStream(streamres);
      final json = jsonDecode(response.body);
      print(json);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['status'] == 0) {
          var token = json['token'];
          print(token);
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);

          Get.offAll(LandingPageWorker());

        } else {
          throw jsonDecode(response.body)["message"];
        }
      } else {
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
      showDialog(context: Get.context!, builder: (context) {
        return SimpleDialog(
          title: Text("Error"),
          contentPadding: EdgeInsets.all(20),
          children: [Text("Login Failed, Email Or Password Invalid")],
        );
      });
    }
  }
}

