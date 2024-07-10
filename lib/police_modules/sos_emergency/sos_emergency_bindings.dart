import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class PoliceSOSEmergencyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoliceSOSEmergencyController());
  }
}
