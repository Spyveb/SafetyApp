import 'package:distress_app/imports.dart';
import 'package:get/get.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
