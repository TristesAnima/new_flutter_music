import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music_flutter/app/modules/music_player/controllers/music_player_controller.dart';
import 'package:cloud_music_flutter/app/services/Audio.dart';
import 'package:cloud_music_flutter/app/services/ScreenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/RandColor.dart';
import '../controllers/play_detail_controller.dart';

class PlayDetailView extends GetView<PlayDetailController> {
  const PlayDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final findMusicplayerController = Get.find<MusicplayerController>();
        return Stack(
          children: [
            // 背景图片
            Transform.scale(
              scale: 1,
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft, end: Alignment.bottomRight, colors: RandColor.getRandColor()))),
            ),
            // 模糊背景
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            // AppBar
            AppBar(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.name.value,
                    maxLines: 1,
                    style: TextStyle(fontSize: Adaptive.fs(38), overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    controller.artists.value,
                    maxLines: 1,
                    style: TextStyle(fontSize: Adaptive.fs(30), overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              // 将AppBar的背景色设置为透明
              elevation: 0,
              // 隐藏AppBar的阴影
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                iconSize: Adaptive.fs(80),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.share_outlined),
                  iconSize: Adaptive.fs(56),
                ),
              ],
            ),
            // 页面内容
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: Adaptive.width(580),
                    height: Adaptive.height(580),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.7)),
                  ),
                  Container(
                    width: Adaptive.width(420),
                    height: Adaptive.height(420),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CachedNetworkImage(
                      imageUrl: controller.coverUrl.value,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: Adaptive.height(32),
                      left: 0,
                      right: 0,
                      height: Adaptive.height(480),
                      child: Wrap(
                        runSpacing: Adaptive.height(16),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(onPressed: () {}, icon: const Icon(Icons.heart_broken_rounded)),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.file_download_outlined)),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.category)),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.message_outlined)),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Adaptive.width(40)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  findMusicplayerController.currentTextTime.value,
                                  style: TextStyle(fontSize: Adaptive.fs(32)),
                                ),
                                Expanded(
                                    child: SliderTheme(
                                  data: SliderThemeData(
                                    thumbColor: Colors.white,
                                    trackHeight: Adaptive.height(3),
                                    // 设置Slider轨道的高度
                                    inactiveTrackColor: Colors.white.withOpacity(0.5),
                                    activeTrackColor: Colors.white,
                                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: Adaptive.height(8)),
                                  ),
                                  child: Slider(
                                      value: findMusicplayerController.sliderCurrentValue.value,
                                      min: 0.0,
                                      max: findMusicplayerController.sliderEndDuration.value,
                                      onChanged: (newValue) async {
                                        await Audio.seekToSec(Duration(milliseconds: (newValue * 1000).round()));
                                        findMusicplayerController.sliderCurrentValue.value =
                                            double.parse(newValue.toStringAsFixed(0));
                                      }),
                                )),
                                Text(
                                  findMusicplayerController.endTextTime.value,
                                  style: TextStyle(fontSize: Adaptive.fs(32)),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.skip_previous,
                                    color: Colors.black45,
                                    size: Adaptive.fs(80),
                                  )),
                              IconButton(
                                onPressed: () {
                                  findMusicplayerController.isPlaying.value
                                      ? Audio.pause()
                                      : Audio.play(controller.url);
                                },
                                icon: Icon(
                                  findMusicplayerController.isPlaying.value
                                      ? Icons.pause_circle_outlined
                                      : Icons.play_circle_outline_outlined,
                                  color: Colors.black45,
                                  size: Adaptive.fs(100),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.skip_next,
                                    color: Colors.black45,
                                    size: Adaptive.fs(80),
                                  ))
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
