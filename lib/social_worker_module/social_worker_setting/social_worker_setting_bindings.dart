import 'package:get/get.dart';

import '../../imports.dart';

class SocialWorkerSettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocialWorkerSettingController());
  }
}
