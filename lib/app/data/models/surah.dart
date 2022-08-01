// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

import 'dart:convert';

Surah surahFromJson(String str) => Surah.fromJson(json.decode(str));

String surahToJson(Surah data) => json.encode(data.toJson());

// API URL = http://api.alquran.cloud/v1/surah
// Get seluruh surah Al-Quran

class Surah {
  Surah({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;
  String? revelationType;

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"] == null ? null : json["number"],
        name: json["name"] == null ? null : json["name"],
        englishName: json["englishName"] == null ? null : json["englishName"],
        englishNameTranslation: json["englishNameTranslation"] == null
            ? null
            : json["englishNameTranslation"],
        numberOfAyahs:
            json["numberOfAyahs"] == null ? null : json["numberOfAyahs"],
        revelationType:
            json["revelationType"] == null ? null : json["revelationType"],
      );

  Map<String, dynamic> toJson() => {
        "number": number == null ? null : number,
        "name": name == null ? null : name,
        "englishName": englishName == null ? null : englishName,
        "englishNameTranslation":
            englishNameTranslation == null ? null : englishNameTranslation,
        "numberOfAyahs": numberOfAyahs == null ? null : numberOfAyahs,
        "revelationType": revelationType == null ? null : revelationType,
      };
}
