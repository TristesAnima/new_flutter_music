import 'package:flutter_screenutil/flutter_screenutil.dart';

class Adaptive {
  static width(num v) {
    return v.w;
  }

  static height(num v) {
    return v.h;
  }

  static fs(num v) {
    return v.sp;
  }

  static getScreenWidth() {
    // return ScreenUtil().screenWidth;
    return 1.sw;
  }

  static getScreenHeight() {
    // return ScreenUtil().screenHeight;
    return 1.sh;
  }
}