import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends GetView<SignInController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignInController>(
        init: SignInController(),
        global: true,
        autoRemove: false,
        builder: (SignInController signInController) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24),
                vertical: getProportionateScreenHeight(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: getProportionateScreenHeight(40),
                                width: getProportionateScreenWidth(40),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(bottom: getProportionateScreenHeight(8)),
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 22,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                AppLocalizations.of(context)!.resetPassword,
                                style: TextStyle(
                                  fontSize: getProportionalFontSize(22),
                                  fontFamily: AppFonts.sansFont600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(25),
                        ),
                        Text(
                          AppLocalizations.of(context)!.enterYourNewPassword,
                          style: TextStyle(
                            fontSize: getProportionalFontSize(20),
                            fontFamily: AppFonts.sansFont600,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(60),
                        ),
                        CommonTextField(
                          hintText: AppLocalizations.of(context)!.enterNewPassword,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        CommonTextField(
                          hintText: AppLocalizations.of(context)!.enterNewPasswordAgain,
                        ),
                      ],
                    ),
                  ),
                  CommonButton(
                    onPressed: () {},
                    width: SizeConfig.deviceWidth,
                    text: AppLocalizations.of(context)!.submit,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  forgotPasswordBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: SizeConfig.deviceWidth,
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(14),
              vertical: getProportionateScreenHeight(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: TextStyle(
                    fontSize: getProportionalFontSize(25),
                    fontFamily: AppFonts.sansFont700,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(8),
                ),
                Text(
                  AppLocalizations.of(context)!.enterYourEmailToReceiveCode,
                  style: TextStyle(
                    fontSize: getProportionalFontSize(16),
                    fontFamily: AppFonts.sansFont500,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(35),
                ),
                CommonTextField(
                  hintText: AppLocalizations.of(context)!.enterYourEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(12),
                      vertical: getProportionateScreenHeight(12),
                    ),
                    child: SvgPicture.asset(
                      AppImages.email,
                      height: getProportionateScreenHeight(24),
                      width: getProportionateScreenWidth(24),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(35),
                ),
                CommonButton(
                  width: SizeConfig.deviceWidth,
                  onPressed: () {},
                  text: AppLocalizations.of(context)!.submit,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(35),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
