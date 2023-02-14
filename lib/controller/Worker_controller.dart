import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity/model/worker.dart';
import 'package:http/http.dart' as http;

class WorkerController extends GetxController {
  List<Workerrr> _allWorkers = [];
  List<Datum> _allDatum = [];
  List<Datum> get allDatum => _allDatum;
  List<Workerrr> get allWorkers => _allWorkers;

 
}
