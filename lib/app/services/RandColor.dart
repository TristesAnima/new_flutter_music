import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../modules/theme/views/theme_category.dart';

class RandColor {
  // List<Color> colors = [
  //   Colors.blue,
  //   Colors.red,
  //   Colors.pink,
  //   Colors.purple,
  //   Colors.deepPurple,
  //   Colors.indigo,
  //   Colors.lightBlue,
  //   Colors.cyan,
  //   Colors.teal,
  //   Colors.lightGreen,
  //   Colors.lime,
  //   Colors.yellow,
  //   Colors.amber,
  //   Colors.orange,
  //   Colors.deepOrange,
  //   Colors.brown,
  //   Colors.grey,
  //   Colors.blueGrey,
  // ];

  /// 生成指定范围随机数
  static int randomGen(max) => Random().nextInt(max) + 0;

  /// 颜色源
  static List<Color> colors = ThemeModel.themes.where((item) => item.color != null).map((item) => item.color!).toList();

  /// 得到两个随机颜色 主要用于渐变效果
  static List<Color> getRandColor() {
    return [colors[randomGen(colors.length)], colors[randomGen(colors.length)]];
  }
}
