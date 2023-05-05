import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static setData(String key, dynamic value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static getData(String key) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String? template = prefs.getString(key);
      return json.decode(template!);
    } catch (e) {
      return null;
    }
  }

  static remove(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static clear() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

/// 处理歌词
List<Map<String, dynamic>> handleLyric(String lyric) {
  final List<Map<String, dynamic>> res = [];
  final List<String> lyricList = lyric.split('\n').where((item) => item.isNotEmpty).toList();
  for (final String str in lyricList) {
    final RegExp reg = RegExp(r'^\[\d{1,2}:\d{1,2}.\d{1,3}$');
    final List<String> arr = str.split(']');
    // 匹配歌词时间
    final List<String> timeArr = arr.where((item) => reg.hasMatch(item)).toList();
    // 取出歌词
    final String lrc = arr.firstWhere((item) => !reg.hasMatch(item), orElse: () => '');
    if (lrc == '') continue;
    for (final String timeStr in timeArr) {
      final List<String> arr = timeStr.split(RegExp(r'[[:.]'));
      final int m = int.parse(arr[1]);
      final int s = int.parse(arr[2]);
      final int ms = int.parse(arr[3]);
      final int time = (m * 60 + s) * 1000 + ms;
      res.add({'time': time, 'text': lrc});
    }
  }
  // 按时间排序并返回
  res.sort((a, b) => a['time'] - b['time']);
  return res;
}
