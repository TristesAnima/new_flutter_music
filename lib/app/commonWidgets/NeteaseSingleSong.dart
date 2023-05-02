import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import 'NeteaseTag.dart';

/// 自定义音乐列表
class NeteaseSingleSong extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final double? height;
  final String subTitle;
  final String artist;
  final bool level;
  final bool isVip;
  final bool originCoverType;
  final String? thirdTitle;
  final Function()? onTap;
  final Function()? onTapMore;
  final Function()? onTapToPlayMmv;
  final Function()? onLongPress;
  final bool isMv;
  final EdgeInsetsGeometry? margin;

  const NeteaseSingleSong({
    super.key,
    required this.title,
    required this.subTitle,
    required this.artist,
    required this.level,
    required this.isVip,
    required this.originCoverType,
    required this.isMv,
    this.thirdTitle = '',
    this.onTap,
    this.onTapMore,
    this.titleColor = Colors.black87,
    this.height = 60,
    this.margin,
    this.onTapToPlayMmv,
    this.onLongPress,
  });

  final double _fs = 32;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(Adaptive.width(12)),
          child: Container(
            width: double.infinity,
            height: height,
            padding: EdgeInsets.only(left: Adaptive.width(24)),
            margin: margin ?? EdgeInsets.all(Adaptive.width(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 标题
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: Adaptive.fs(38), color: titleColor),
                            ))
                          ],
                        ),
                        // 二级
                        Row(
                          children: [
                            originCoverType
                                ? const NeteaseTag(
                                    title: '原唱',
                                  )
                                : const Text(''),
                            level
                                ? const NeteaseTag(
                                    title: 'SQ',
                                  )
                                : const Text(''),
                            isVip
                                ? const NeteaseTag(
                                    title: 'VIP',
                                  )
                                : const Text(''),
                            Expanded(
                              child: Text(
                                artist,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontSize: Adaptive.fs(_fs), color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                        // 三级
                        subTitle.isEmpty
                            ? const SizedBox(
                                height: 0,
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      subTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: Adaptive.fs(_fs),
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    )),
                isMv
                    ? SizedBox(
                        width: Adaptive.width(100),
                        child: MaterialButton(
                          padding: const EdgeInsets.all(0),
                          shape: const CircleBorder(),
                          onPressed: onTapToPlayMmv ?? () {},
                          child: Icon(
                            Icons.slow_motion_video_outlined,
                            color: Colors.black38,
                            size: Adaptive.fs(56),
                          ),
                        ),
                      )
                    : const Text(''),
                SizedBox(
                  width: Adaptive.width(100),
                  child: MaterialButton(
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    onPressed: onTapMore ?? () {},
                    child: Icon(
                      Icons.more_vert_outlined,
                      color: Colors.black38,
                      size: Adaptive.fs(56),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
