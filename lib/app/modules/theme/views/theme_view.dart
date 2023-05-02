import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import 'theme_category.dart';

class ThemeView extends GetView<ThemeController> {
  const ThemeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String theme = controller.theme.value;

      return Scaffold(
        appBar: AppBar(
          title: const Icon(Icons.palette),
        ),
        body: ListView(
          children: [
            for (final model in ThemeModel.themes)
              ListTile(
                title: Text(model.name),
                leading: model.icon == null
                    ? Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: model.color,
                    shape: BoxShape.circle,
                    // borderRadius:
                    //     const BorderRadius.all(Radius.circular(12)),
                  ),
                )
                    : Icon(model.icon),
                selected: theme == model.name,
                onTap: () {
                  if (model.mode != null) {
                    Get.changeTheme(ThemeModel.light);
                    Get.changeThemeMode(model.mode!);
                  } else if (model.color != null) {
                    final themeData = ThemeModel.generateTheme(
                      brightness: Get.theme.brightness,
                      colorSchemeSeed: model.color!,
                    );
                    Get.changeTheme(themeData);
                    // ??
                    Get.changeThemeMode(ThemeMode.light);
                  }
                  controller.theme.value = model.name;
                },
              ),
          ],
        ),
      );
    });
  }
}
