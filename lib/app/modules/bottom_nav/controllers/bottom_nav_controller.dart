import 'package:cloud_music_flutter/app/modules/discovery/views/discovery_view.dart';
import 'package:cloud_music_flutter/app/services/Request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<Widget> pages = const [
    DiscoveryView(),
    Scaffold(
      body: SafeArea(child: Text('MV')),
    ),
    Scaffold(
      body: SafeArea(child: Text('About')),
    )
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
