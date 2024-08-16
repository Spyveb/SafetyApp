import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends GetView<SettingsController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        global: true,
        autoRemove: false,
        builder: (SettingsController settingsController) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24),
                vertical: getProportionateScreenHeight(12),
              ),
              child: Form(
                key: controller.changePasswordKey,
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
                                  AppLocalizations.of(context)!.changePassword,
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
                            height: getProportionateScreenHeight(60),
                          ),
                          CommonTextField(
                            hintText: AppLocalizations.of(context)!.currentPassword,
                            obscure: controller.currentPasswordObscure,
                            textEditingController: controller.currentPasswordController,
                            validation: (value) => Validation.emptyValidation(
                              controller.currentPasswordController.text,
                              context,
                              AppLocalizations.of(context)!.password.capitalize,
                            ),
                            onChanged: (value) {
                              controller.update();
                            },
                            suffix: IconButton(
                              onPressed: () {
                                controller.currentPasswordObscure = !controller.currentPasswordObscure;
                                controller.update();
                              },
                              icon: controller.currentPasswordObscure
                                  ? const Icon(
                                      Icons.visibility,
                                      size: 24,
                                      color: Colors.black87,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      size: 24,
                                      color: Colors.black87,
                                    ),
                            ),
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(12),
                              ),
                              child: SvgPicture.asset(
                                AppImages.lockIcon,
                                height: getProportionateScreenHeight(24),
                                width: getProportionateScreenWidth(24),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          CommonTextField(
                            hintText: AppLocalizations.of(context)!.newPassword,
                            obscure: controller.newPasswordObscure,
                            textEditingController: controller.newPasswordController,
                            validation: (value) => Validation.emptyValidation(
                              controller.newPasswordController.text,
                              context,
                              AppLocalizations.of(context)!.password.capitalize,
                            ),
                            onChanged: (value) {
                              controller.update();
                            },
                            suffix: IconButton(
                              onPressed: () {
                                controller.newPasswordObscure = !controller.newPasswordObscure;
                                controller.update();
                              },
                              icon: controller.newPasswordObscure
                                  ? const Icon(
                                      Icons.visibility,
                                      size: 24,
                                      color: Colors.black87,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      size: 24,
                                      color: Colors.black87,
                                    ),
                            ),
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(12),
                              ),
                              child: SvgPicture.asset(
                                AppImages.lockIcon,
                                height: getProportionateScreenHeight(24),
                                width: getProportionateScreenWidth(24),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          CommonTextField(
                            hintText: AppLocalizations.of(context)!.confirmNewPassword,
                            obscure: controller.confirmPasswordObscure,
                            textEditingController: controller.changeConfirmPasswordController,
                            onChanged: (value) {
                              controller.update();
                            },
                            validation: (value) {
                              if (controller.newPasswordController.text == value) {
                                return null;
                              } else {
                                return AppLocalizations.of(context)!.confirmPasswordDoesNotMatch;
                              }
                            },
                            suffix: IconButton(
                              onPressed: () {
                                controller.confirmPasswordObscure = !controller.confirmPasswordObscure;
                                controller.update();
                              },
                              icon: controller.confirmPasswordObscure
                                  ? const Icon(
                                      Icons.visibility,
                                      size: 24,
                                      color: Colors.black87,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      size: 24,
                                      color: Colors.black87,
                                    ),
                            ),
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(12),
                              ),
                              child: SvgPicture.asset(
                                AppImages.lockIcon,
                                height: getProportionateScreenHeight(24),
                                width: getProportionateScreenWidth(24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonButton(
                      onPressed: controller.changePasswordKey.currentState != null && controller.changePasswordKey.currentState!.validate()
                          ? () {
                              controller.changePassword();
                            }
                          : null,
                      width: SizeConfig.deviceWidth,
                      text: AppLocalizations.of(context)!.submit,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
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
}
