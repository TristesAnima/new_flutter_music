import 'package:cloud_music_flutter/app/modules/music_player/controllers/music_player_controller.dart';
import 'package:cloud_music_flutter/app/services/ScreenAdapter.dart';
import 'package:cloud_music_flutter/app/services/Storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NeteaseBottomSheet {
  static show() async {
    List? list = await Storage.getData("list");
    await Get.bottomSheet(
      Container(
        margin: EdgeInsets.only(bottom: Adaptive.height(16)),
        alignment: Alignment.center,
        child: Container(
          width: Adaptive.getScreenWidth() - Adaptive.width(40),
          height: Adaptive.getScreenHeight() / 2 + Adaptive.height(400),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Adaptive.width(72)),
                topRight: Radius.circular(Adaptive.width(72)),
                bottomLeft: Radius.circular(Adaptive.width(48)),
                bottomRight: Radius.circular(Adaptive.width(48))),
          ),
          child: list == null
              ? const Center(
                  child: Text("暂无数据"),
                )
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Adaptive.height(16), bottom: Adaptive.height(8)),
                      padding: EdgeInsets.fromLTRB(
                          Adaptive.height(56), Adaptive.height(56), Adaptive.height(56), Adaptive.height(0)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "当前播放歌单",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Adaptive.fs(40)),
                          ),
                          Expanded(child: Text(list.isNotEmpty ? "(${list.length})" : "")),
                          IconButton(
                            onPressed: () {
                              Storage.remove('list');
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.delete_sweep_outlined,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Adaptive.getScreenHeight() / 2 - Adaptive.height(100),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final item = list[index];
                          return InkWell(
                            onTap: () async {
                              await Get.find<MusicplayerController>()
                                  .setPlayConfig(item["uniId"], item["title"], item["artists"], item["coverUrl"]);
                              Get.back();
                            },
                            splashColor: Colors.yellowAccent,
                            child: Container(
                              width: double.infinity,
                              height: Adaptive.height(120),
                              padding: EdgeInsets.symmetric(horizontal: Adaptive.height(56)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Get.find<MusicplayerController>().id.value == item["id"]
                                      ? const Icon(
                                          Icons.signal_cellular_alt_outlined,
                                          color: Colors.red,
                                        )
                                      : const Text(""),
                                  Expanded(
                                      child: Text(
                                    " ${item["name"]}",
                                    style: TextStyle(
                                        color: Get.find<MusicplayerController>().id.value == item["id"]
                                            ? Colors.red
                                            : Colors.black,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.close,
                                        size: Adaptive.fs(48),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: list.length,
                        shrinkWrap: true,
                      ),
                    )
                  ],
                ),
        ),
      ),
      elevation: 0,
    );
  }
}
