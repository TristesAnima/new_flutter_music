import 'package:cloud_music_flutter/app/services/Request.dart';
import 'package:get/get.dart';

class DiscoveryController extends GetxController {
  Request request = Request();
  RxBool spining = false.obs;
  RxList list = [].obs;
  RxList recommendPlylists= [].obs;

  getList() async {
    spining.value = true;
    var playlist = await request.get('/playlist/track/all', body: {"limit": 150, "id": "2675458632"});
    var recommend = await request.get('/recommend/resource');
    list.value = playlist!.data['songs'];
    recommendPlylists.value = recommend?.data["recommend"];
    spining.value = false;
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
