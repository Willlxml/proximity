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

  

  Future<List<Datum>> getFetchData({String? query}) async {
    Uri url = Uri.parse('http://103.179.86.77:4567/api/pekerja');
    final pref = await SharedPreferences.getInstance();
    String? tokens = pref.getString('token');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $tokens'});
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

  
}
