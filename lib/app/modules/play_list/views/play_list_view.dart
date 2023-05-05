import 'package:cloud_music_flutter/app/modules/play_list/views/widget/custome_appbar.dart';
import 'package:cloud_music_flutter/app/modules/play_list/views/widget/list.dart';
import 'package:cloud_music_flutter/app/services/ScreenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/Storage.dart';
import '../../music_player/controllers/music_player_controller.dart';
import '../controllers/play_list_controller.dart';

class PlayListView extends GetView<PlayListController> {
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const CustomeAppbar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Obx(() {
                return Ink(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () async {
                      final newList = controller.list.value.map((item) {
                        return {
                          ...item,
                          "uniId": item["id"],
                          "title": item["name"],
                          "artists": (item["ar"] as List).map((i) => i["name"]).toList().join('/'),
                          "coverUrl": item["al"]?["picUrl"]
                        };
                      }).toList();
                      await controller.findMusicplayerController.addAllToList(newList);
                    },
                    splashColor: Colors.grey.withOpacity(0.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: Adaptive.width(24), vertical: Adaptive.width(32)),
                          child: const Icon(
                            Icons.play_circle_filled_rounded,
                            color: Colors.red,
                          ),
                        ),
                        const Text("播放全部"),
                        Text(
                          controller.list.isEmpty ? "" : " (${controller.list.length})",
                          style: TextStyle(fontSize: Adaptive.fs(26), color: Colors.black.withOpacity(0.5)),
                        )
                      ],
                    ),
                  ),
                );
              })
            ]),
          ),
          const PlayTableListView(),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: Adaptive.height(Get.find<MusicplayerController>().height),
              )
            ]),
          )
          // Other slivers
        ],
      ),
    );
  }
}
