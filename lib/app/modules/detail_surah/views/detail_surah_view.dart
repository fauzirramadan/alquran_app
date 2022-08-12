import 'package:alquran_app/app/data/models/detail_surah.dart';
import 'package:alquran_app/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final MyTabController _tabx = Get.put(MyTabController());

  DetailSurahView({Key? key}) : super(key: key);
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Card(
              color: Colors.brown[400],
              child: Container(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Text(
                      "${surah.englishName}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "(${surah.englishNameTranslation})",
                      style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 16,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "${surah.numberOfAyahs} verses | ${surah.revelationType}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBar(
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              unselectedLabelColor: Colors.grey,
              controller: _tabx.controller,
              tabs: _tabx.myTabs,
              indicatorColor: Colors.brown[300],
              labelColor: Colors.black,
            )),
            SizedBox(
              height: 470,
              child: Expanded(
                child: TabBarView(
                    controller: _tabx.controller,
                    children: _tabx.myTabs.map(
                      (Tab tab) {
                        final String label = tab.text ?? "";
                        if (label == 'Arabic') {
                          return arabDetail();
                        }
                        return Container();
                      },
                    ).toList()),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget arabDetail() {
    return Container(
      child: FutureBuilder<DetailSurah>(
          future: controller.getDetaillSurah(surah.number.toString()),
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
            return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: surah.numberOfAyahs ?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.brown[200],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.brown,
                                child: Text("${index + 1}"),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.bookmark_add_outlined)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.play_arrow)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "${snapshot.data!.ayahs![index].text}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.ltr,
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  );
                });
          }),
    );
  }
}

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Arabic',
    ),
    const Tab(text: 'Translation'),
  ];

  TabController? controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}
