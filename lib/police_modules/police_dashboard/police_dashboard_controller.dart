import 'package:distress_app/packages/advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class PoliceDashBoardController extends GetxController with GetSingleTickerProviderStateMixin {
  bool canPop = false;
  DateTime? currentBackPressTime;
  AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();
  late AnimationController animationController;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
    super.onInit();
  }

  openDrawer() {
    advancedDrawerController.toggleDrawer();
    update();
  }
}
