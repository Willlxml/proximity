

import 'dart:convert';

import 'package:get/get.dart';
import 'package:proximity/model/company.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CompanyController extends GetxController{
   var data = [];
  List<Datas> _allDatum = [];
  List<Datas> get allDatum => _allDatum;

  Datas selectById(String id) =>
      _allDatum.firstWhere((element) => element.id == id);

  Future<List<Datas>> getFetchData({String? query}) async {
    Uri url = Uri.parse('http://103.179.86.77:4567/api/mitra');
    final pref = await SharedPreferences.getInstance();
    String? tokens = pref.getString('token');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $tokens'});
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        data = json.decode(response.body);
        _allDatum = data.map((e) => Datas.fromJson(e)).toList();
        if (query != null) {
          _allDatum = allDatum
              .where((element) => element.nama
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