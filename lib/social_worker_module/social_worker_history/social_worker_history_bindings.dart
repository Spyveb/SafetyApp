import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class SocialWorkerHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocialWorkerHistoryController());
  }
}
