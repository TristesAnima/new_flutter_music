import 'package:cloud_music_flutter/app/services/Request.dart';
import 'package:get/get.dart';

class DiscoveryController extends GetxController {
  Request request = Request();
  RxList list = [].obs;

  getList() async {
    var response = await request.get('/playlist/track/all', body: {"limit": 150, "id": "2675458632"});
    list.value = response!.data['songs'];
  }

  @override
  void onInit() {
    super.onInit();

    getList();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
