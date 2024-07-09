import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
