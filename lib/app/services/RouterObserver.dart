import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/music_player/controllers/music_player_controller.dart';
import '../routes/app_pages.dart';

/// 监听路由变化
class MyRouteObserver extends NavigatorObserver {
  final musicController = Get.put(MusicplayerController());

  calcMusicPlayerBottom(String? name) {
    if (name == Routes.BOTTOM_NAV) {
      musicController.bottom.value = 160;
      musicController.isShowPlayer.value = true;
    } else if (name == Routes.PLAY_DETAIL) {
      musicController.isShowPlayer.value = false;
    } else {
      musicController.bottom.value = 0;
      musicController.isShowPlayer.value = true;
    }
  }

  /// 前进监听
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    calcMusicPlayerBottom(route.settings?.name);
  }

  /// 后退监听
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    calcMusicPlayerBottom(previousRoute?.settings?.name);
  }
}
