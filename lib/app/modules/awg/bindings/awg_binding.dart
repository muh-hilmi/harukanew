import 'package:get/get.dart';

import '../controllers/awg_controller.dart';

class AwgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AwgController>(
      () => AwgController(),
    );
  }
}
