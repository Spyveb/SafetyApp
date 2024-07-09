import 'package:distress_app/componants/police_drawer_items.dart';
import 'package:distress_app/imports.dart';
import 'package:distress_app/packages/advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoliceDashBoardScreen extends GetView<PoliceDashBoardController> {
  const PoliceDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PoliceDashBoardController>(
      initState: (state) => PoliceDashBoardController(),
      global: true,
      autoRemove: false,
      builder: (controller) {
        return PopScope(
          canPop: controller.canPop,
          onPopInvoked: (didPop) {
            controller.canPop = true;
            controller.update();
            Utils.showToast(AppLocalizations.of(context)!.pressAgainToExit);
            Future.delayed(
              const Duration(seconds: 2),
              () {
                controller.canPop = false;
                controller.update();
              },
            );
          },
          child: AdvancedDrawer(
            backdropColor: AppColors.greyColor,
            controller: controller.advancedDrawerController,
            animationController: controller.animationController,
            openRatio: .68,
            animationDuration: const Duration(milliseconds: 300),
            openScale: 1,
            drawer: drawerMenu(),
            animateChildDecoration: false,
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [Text("data")],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  drawerMenu() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            Container(
              height: getProportionateScreenHeight(90),
              width: getProportionateScreenWidth(90),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.policeUserIcon,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(12),
            ),
            Text(
              "Joe, Police Officer",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.sansFont600,
                fontSize: getProportionalFontSize(18),
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(4),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Status: ",
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont500,
                      fontSize: getProportionalFontSize(14),
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Available",
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont700,
                      fontSize: getProportionalFontSize(14),
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(60),
            ),
            PoliceDrawerItems(
              itemName: "Dashboard",
              imageName: AppImages.policeDashboard,
              bottom: getProportionateScreenHeight(22),
            ),
            PoliceDrawerItems(
              itemName: "SOS Emergency",
              imageName: AppImages.policeSosEmergency,
              bottom: getProportionateScreenHeight(22),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(3),
              ),
              child: PoliceDrawerItems(
                itemName: "Reported Emergency",
                imageName: AppImages.policeReportedEmergency,
                bottom: getProportionateScreenHeight(22),
              ),
            ),
            PoliceDrawerItems(
              itemName: "Reported Non Emergency",
              imageName: AppImages.policeReportedNonEmergency,
              bottom: getProportionateScreenHeight(22),
            ),
            PoliceDrawerItems(
              itemName: "Settings",
              imageName: AppImages.policeSetting,
              bottom: getProportionateScreenHeight(22),
            ),
            PoliceDrawerItems(
              itemName: "Logout",
              imageName: AppImages.policeLogout,
            ),
          ],
        ),
      ),
    );
  }
}
