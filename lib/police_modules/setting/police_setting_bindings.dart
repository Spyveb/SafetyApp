import 'package:get/get.dart';

import '../../imports.dart';

class PoliceSettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoliceSettingController());
  }
}
