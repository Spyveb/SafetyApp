import 'package:distress_app/modules/report_module/report_controller.dart';
import 'package:get/get.dart';

class ReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportController());
  }
}
