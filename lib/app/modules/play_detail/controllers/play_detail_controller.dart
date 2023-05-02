import 'package:get/get.dart';

class PlayDetailController extends GetxController {
  String url = '';
  RxString coverUrl = ''.obs;
  RxString artists = ''.obs;
  RxString name = ''.obs;

  @override
  void onInit() {
    super.onInit();
    url = Get.arguments["url"];
    coverUrl.value = Get.arguments["coverUrl"];
    artists.value = Get.arguments["artists"];
    name.value = Get.arguments["name"];
  }

  @override
  void onClose() {
    super.onClose();
  }
}
