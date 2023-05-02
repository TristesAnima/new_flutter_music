import 'package:get/get.dart';

import '../modules/bottom_nav/bindings/bottom_nav_binding.dart';
import '../modules/bottom_nav/views/bottom_nav_view.dart';
import '../modules/play_detail/bindings/play_detail_binding.dart';
import '../modules/play_detail/views/play_detail_view.dart';
import '../modules/theme/bindings/theme_binding.dart';
import '../modules/theme/views/theme_view.dart';
import '../routerAnimation/NeteaseTransition.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.BOTTOM_NAV;

  static final routes = [
    GetPage(
      name: _Paths.BOTTOM_NAV,
      page: () => const BottomNavView(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: _Paths.THEME,
      page: () => const ThemeView(),
      binding: ThemeBinding(),
      transitionDuration: const Duration(milliseconds: 350),
      customTransition: NeteaseTransition(),
    ),
    GetPage(
      name: _Paths.PLAY_DETAIL,
      page: () => const PlayDetailView(),
      binding: PlayDetailBinding(),
      transitionDuration: const Duration(milliseconds: 300),
      customTransition: NeteaseTransition(),
    ),
  ];
}
