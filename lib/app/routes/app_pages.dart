import 'package:get/get.dart';
import 'package:harukanew/app/views/views/apg_detail_view.dart';
import 'package:harukanew/app/views/views/awg_detail_view.dart';

import '../modules/apg/bindings/apg_binding.dart';
import '../modules/apg/views/apg_view.dart';
import '../modules/awg/bindings/awg_binding.dart';
import '../modules/awg/views/awg_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => ApgView(),
      binding: ApgBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.AWG,
      page: () => AwgView(),
      binding: AwgBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.APG_DETAIL,
      page: () => ApgDetailView(),
    ),
    GetPage(
      name: _Paths.AWG_DETAIL,
      page: () => AwgDetailView(),
    ),
  ];
}
