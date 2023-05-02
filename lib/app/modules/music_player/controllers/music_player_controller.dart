import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_music_flutter/app/services/Audio.dart';
import 'package:cloud_music_flutter/app/services/Request.dart';
import 'package:get/get.dart';

class MusicplayerController extends GetxController {
  Request request = Request();
  late StreamSubscription positionSubscription;
  late StreamSubscription durationSubscription;

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

  listenPlayState() {
    Audio.audioPlayer.onPlayerStateChanged.listen((PlayerState playerState) =>
        {playerState == PlayerState.playing ? isPlaying.value = true : isPlaying.value = false});
  }
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
  }

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
  void onInit() {
    super.onInit();

    /// 监听播放状态变化
    listenPlayState();
    /// 监听播放进度条变化
    listenPlayChange();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    durationSubscription.cancel();
    positionSubscription.cancel();
  }
}
