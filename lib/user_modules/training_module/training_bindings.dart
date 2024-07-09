import 'package:distress_app/modules/training_module/training_controller.dart';
import 'package:get/get.dart';

class TrainingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainingController());
  }
}
