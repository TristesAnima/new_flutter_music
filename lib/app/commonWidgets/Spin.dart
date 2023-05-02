import 'package:flutter/material.dart';

class Spin extends StatelessWidget {
  final Widget child;
  final bool spining;

  const Spin({super.key, required this.spining, required this.child});

  @override
  Widget build(BuildContext context) {
    return spining
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : child;
  }
}
