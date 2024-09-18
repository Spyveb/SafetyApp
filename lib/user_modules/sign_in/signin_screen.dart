import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignInController>(
        init: SignInController(),
        global: true,
        autoRemove: false,
        builder: (SignInController signInController) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24),
                vertical: getProportionateScreenHeight(12),
              ),
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.disabled,
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
                      prefixIcon: const Icon(
                        Icons.person,
                        size: 26,
                        color: AppColors.textFieldGreyColor,
                      ),
                      onChanged: (value) {
                        // controller.userNameController.text = value;
                        controller.update();
                      },
                      textEditingController: controller.userNameController,
                      hintText: AppLocalizations.of(context)!.enterYourUsername,
                      validation: (value) => Validation.userNameValidation(controller.userNameController.text, context),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(26),
                    ),
                    CommonTextField(
                      prefixIcon: const Icon(
                        Icons.vpn_key,
                        size: 26,
                        color: AppColors.textFieldGreyColor,
                      ),
                      onChanged: (value) {
                        // controller.passwordController.text = value;
                        controller.update();
                      },
                      textEditingController: controller.passwordController,
                      hintText: AppLocalizations.of(context)!.enterYourPassword,
                      validation: (value) => Validation.emptyValidation(
                        controller.passwordController.text,
                        context,
                        AppLocalizations.of(context)!.password.toLowerCase(),
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(4),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          controller.forgotPasswordController.clear();
                          forgotPasswordBottomSheet(context);
                        },
                        child: Text(
                          "${AppLocalizations.of(context)!.forgotPassword}?",
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
                    CommonButton(
                      text: AppLocalizations.of(context)!.login,
                      width: SizeConfig.deviceWidth,
                      radius: getProportionateScreenWidth(10),
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(22),
                      ),
                      onPressed: controller.userNameController.text.trim().isNotEmpty && controller.passwordController.text.trim().isNotEmpty
                          ? () {
                              FocusManager.instance.primaryFocus?.requestFocus();

                              controller.loginMethod();
                            }
                          : null,
                    ),
                    // SizedBox(
                    //   width: SizeConfig.deviceWidth,
                    //   child: ElevatedButton(
                    //     onPressed: controller.userNameController.text.trim().isNotEmpty &&
                    //             controller.passwordController.text.trim().isNotEmpty
                    //         ? () {
                    //             controller.loginMethod();
                    //           }
                    //         : null,
                    //     style: ButtonStyle(
                    //       overlayColor: MaterialStateProperty.all(Colors.white10),
                    //       backgroundColor: MaterialStateProperty.all(
                    //         AppColors.primaryColor,
                    //       ),
                    //       padding: MaterialStateProperty.all(
                    //         EdgeInsets.symmetric(
                    //           vertical: getProportionateScreenHeight(20),
                    //           horizontal: getProportionateScreenWidth(16),
                    //         ),
                    //       ),
                    //       shape: MaterialStateProperty.all(
                    //         RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(
                    //             getProportionateScreenWidth(10),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       AppLocalizations.of(context)!.login,
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         fontSize: getProportionalFontSize(16),
                    //         fontFamily: AppFonts.sansFont600,
                    //         color: AppColors.whiteColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
        return GetBuilder<SignInController>(
          builder: (SignInController signInController) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: SizeConfig.deviceWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24),
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
                      textEditingController: signInController.forgotPasswordController,
                      validation: (value) =>
                          Validation.emailValidation(signInController.forgotPasswordController.text, AppLocalizations.of(context)!.email.capitalize, context),
                      onChanged: (value) {
                        controller.update();
                      },
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
                      onPressed: signInController.forgotPasswordController.text.trim().isNotEmpty
                          ? () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              signInController.forgotPassword();
                            }
                          : null,
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
      },
    );
  }
}
