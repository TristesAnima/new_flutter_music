import 'package:cloud_music_flutter/app/services/Audio.dart';
import 'package:get/get.dart';

class PlayDetailController extends GetxController {
  String url = '';

  @override
  void onInit() {
    super.onInit();
    Audio.audioPlayer.setSourceUrl(Get.arguments["url"]);
    url = Get.arguments["url"];
  }

  @override
  void onClose() {
    super.onClose();
  }
}
