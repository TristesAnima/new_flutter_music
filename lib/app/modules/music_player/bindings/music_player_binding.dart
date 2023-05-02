import 'package:get/get.dart';

import '../controllers/music_player_controller.dart';

class MusicplayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusicplayerController>(
      () => MusicplayerController(),
    );
  }
}
