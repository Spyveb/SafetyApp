import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class TrainingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainingController());
  }
}
