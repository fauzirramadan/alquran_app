import 'package:alquran_app/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${surah.englishName}"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Card(
              color: Colors.brown[300],
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "${surah.englishName}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "(${surah.englishNameTranslation})",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
