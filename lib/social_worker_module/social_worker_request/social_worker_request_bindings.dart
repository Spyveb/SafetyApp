import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class SocialWorkerRequestdBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocialWorkerRequestController());
  }
}
