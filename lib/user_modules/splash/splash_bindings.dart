import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    // Get.lazyPut(() => DashBoardController());
  }
}
