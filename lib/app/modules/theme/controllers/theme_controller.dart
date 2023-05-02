import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/theme_category.dart';

class ThemeController extends GetxController {
  final RxString theme = 'System'.obs;

  ThemeModel get themeModel =>
      ThemeModel.themes.firstWhere((element) => element.name == theme.value,
          orElse: () => ThemeModel.themes.first);

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
