import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music_flutter/app/commonWidgets/NeteaseBottomSheet.dart';
import 'package:cloud_music_flutter/app/services/ScreenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/music_player_controller.dart';

class MusicPlayerView extends GetView<MusicplayerController> {
  const MusicPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedPositioned(
          bottom: Adaptive.height(controller.bottom.value),
          left: 0,
          right: 0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          child: Visibility(
              visible: controller.isShowPlayer.value,
              child: SizedBox(
                width: Adaptive.getScreenWidth(),
                height: Adaptive.height(controller.height),
                child: Scaffold(
                  body: ListTile(
                    onTap: () {
                      Get.toNamed('/play-detail', arguments: {
                        "url": controller.url,
                      });
                    },
                    contentPadding: EdgeInsets.only(left: Adaptive.width(24)),
                    leading: CircleAvatar(
                      radius: Adaptive.height(68),
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(controller.cover.value),
                    ),
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.name.value,
                          maxLines: 1,
                          style: TextStyle(fontSize: Adaptive.fs(40), overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          controller.artist.value,
                          maxLines: 1,
                          style: TextStyle(fontSize: Adaptive.fs(26), overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          color: Colors.black54,
                          onPressed: () {
                            controller.handlePlay();
                          },
                          icon: Icon(
                            controller.isPlaying.value
                                ? Icons.pause_circle_outlined
                                : Icons.play_circle_outline_outlined,
                          ),
                        ),
                        IconButton(
                          color: Colors.black54,
                          onPressed: () {
                            NeteaseBottomSheet.show();
                          },
                          icon: const Icon(
                            Icons.queue_music_outlined,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )));
    });
  }
}
