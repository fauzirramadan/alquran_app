import 'dart:convert';

import 'package:alquran_app/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // Get All Surah
  Future<List<Surah>> getAllSurah() async {
    var res = await http.get(Uri.parse("http://api.alquran.cloud/v1/surah"));
    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

  // Get Detail Surah

}
