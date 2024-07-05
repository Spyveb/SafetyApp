import 'package:distress_app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    // Get.lazyPut(() => DashBoardController());
  }
}
