import 'dart:ui';

import 'package:distress_app/componants/common_button.dart';
import 'package:distress_app/componants/common_textfield.dart';
import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/helpers/utils.dart';
import 'package:distress_app/localization/app_localizations.dart';
import 'package:distress_app/modules/sign_up/signup_controller.dart';
import 'package:distress_app/packages/country_code_picker/country_code_picker.dart';
import 'package:distress_app/routes/app_pages.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignUpController>(
        builder: (SignUpController signUpController) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24),
                vertical: getProportionateScreenHeight(16),
              ),
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.register,
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
                      AppLocalizations.of(context)!.pleaseCompleteForm,
                      style: TextStyle(
                        fontFamily: AppFonts.sansFont400,
                        fontSize: getProportionalFontSize(16),
                        color: Color(0xFF262626),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(8),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            hintText: AppLocalizations.of(context)!.firstName,
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(8),
                                vertical: getProportionateScreenHeight(8),
                              ),
                              child: SvgPicture.asset(
                                AppImages.userProfile,
                                fit: BoxFit.contain,
                                height: getProportionateScreenHeight(24),
                                width: getProportionateScreenWidth(24),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(6),
                        ),
                        Expanded(
                          child: CommonTextField(
                            hintText: AppLocalizations.of(context)!.lastName,
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(8),
                                vertical: getProportionateScreenHeight(8),
                              ),
                              child: SvgPicture.asset(
                                AppImages.userProfile,
                                height: getProportionateScreenHeight(24),
                                width: getProportionateScreenWidth(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(14),
                    ),
                    CommonTextField(
                      hintText: AppLocalizations.of(context)!.email,
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
                      height: getProportionateScreenHeight(14),
                    ),
                    CommonTextField(
                      hintText: AppLocalizations.of(context)!.phoneNumber,
                      prefixIcon: CountryCodePicker(
                        hideMainText: true,
                        // enabled: false,
                        // initialSelection: widget.initialSelection,
                        alignLeft: true,
                        barrierColor: Colors.transparent,
                        favorite: [
                          // widget.initialSelection ?? '+965',
                        ],
                        searchStyle: TextStyle(fontSize: getProportionalFontSize(12), fontFamily: AppFonts.sansFont500),
                        dialogTextStyle:
                            TextStyle(fontSize: getProportionalFontSize(12.5), fontFamily: AppFonts.sansFont500),
                        builder: (CountryCode? countryCode) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(16),
                              right: getProportionateScreenWidth(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(20),
                                  width: getProportionateScreenWidth(28),
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(countryCode!.flagUri!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(4),
                                ),
                                Text(
                                  countryCode.dialCode ?? '+965',
                                  style: TextStyle(
                                    fontFamily: AppFonts.sansFont400,
                                    fontSize: getProportionalFontSize(14),
                                    color: AppColors.textFieldGreyColor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.textFieldGreyColor,
                                  size: 24,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // prefixIcon: Container(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: getProportionateScreenWidth(12),
                      //     vertical: getProportionateScreenHeight(12),
                      //   ),
                      //   child: SvgPicture.asset(
                      //     AppImages.email,
                      //     height: getProportionateScreenHeight(24),
                      //     width: getProportionateScreenWidth(24),
                      //   ),
                      // ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(14),
                    ),
                    CommonTextField(
                      hintText: AppLocalizations.of(context)!.dateOfBirth,
                      onTap: () {
                        Utils.datePicker(
                          context,
                          firstDate: DateTime(DateTime.now().year - 100),
                          // lastDate: DateTime(DateTime.now().year - 16),
                          lastDate: DateTime.now(),
                          initialDate: DateTime.now(),
                        );
                      },
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(12),
                          vertical: getProportionateScreenHeight(12),
                        ),
                        child: SvgPicture.asset(
                          AppImages.calendar,
                          height: getProportionateScreenHeight(24),
                          width: getProportionateScreenWidth(24),
                        ),
                      ),
                      suffix: Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                        color: AppColors.textFieldGreyColor,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(14),
                    ),
                    CommonTextField(
                      hintText: AppLocalizations.of(context)!.preferredUsername,
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(12),
                          vertical: getProportionateScreenHeight(12),
                        ),
                        child: SvgPicture.asset(
                          AppImages.editIcon,
                          height: getProportionateScreenHeight(24),
                          width: getProportionateScreenWidth(24),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(14),
                    ),
                    CommonTextField(
                      hintText: AppLocalizations.of(context)!.password,
                      obscure: controller.isObscure,
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
                      suffix: IconButton(
                        onPressed: () {
                          controller.isObscure = !controller.isObscure;
                          controller.update();
                        },
                        icon: controller.isObscure
                            ? Icon(
                                Icons.visibility,
                                size: 24,
                                color: Colors.black87,
                              )
                            : Icon(
                                Icons.visibility_off,
                                size: 24,
                                color: Colors.black87,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(14),
                    ),
                    CommonTextField(
                      hintText: AppLocalizations.of(context)!.confirmPassword,
                      obscure: controller.isObscureConfirm,
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
                      suffix: IconButton(
                        onPressed: () {
                          controller.isObscureConfirm = !controller.isObscureConfirm;
                          controller.update();
                        },
                        icon: controller.isObscureConfirm
                            ? Icon(
                                Icons.visibility,
                                size: 24,
                                color: Colors.black87,
                              )
                            : Icon(
                                Icons.visibility_off,
                                size: 24,
                                color: Colors.black87,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: controller.termValue,
                            onChanged: (value) {
                              controller.termValue = value ?? false;
                              controller.update();
                            },
                            activeColor: Colors.black,
                            checkColor: Colors.black,
                            fillColor: MaterialStateProperty.all(Colors.white),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(width: 1.4, color: Colors.black),
                            ),
                          ),
                          // Text("I agree to Terms and Conditions"),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!.iAgreeTo,
                                  style: TextStyle(
                                    fontSize: getProportionalFontSize(12),
                                    fontFamily: AppFonts.sansFont400,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!.termsAndConditions,
                                  recognizer: TapGestureRecognizer()..onTap = () {},
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: getProportionalFontSize(12),
                                    fontFamily: AppFonts.sansFont700,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    SizedBox(
                      width: SizeConfig.deviceWidth,
                      child: ElevatedButton(
                        onPressed: () {
                          ///Success
                          Utils.showCustomDialog(
                            context: context,
                            barrierDismissible: false,
                            child: Center(
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(32),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 1.5,
                                    sigmaY: 1.5,
                                  ),
                                  child: Container(
                                    width: SizeConfig.deviceWidth! * .85,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getProportionateScreenWidth(16),
                                      vertical: getProportionateScreenHeight(60),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        getProportionateScreenWidth(32),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: getProportionateScreenHeight(141),
                                          width: getProportionateScreenWidth(141),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(AppImages.registrationSuccess),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.registrationSuccessful,
                                          style: TextStyle(
                                            fontFamily: AppFonts.sansFont600,
                                            fontSize: getProportionalFontSize(20),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: getProportionateScreenHeight(10),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.youWillBeRedirectedToTheLogInPage,
                                          style: TextStyle(
                                            fontFamily: AppFonts.sansFont400,
                                            fontSize: getProportionalFontSize(16),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: getProportionateScreenHeight(28),
                                        ),
                                        CommonButton(
                                          width: getProportionateScreenWidth(196),
                                          text: AppLocalizations.of(context)!.done,
                                          onPressed: () {
                                            Get.back();
                                            Get.offAllNamed(Routes.DASHBOARD);
                                          },
                                          radius: 50,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );

                          ///Fail
                          // Utils.showCustomDialog(
                          //     context: context,
                          //     child: Center(
                          //       child: Material(
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.circular(
                          //           getProportionateScreenWidth(32),
                          //         ),
                          //         child: BackdropFilter(
                          //           filter: ImageFilter.blur(
                          //             sigmaX: 1.5,
                          //             sigmaY: 1.5,
                          //           ),
                          //           child: Container(
                          //             width: SizeConfig.deviceWidth! * .85,
                          //             padding: EdgeInsets.symmetric(
                          //               horizontal: getProportionateScreenWidth(16),
                          //               vertical: getProportionateScreenHeight(60),
                          //             ),
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(
                          //                 getProportionateScreenWidth(32),
                          //               ),
                          //               color: Colors.white,
                          //             ),
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               mainAxisSize: MainAxisSize.min,
                          //               children: [
                          //                 Container(
                          //                   height: getProportionateScreenHeight(141),
                          //                   width: getProportionateScreenWidth(141),
                          //                   margin: EdgeInsets.only(
                          //                     left: getProportionateScreenWidth(32),
                          //                   ),
                          //                   decoration: BoxDecoration(
                          //                     image: DecorationImage(
                          //                       image: AssetImage(AppImages.registrationFail),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 Text(
                          //                   "Registration\nUnsucessful",
                          //                   style: TextStyle(
                          //                     fontFamily: AppFonts.sansFont600,
                          //                     fontSize: getProportionalFontSize(20),
                          //                   ),
                          //                   textAlign: TextAlign.center,
                          //                 ),
                          //                 SizedBox(
                          //                   height: getProportionateScreenHeight(10),
                          //                 ),
                          //                 Text(
                          //                   "*Display reason for unnsuccessful registration*",
                          //                   style: TextStyle(
                          //                     fontFamily: AppFonts.sansFont400,
                          //                     fontSize: getProportionalFontSize(16),
                          //                   ),
                          //                   textAlign: TextAlign.center,
                          //                 ),
                          //                 SizedBox(
                          //                   height: getProportionateScreenHeight(28),
                          //                 ),
                          //                 CommonButton(
                          //                   width: getProportionateScreenWidth(196),
                          //                   text: "Done",
                          //                   onPressed: () {
                          //                     Get.back();
                          //                   },
                          //                   radius: 50,
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ));
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
                          AppLocalizations.of(context)!.register,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionalFontSize(16),
                            fontFamily: AppFonts.sansFont600,
                            color: AppColors.whiteColor,
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
}
