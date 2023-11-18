import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:harukanew/app/data/data_apg.dart';

import 'app/routes/app_pages.dart';

void main() {
  // ignore: unused_local_variable
  final apg = Get.put(APG());
  runApp(
    GetMaterialApp(
      title: "Haruka",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
