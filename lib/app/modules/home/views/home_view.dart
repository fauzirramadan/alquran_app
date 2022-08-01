import 'package:alquran_app/app/data/models/surah.dart';
import 'package:alquran_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[400],
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.brown[500],
        title: const Text("My Qur'an"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<List<Surah>>(
              future: controller.getAllSurah(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.grey,
                  ));
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Connection error"),
                  );
                }
                print(snapshot.data);
                return GridView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 1 / 1,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    Surah dataSurah = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_SURAH, arguments: dataSurah);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: dataSurah.number! % 2 == 0
                                ? Colors.brown[300]
                                : Colors.brown[500],
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: CircleAvatar(
                                  backgroundColor: dataSurah.number! % 2 == 1
                                      ? Colors.brown[300]
                                      : Colors.brown[400],
                                  child: Text(
                                    "${dataSurah.number}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                dataSurah.englishName ?? "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                dataSurah.englishNameTranslation ?? "",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              Text(
                                "${dataSurah.numberOfAyahs} ayahs | ${dataSurah.revelationType}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white60),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
