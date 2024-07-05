import 'package:distress_app/modules/chat/chat_controller.dart';
import 'package:distress_app/modules/home_module/home_controller.dart';
import 'package:distress_app/modules/report_module/report_controller.dart';
import 'package:distress_app/modules/settings_module/settings_controller.dart';
import 'package:distress_app/modules/training_module/training_controller.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

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
