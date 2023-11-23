import 'package:get/get.dart';

import '../controllers/apg_controller.dart';

class ApgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApgController>(
      () => ApgController(),
    );
  }
}
