import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music_flutter/app/commonWidgets/Spin.dart';
import 'package:cloud_music_flutter/app/modules/play_list/controllers/play_list_controller.dart';
import 'package:cloud_music_flutter/app/services/Format.dart';
import 'package:cloud_music_flutter/app/services/Request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/ScreenAdapter.dart';

class CustomeAppbar extends GetView<PlayListController> {
  const CustomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text("歌单"),
      expandedHeight: Adaptive.height(800),
      stretch: true,
      backgroundColor: Colors.grey.shade600,
      foregroundColor: Colors.white,
      floating: true,
      // snap: true,
      flexibleSpace: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: Adaptive.height(640),
            child: Obx(() {
              final d = controller.detail;
              final comment = controller.comment;
              return Spin(
                  spining: d.isEmpty,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: Adaptive.height(420),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(Adaptive.width(32)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Adaptive.width(16)),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: Request.clipImg(d["coverImgUrl"] ?? ''),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(Adaptive.width(24)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        d["name"] ?? '',
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: Adaptive.fs(40),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.grey.shade600,
                                            radius: Adaptive.width(40),
                                            backgroundImage: CachedNetworkImageProvider(
                                                Request.clipImg(d["creator"]?["avatarUrl"] ?? '')),
                                          ),
                                          Text(
                                            ' ${d["creator"]?["nickname"] ?? ''} ',
                                            maxLines: 1,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white.withOpacity(0.8),
                                                fontSize: Adaptive.fs(32),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          d["creator"]?["expertTags"] != null
                                              ? Icon(
                                                  Icons.loyalty_outlined,
                                                  color: Colors.white.withOpacity(0.8),
                                                  size: Adaptive.fs(38),
                                                )
                                              : const Text(''),
                                          Text(' ${(d["creator"]?["expertTags"] ?? []).join('/')}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Adaptive.fs(24),
                                                  overflow: TextOverflow.ellipsis))
                                        ],
                                      ),
                                      Text(d["creator"]?["signature"] ?? '',
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Adaptive.fs(32),
                                              overflow: TextOverflow.ellipsis)),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.loyalty_outlined,
                                            color: Colors.white.withOpacity(0.8),
                                            size: Adaptive.fs(48),
                                          ),
                                          Text(' ${(d["tags"] ?? []).join('/')}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Adaptive.fs(28),
                                                  overflow: TextOverflow.ellipsis))
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Adaptive.width(24)),
                        width: Adaptive.getScreenWidth(),
                        child: Text(
                          d["description"] ?? '',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: Adaptive.fs(32),
                              color: Colors.white.withOpacity(0.9),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Adaptive.width(24)),
                        child: Row(
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.2)),
                              ),
                              onPressed: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Adaptive.width(48)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.speaker_notes_outlined,
                                      color: Colors.white,
                                      size: Adaptive.fs(48),
                                    ),
                                    Text(
                                      " ${Format.commentTotal(comment["total"] ?? 0)}",
                                      style: TextStyle(color: Colors.white, fontSize: Adaptive.fs(36)),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ));
            }),
          )
        ],
      ),
    );
  }
}
