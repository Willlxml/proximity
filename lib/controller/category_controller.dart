import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:proximity/model/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController extends GetxController {

  Future<List<dynamic>> getCategory() async {
    final url = Uri.parse('http://103.179.86.77:4567/api/category/');
    final pref = await SharedPreferences.getInstance();
    final tokens = pref.getString('token');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $tokens'});

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
