class Format {
  /// 格式化播放次数
  static String playCount(num playCount) {
    if (playCount > 100000000) {
      return '${playCount ~/ 100000000}亿';
    } else if (playCount > 10000) {
      return '${playCount ~/ 10000}万';
    }
    return '$playCount';
  }
}
