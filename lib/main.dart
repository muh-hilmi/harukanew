import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:harukanew/app/controllers/page_index_controller.dart';
import 'package:harukanew/app/data/data_apg.dart';
import 'package:harukanew/app/data/data_awg.dart';

import 'app/routes/app_pages.dart';

void main() {
  // ignore: unused_local_variable
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final apg = Get.put(APG());
  final awg = Get.put(AWG());
  final pageindex = Get.put(PageIndexController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Haruka",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
