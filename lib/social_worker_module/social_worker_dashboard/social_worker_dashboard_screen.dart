import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialWorkerDashBoardScreen extends GetView<SocialWorkerDashBoardController> {
  const SocialWorkerDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialWorkerDashBoardController>(
      init: SocialWorkerDashBoardController(),
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
                            AppImages.policeReportedEmergency,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(12),
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
                        // image: DecorationImage(
                        //   image: AssetImage(
                        //     AppImages.socialWorkerHistoryIcon,
                        //   ),
                        // ),
                      ),
                      child: Image.asset(
                        AppImages.socialWorkerHistoryIcon,
                        height: getProportionateScreenHeight(20),
                        width: getProportionateScreenWidth(25),
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
                        color: controller.currentIndex == 2 ? AppColors.bottomTabBackgroundColor : Colors.white,
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
    Widget widget = SocialWorkerRequestScreen();
    if (controller.currentIndex == 0) {
      widget = SocialWorkerRequestScreen();
    } else if (controller.currentIndex == 1) {
      widget = SocialWorkerHistoryScreen();
    } else if (controller.currentIndex == 2) {
      widget = SocialWorkerSettingScreen();
    }

    return widget;
  }
}
