import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class OnBoardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => OnBoardingController(),
    );
    // Get.lazyPut(() => DashBoardController());
  }
}
