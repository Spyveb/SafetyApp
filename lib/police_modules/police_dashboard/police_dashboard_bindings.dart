import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class PoliceDashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoliceDashBoardController());
    Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => SettingsController());
    // Get.lazyPut(() => TrainingController());
    // Get.lazyPut(() => ReportController());
    // Get.lazyPut(() => ChatController());

    // Get.lazyPut(() => CategoryController());
    // Get.lazyPut(() => OrdersController());
    // Get.lazyPut(() => ProfileController());
  }
}
