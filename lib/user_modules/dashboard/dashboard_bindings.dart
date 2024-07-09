import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => TrainingController());
    Get.lazyPut(() => ReportController());
    Get.lazyPut(() => ChatController());

    // Get.lazyPut(() => CategoryController());
    // Get.lazyPut(() => OrdersController());
    // Get.lazyPut(() => ProfileController());
  }
}
