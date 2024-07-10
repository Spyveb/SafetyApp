import 'package:get/get.dart';

import '../../imports.dart';

class ReportedEmgCasesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportedEmgCasesController());
  }
}
