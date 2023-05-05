import 'package:cloud_music_flutter/app/commonWidgets/NeteaseCard.dart';
import 'package:cloud_music_flutter/app/commonWidgets/Spin.dart';
import 'package:cloud_music_flutter/app/services/Format.dart';
import 'package:cloud_music_flutter/app/services/ScreenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../commonWidgets/NeteaseSingleSong.dart';
import '../../music_player/controllers/music_player_controller.dart';
import '../controllers/discovery_controller.dart';

class DiscoveryView extends GetView<DiscoveryController> {
  const DiscoveryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            height: Adaptive.height(100),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color.fromRGBO(250, 250, 250, 1)),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(Adaptive.width(34), 0, 4, 0),
                    child: const Icon(Icons.search, color: Colors.black26),
                  ),
                  Text(
                    'DiscoveryView',
                    style: TextStyle(fontSize: Adaptive.fs(38), color: Colors.black45),
                  ),
                ],
              ),
            ),
          ),
          titleTextStyle: const TextStyle(color: Colors.blueAccent),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('/theme');
                },
                icon: const Icon(
                  Icons.palette,
                  color: Colors.black54,
                ))
          ],
        ),
        body: Obx(() {
          return Spin(
              spining: controller.spining.value,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: Adaptive.height(Get.find<MusicplayerController>().height)),
                children: [
                  Container(
                    height: Adaptive.height(500),
                    color: Colors.white,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.recommendPlylists.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.recommendPlylists[index];
                        return NeteaseCard(
                          margin: EdgeInsets.all(Adaptive.width(16)),
                          coverImg: item["picUrl"],
                          playCount: Format.playCount(item["playcount"]),
                          title: item["name"],
                          onTap: () {
                            Get.toNamed('/play-list', arguments: {"id": item["id"]});
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  ...controller.list.map((item) {
                    return NeteaseSingleSong(
                      title: item['name'],
                      subTitle: item['al']['name'] ?? '',
                      artist: (item['ar'] as List).map((i) => i['name']).join('/'),
                      level: true,
                      isVip: item['fee'] == 1,
                      originCoverType: false,
                      isMv: item['mv'] != 0,
                      onTap: () {
                        Get.find<MusicplayerController>().setPlayConfig(
                          item['id'],
                          item['name'],
                          (item['ar'] as List).map((i) => i['name']).join('/'),
                          item['al']['picUrl'],
                        );
                        Get.find<MusicplayerController>().addSingleToList({
                          ...item,
                          "uniId": item["id"],
                          "title": item['name'],
                          "artists": (item['ar'] as List).map((i) => i['name']).join('/'),
                          "coverUrl": item["al"]["picUrl"],
                        });
                      },
                    );
                  }).toList()
                ],
              ));
        }));
  }
}
