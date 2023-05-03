import 'package:cloud_music_flutter/app/commonWidgets/NeteaseSingleSong.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../music_player/controllers/music_player_controller.dart';
import '../../controllers/play_list_controller.dart';

class PlayTableListView extends GetView<PlayListController> {
  const PlayTableListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final item = controller.list[index];
            return NeteaseSingleSong(
              title: item["name"],
              subTitle: item?["al"]?["name"] ?? '',
              artist: item?["ar"]?.map((i) => i?["name"])?.join('/') ?? '',
              level: true,
              isVip: item['fee'] == 1,
              originCoverType: false,
              isMv: item?["mv"] != 0,
              onTap: () {
                Get.find<MusicplayerController>().setPlayConfig(
                  item['id'],
                  item['name'],
                  (item['ar'] as List).map((i) => i['name']).join('/'),
                  item['al']['picUrl'],
                );
              },
            );
          },
          childCount: controller.list.length,
        ),
      );
    });
  }
}
