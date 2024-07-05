import 'package:distress_app/componants/common_textfield.dart';
import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/localization/app_localizations.dart';
import 'package:distress_app/modules/sign_in/signin_controller.dart';
import 'package:distress_app/routes/app_pages.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends GetView<SignInController> {
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignInController>(
        builder: (SignInController signInController) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24),
                vertical: getProportionateScreenHeight(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.appLogo,
                      height: getProportionateScreenHeight(290),
                      width: getProportionateScreenWidth(290),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(12),
                  ),
                  Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont600,
                      fontSize: getProportionalFontSize(32),
                      // color: _themeController.isDarkTheme.value ? Colors.white : Colors.black,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(14),
                  ),
                  Text(
                    AppLocalizations.of(context)!.pleaseLoginToProceed,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont400,
                      fontSize: getProportionalFontSize(16),
                      color: Color(0xFF262626),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  CommonTextField(
                    prefixIcon: Icon(
                      Icons.person,
                      size: 26,
                      color: AppColors.textFieldGreyColor,
                    ),
                    hintText: AppLocalizations.of(context)!.enterYourUsername,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(26),
                  ),
                  CommonTextField(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      size: 26,
                      color: AppColors.textFieldGreyColor,
                    ),
                    hintText: AppLocalizations.of(context)!.enterYourPassword,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(4),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.forgotPassword,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          color: AppColors.primaryColor,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  SizedBox(
                    width: SizeConfig.deviceWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.DASHBOARD);
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.white10),
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.primaryColor,
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(20),
                            horizontal: getProportionateScreenWidth(16),
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(10),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(16),
                          fontFamily: AppFonts.sansFont600,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(18),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.dontHaveAnAccount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.sansFont600,
                        color: Colors.black,
                        fontSize: getProportionalFontSize(16),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.SIGN_UP);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          color: AppColors.primaryColor,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
