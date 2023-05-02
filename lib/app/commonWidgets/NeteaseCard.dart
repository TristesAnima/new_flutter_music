import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music_flutter/app/services/Request.dart';
import 'package:cloud_music_flutter/app/services/ScreenAdapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NeteaseBadge.dart';

class NeteaseCard extends StatelessWidget {
  final num? width;
  final num? height;
  final String coverImg;
  final String playCount;
  final String title;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;

  const NeteaseCard(
      {super.key,
      required this.coverImg,
      required this.playCount,
      required this.title,
      this.width = 320,
      this.height = 450,
      this.margin,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Adaptive.width(width!),
        height: Adaptive.height(height!),
        margin: margin,
        child: Column(
          children: [
            Stack(
              children: [
                // 海报
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                      width: double.infinity,
                      height: Adaptive.height(340),
                      fit: BoxFit.cover,
                      imageUrl: Request.clipImg(coverImg)),
                ),
                // 显示播放次数
                Positioned(
                    top: Adaptive.height(6), right: Adaptive.width(6), child: NeteaseBadge(playCount: playCount)),
                // 显示播放图标
                Positioned(
                    bottom: Adaptive.height(6),
                    right: Adaptive.width(6),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                    ))
              ],
            ),
            // 名称
            Container(
              padding: EdgeInsets.only(top: Adaptive.height(10)),
              child: Text(
                title * 10,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: Adaptive.fs(32)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
