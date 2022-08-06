import 'dart:convert';
import 'dart:math';

import 'package:alquran_app/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailSurahController extends GetxController {
  // Get detail surah
  Future<DetailSurah> getDetaillSurah(String id) async {
    var res =
        await http.get(Uri.parse("http://api.alquran.cloud/v1/surah/$id"));
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }
}
