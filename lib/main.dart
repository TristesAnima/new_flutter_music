import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/modules/music_player/controllers/music_player_controller.dart';
import 'app/modules/music_player/views/music_player_view.dart';
import 'app/modules/theme/views/theme_category.dart';
import 'app/routes/app_pages.dart';
import 'app/services/RouterObserver.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 状态栏颜色设置为透明
    statusBarBrightness: Brightness.dark, // 状态栏字体颜色为深色
  ));

  // 创建 MyRouteObserver 实例
  final MyRouteObserver myRouteObserver = MyRouteObserver();

  runApp(ScreenUtilInit(
    designSize: const Size(1080, 2400),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => GetMaterialApp(
      title: "flutter_music",
      theme: ThemeModel.light,
      // 添加路由监听器到全局
      navigatorObservers: [myRouteObserver],
      initialBinding: BindingsBuilder(() {
        Get.put<MusicplayerController>(MusicplayerController());
      }),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, child) {
        return Stack(
          children: [child!, const MusicPlayerView()],
        );
      },
    ),
  ));
}
