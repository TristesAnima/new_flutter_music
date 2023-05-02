import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

class NeteaseTag extends StatelessWidget {
  final String title;
  final Color? color;

  const NeteaseTag({
    super.key,
    required this.title,
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(Adaptive.width(4)),
        padding: EdgeInsets.symmetric(
            horizontal: Adaptive.width(10), vertical: Adaptive.width(4)),
        decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.all(Radius.circular(Adaptive.width(10)))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Text(
          title,
          style: TextStyle(
              fontSize: Adaptive.fs(18),
              color: Colors.white,
              textBaseline: TextBaseline.alphabetic),
        ));
  }
}
