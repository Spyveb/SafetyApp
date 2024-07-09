import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/helpers/utils.dart';
import 'package:distress_app/localization/app_localizations.dart';
import 'package:distress_app/modules/chat/chat_screen.dart';
import 'package:distress_app/modules/home_module/home_screen.dart';
import 'package:distress_app/modules/report_module/report_screen.dart';
import 'package:distress_app/modules/settings_module/settings_screen.dart';
import 'package:distress_app/modules/training_module/training_screen.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashBoardScreen extends GetView<DashBoardController> {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      initState: (state) => DashBoardController(),
      global: true,
      autoRemove: false,
      builder: (controller) {
        return PopScope(
          canPop: controller.canPop,
          onPopInvoked: (didPop) {
            if (controller.currentIndex == 0) {
              controller.canPop = true;
              controller.update();
              Utils.showToast(AppLocalizations.of(context)!.pressAgainToExit);
              Future.delayed(
                Duration(seconds: 2),
                () {
                  controller.canPop = false;
                  controller.update();
                },
              );
            } else {
              controller.currentIndex = 0;
              controller.update();
            }
          },
          child: Scaffold(
            backgroundColor: Color(0xFFD8D8D8),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                onTap: (value) {
                  controller.currentIndex = value;
                  controller.update();
                },
                showUnselectedLabels: false,
                showSelectedLabels: false,
                // selectedItemColor: Colors.black,
                currentIndex: controller.currentIndex,
                // unselectedItemColor: Color(0xFF4F4F4F),
                items: [
                  BottomNavigationBarItem(
                    label: "",
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                        vertical: getProportionateScreenHeight(4),
                      ),
                      height: getProportionateScreenHeight(40),
                      width: getProportionateScreenWidth(50),
                      decoration: BoxDecoration(
                        color: controller.currentIndex == 0 ? AppColors.bottomTabBackgroundColor : Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(
                            getProportionateScreenWidth(50),
                            getProportionateScreenHeight(40),
                          ),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            AppImages.homeIcon,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                        vertical: getProportionateScreenHeight(4),
                      ),
                      height: getProportionateScreenHeight(40),
                      width: getProportionateScreenWidth(50),
                      decoration: BoxDecoration(
                        color: controller.currentIndex == 1 ? AppColors.bottomTabBackgroundColor : Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(
                            getProportionateScreenWidth(50),
                            getProportionateScreenHeight(40),
                          ),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            AppImages.trainingIcon,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(4),
                        vertical: getProportionateScreenHeight(4),
                      ),
                      height: getProportionateScreenHeight(40),
                      width: getProportionateScreenWidth(40),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: controller.currentIndex == 2
                            ? Border.all(color: AppColors.bottomTabBackgroundColor, width: 5)
                            : null,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                        vertical: getProportionateScreenHeight(4),
                      ),
                      height: getProportionateScreenHeight(40),
                      width: getProportionateScreenWidth(50),
                      decoration: BoxDecoration(
                        color: controller.currentIndex == 3 ? AppColors.bottomTabBackgroundColor : Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(
                            getProportionateScreenWidth(50),
                            getProportionateScreenHeight(40),
                          ),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            AppImages.chatIcon,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                        vertical: getProportionateScreenHeight(4),
                      ),
                      height: getProportionateScreenHeight(40),
                      width: getProportionateScreenWidth(50),
                      decoration: BoxDecoration(
                        color: controller.currentIndex == 4 ? AppColors.bottomTabBackgroundColor : Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(
                            getProportionateScreenWidth(50),
                            getProportionateScreenHeight(40),
                          ),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            AppImages.settingIcon,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
            body: getScreen(),
          ),
        );
      },
    );
  }

  Widget getScreen() {
    Widget widget = HomeScreen();
    if (controller.currentIndex == 0) {
      widget = HomeScreen();
    } else if (controller.currentIndex == 1) {
      widget = TrainingScreen();
    } else if (controller.currentIndex == 2) {
      widget = ReportScreen();
    } else if (controller.currentIndex == 3) {
      widget = ChatScreen();
    } else if (controller.currentIndex == 4) {
      widget = SettingsScreen();
    }

    return widget;
  }
}
