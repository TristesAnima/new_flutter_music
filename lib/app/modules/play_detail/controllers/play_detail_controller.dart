import 'package:get/get.dart';

class PlayDetailController extends GetxController {
  String url = '';

  @override
  void onInit() {
    super.onInit();
    url = Get.arguments["url"];
  }

  @override
  void onClose() {
    super.onClose();
  }
}
