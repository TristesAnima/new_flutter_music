import 'package:audioplayers/audioplayers.dart';

class Audio {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  Audio._();

  static AudioPlayer get audioPlayer => _audioPlayer;

  /// 播放
  static Future<void> play(String url) async {
    await audioPlayer.play(UrlSource(url));
  }

  /// 暂停
  static Future<void> pause() async {
    await audioPlayer.pause();
  }

  /// 继续播放
  static Future<void> resume() async {
    await audioPlayer.resume();
  }

  /// 指定播放位置
  static Future<void> seekToSec(Duration position) async {
    await audioPlayer.seek(position);
  }
}
