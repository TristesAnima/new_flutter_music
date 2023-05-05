import 'package:cloud_music_flutter/app/services/Audio.dart';
import 'package:get/get.dart';
import '../../music_player/controllers/music_player_controller.dart';

class PlayDetailController extends GetxController {
  final findMusicplayerController = Get.find<MusicplayerController>();

  String url = '';

  changePlayMode() {
    findMusicplayerController.setPlayMode(findMusicplayerController.playmode.value == 0 ? 1 : 0);
  }

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
