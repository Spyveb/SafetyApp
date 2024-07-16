import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class PoliceDashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoliceDashBoardController());
    Get.lazyPut(() => PoliceSOSEmergencyController());
    Get.lazyPut(() => ReportedEmgCasesController());
    Get.lazyPut(() => ReportedNonEmgCasesController());
    Get.lazyPut(() => PoliceSettingController());
  }
}
