import 'dart:convert';

import 'package:alquran_app/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  var res = await http.get(Uri.parse("http://api.alquran.cloud/v1/surah"));

  var data = (json.decode(res.body) as Map<String, dynamic>)["data"];

  // data dari API (raw data) -> model yang sudah kita siapkan
  Surah dataSurah = Surah.fromJson(data[0]);
  print(dataSurah.name);
}
