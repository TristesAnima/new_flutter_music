import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_music_flutter/app/services/Audio.dart';
import 'package:cloud_music_flutter/app/services/RandColor.dart';
import 'package:cloud_music_flutter/app/services/Request.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../services/ScreenAdapter.dart';
import '../../../services/Storage.dart';

class MusicplayerController extends GetxController {
  Request request = Request();
  late StreamSubscription positionSubscription;
  late StreamSubscription durationSubscription;
  ScrollController scrollController = ScrollController();

  /// 数据提供给别的页面使用
  /// 显示进度条用
  RxDouble sliderCurrentValue = 0.00.obs;
  RxDouble sliderEndDuration = 0.00.obs;

  /// 显示文字用
  RxString currentTextTime = '0:00'.obs;
  RxString endTextTime = '0:00'.obs;

  int height = 160;
  RxInt bottom = 160.obs;
  RxBool isPlaying = false.obs;
  RxBool isShowPlayer = true.obs;
  RxInt id = 0.obs;
  String url = 'https://chcblogs.com/lib/images/%E6%98%A5%E5%A8%87%E4%B8%8E%E5%BF%97%E6%98%8E.mp3';
  RxString artist = '街道办GOC'.obs;
  RxString name = '春娇与志明'.obs;
  RxString cover = 'https://p2.music.126.net/0KC-cAFqdJHDomIl3dSv4Q==/109951166676094043.jpg'.obs;

  /// 播放模式 `0 顺序` `1 随机`
  RxInt playmode = 0.obs;

  /// 监听播放状态变化
  listenPlayState() {
    Audio.audioPlayer.onPlayerStateChanged.listen((PlayerState playerState) =>
        {playerState == PlayerState.playing ? isPlaying.value = true : isPlaying.value = false});
  }

  /// 监听播放进度改变
  listenPlayChange() {
    /// 总播放时长
    durationSubscription = Audio.audioPlayer.onDurationChanged.listen((duration) {
      sliderEndDuration.value = duration.inSeconds.toDouble();
      endTextTime.value = '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    });

    /// 当前播放位置
    positionSubscription = Audio.audioPlayer.onPositionChanged.listen((position) {
      sliderCurrentValue.value = position.inSeconds.toDouble();
      currentTextTime.value = '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}';
    });

    /// 播放结束的监听
    Audio.audioPlayer.onPlayerComplete.listen((event) {
      playNext();
    });
  }

  /// 设置播放配置 及 播放
  setPlayConfig(uniId, title, artists, coverUrl) async {
    final response = await request.get('/song/url', body: {"id": uniId});
    String? linkSource = response?.data?["data"]?[0]?["url"]?.split("http")?[1];
    if (linkSource != null) {
      final newUrl = 'https$linkSource';
      url = newUrl;
      name.value = title;
      artist.value = artists;
      cover.value = Request.clipImg(coverUrl);
      id.value = uniId;
      Audio.play(newUrl);
    }
  }

  handlePlay() {
    if (isPlaying.value) {
      Audio.pause();
    } else {
      if (id.value == 0) {
        Audio.play(url);
      } else {
        Audio.resume();
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    playmode.value = await Storage.getData('play_mode') ?? 0;

    /// 监听播放状态变化
    listenPlayState();

    /// 监听播放进度条变化
    listenPlayChange();
  }

  @override
  void onClose() {
    super.onClose();
    durationSubscription.cancel();
    positionSubscription.cancel();
  }

  /// 增加全部到列表 参数List的Map中需要包含 `uniId` `title` `artists` `coverUrl`
  addAllToList(List data) async {
    await Storage.setData("list", data);
    // update();
  }

  /// 增加单个到列表 Map中需要包含 `uniId` `title` `artists` `coverUrl`
  addSingleToList(Map data) async {
    List? list = await Storage.getData("list");
    if (list == null) {
      await Storage.setData("list", [data]);
    } else {
      list.insert(0, data);
      await Storage.setData("list", distinctById(list));
    }
    // update();
  }

  /// 播放下一首
  playNext() async {
    List? list = await Storage.getData("list");
    if (list != null) {
      var currentIndex = list.indexWhere((item) => item["id"] == id.value);
      if (currentIndex != -1) {
        // 顺序播放
        if (playmode.value == 0) {
          var currentItem = list[currentIndex + 1 > list.length - 1 ? 0 : currentIndex + 1];
          await setPlayConfig(
              currentItem["uniId"], currentItem["title"], currentItem["artists"], currentItem["coverUrl"]);
        } else {
          // 随机播放
          var currentItem = list[RandColor.randomGen(list.length - 1)];
          await setPlayConfig(
              currentItem["uniId"], currentItem["title"], currentItem["artists"], currentItem["coverUrl"]);
        }
      } else {
        var currentItem = list[0];
        await setPlayConfig(
            currentItem["uniId"], currentItem["title"], currentItem["artists"], currentItem["coverUrl"]);
      }
    }
  }

  /// 播放上一首
  playPrev() async {
    List? list = await Storage.getData("list");
    if (list != null) {
      var currentIndex = list.indexWhere((item) => item["id"] == id.value);
      if (currentIndex != -1) {
        var currentItem = list[currentIndex == 0 ? list.length - 1 : currentIndex - 1];
        await setPlayConfig(
            currentItem["uniId"], currentItem["title"], currentItem["artists"], currentItem["coverUrl"]);
      }
    }
  }

  /// 设置播放模式 `0 顺序` `1 随机`
  setPlayMode(int playeMode) async {
    await Storage.setData('play_mode', playeMode);
    playmode.value = playeMode;
  }

  /// 监听音乐列表滚动距离
// listenPlayListsScroll() async {
//   List? list = await Storage.getData("list");
//   if (list != null) {
//     final currentIndex = list.indexWhere((item) => item["id"] == id.value);
//     if (currentIndex != -1) {
//       scrollController.animateTo((currentIndex * Adaptive.height(120)).toDouble(),
//           duration: const Duration(milliseconds: 240), curve: Curves.easeInOut);
//     }
//   }
// }
}

/// 查重
List distinctById(List list) {
  return list.fold([], (accumulator, currentValue) {
    if (accumulator.any((map) => map['id'] == currentValue['id'])) {
      return accumulator;
    }
    return [...accumulator, currentValue];
  });
}
