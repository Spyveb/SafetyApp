import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class SocialWorkerDashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocialWorkerDashBoardController());
    Get.lazyPut(() => SocialWorkerRequestController());
    Get.lazyPut(() => SocialWorkerSettingController());
    // Get.lazyPut(() => HomeController());
  }
}
