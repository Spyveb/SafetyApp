import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
