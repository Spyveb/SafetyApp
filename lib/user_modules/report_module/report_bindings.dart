import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class ReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportController());
  }
}
