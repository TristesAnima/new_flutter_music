import 'package:cloud_music_flutter/app/services/Request.dart';
import 'package:get/get.dart';

class PlayListController extends GetxController {
  Request request = Request();
  RxMap detail = {}.obs;
  RxMap comment = {}.obs;
  RxList list = [].obs;

  getPlaylistDetail () async{
    final response = await request.get('/playlist/detail', body: {"id": Get.arguments["id"]});
    detail.value = response?.data["playlist"];
  }

  getComment () async{
    final response = await request.get('/comment/playlist', body: {"id": Get.arguments["id"], "limit": 10});
    comment.value = response?.data;
  }

  getList () async{
    final response = await request.get('/playlist/track/all', body: {"id": Get.arguments["id"], "limit": 300});
    list.value = response?.data['songs'];
  }

  @override
  void onInit() {
    super.onInit();

    getPlaylistDetail();
    getComment();
    getList();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
