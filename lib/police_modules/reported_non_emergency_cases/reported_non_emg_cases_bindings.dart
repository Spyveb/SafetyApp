import 'package:get/get.dart';

import '../../imports.dart';

class ReportedNonEmgCasesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportedNonEmgCasesController());
  }
}
