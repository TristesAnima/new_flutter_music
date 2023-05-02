import 'package:cloud_music_flutter/app/modules/discovery/controllers/discovery_controller.dart';
import 'package:get/get.dart';

import '../controllers/bottom_nav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(
      () => BottomNavController(),
    );
    Get.lazyPut<DiscoveryController>(
      () => DiscoveryController(),
    );
  }
}
