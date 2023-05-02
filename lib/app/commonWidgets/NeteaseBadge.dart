import 'package:cloud_music_flutter/app/services/ScreenAdapter.dart';
import 'package:flutter/material.dart';

class NeteaseBadge extends StatelessWidget {
  final String playCount;

  const NeteaseBadge({super.key, required this.playCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: Adaptive.width(8), right: Adaptive.width(12)),
      alignment: Alignment.center,
      height: Adaptive.height(45),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.2)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            Icons.play_arrow_outlined,
            size: Adaptive.fs(40),
            color: Colors.white,
          ),
          Text(
            playCount,
            style: TextStyle(
                fontSize: Adaptive.fs(32),
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
