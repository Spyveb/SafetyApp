import 'package:distress_app/modules/settings_module/settings_controller.dart';
import 'package:get/get.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
