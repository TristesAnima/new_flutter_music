import 'package:cloud_music_flutter/app/modules/play_list/views/widget/custome_appbar.dart';
import 'package:cloud_music_flutter/app/modules/play_list/views/widget/list.dart';
import 'package:cloud_music_flutter/app/services/ScreenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
