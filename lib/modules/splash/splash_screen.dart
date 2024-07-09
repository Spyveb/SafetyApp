import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/localization/app_localizations.dart';
import 'package:distress_app/modules/splash/splash_controller.dart';
import 'package:distress_app/routes/app_pages.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SplashController>(
          builder: (controller) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  Image.asset(
                    AppImages.appLogo,
                    width: SizeConfig.deviceWidth,
                    height: getProportionateScreenHeight(381),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  FittedBox(
                    child: Text(
                      AppLocalizations.of(context)!.empower,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.interFont700,
                        color: AppColors.primaryColor,
                        fontSize: getProportionalFontSize(24),
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      if (controller.isAuthenticated) {
                        Get.offAllNamed(Routes.DASHBOARD);
                      } else if (controller.isFirstTime) {
                        Get.offAllNamed(Routes.ONBOARDING);
                      } else {
                        Get.offAllNamed(Routes.SIGN_IN);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.tapToContinue,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.sansFont600,
                        color: AppColors.primaryColor,
                        fontSize: getProportionalFontSize(16),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
