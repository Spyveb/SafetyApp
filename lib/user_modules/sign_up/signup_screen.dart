import 'dart:io';

import 'package:distress_app/imports.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignUpController>(
        init: SignUpController(),
        autoRemove: false,
        global: true,
        builder: (SignUpController signUpController) {
          return SafeArea(
            child: BackgroundWidget(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24),
                  vertical: getProportionateScreenHeight(16),
                ),
                child: Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
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
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                            if (xFile != null) {
                              controller.profileImage = File(xFile.path);
                              controller.update();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(16),
                              horizontal: getProportionateScreenWidth(16),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyColor,
                              image: controller.profileImage != null
                                  ? DecorationImage(
                                      image: FileImage(controller.profileImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: Container(
                              height: getProportionateScreenHeight(60),
                              width: getProportionateScreenWidth(60),
                              padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(28),
                                horizontal: getProportionateScreenWidth(28),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                image: controller.profileImage == null
                                    ? DecorationImage(
                                        image: AssetImage(AppImages.userImage),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              // child: SvgPicture.asset(AppImages.editIcon),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(18),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CommonTextField(
                                hintText: AppLocalizations.of(context)!.firstName,
                                textEditingController: controller.firstNameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validation: (value) => Validation.emptyValidation(
                                  controller.firstNameController.text,
                                  context,
                                  AppLocalizations.of(context)!.firstName.capitalize,
                                ),
                                // onChanged: (value) {
                                //   controller.firstNameController.text = value;
                                //   controller.update();
                                // },
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
                                textEditingController: controller.lastNameController,
                                textInputAction: TextInputAction.next,
                                validation: (value) => Validation.emptyValidation(
                                  controller.lastNameController.text,
                                  context,
                                  AppLocalizations.of(context)!.lastName.capitalize,
                                ),
                                // onChanged: (value) {
                                //   controller.lastNameController.text = value;
                                //   controller.update();
                                // },
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
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(14),
                      ),

                      CommonTextField(
                        hintText: AppLocalizations.of(context)!.email,
                        textEditingController: controller.emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validation: (value) =>
                            Validation.emailValidation(controller.emailController.text, AppLocalizations.of(context)!.email.capitalize, context),
                        // onChanged: (value) {
                        //   controller.emailController.text = value;
                        //   controller.update();
                        // },
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
                        textEditingController: controller.phoneNumberController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        // validation: (value) => Validation.mobileValidationWithCode(
                        //   controller.phoneNumberController.text,
                        //   context,
                        //   AppLocalizations.of(context)!.phoneNumber.capitalize,
                        // ),
                        validation: (value) => Validation.mobileValidationWithCountryCode(
                          controller.phoneNumberController.text,
                          context,
                          AppLocalizations.of(context)!.phoneNumber.capitalize,
                          controller.selectedCountryCode.dialCode ?? '+91',
                        ),
                        // onChanged: (value) {
                        //   controller.phoneNumberController.text = value;
                        //   controller.update();
                        // },
                        prefixIcon: CountryCodePicker(
                          hideMainText: true,
                          onChanged: (value) {
                            controller.selectedCountryCode = value;
                            controller.update();
                          },
                          // enabled: false,
                          // initialSelection: widget.initialSelection,
                          alignLeft: true,
                          barrierColor: Colors.transparent,
                          favorite: [
                            // widget.initialSelection ?? '+965',
                          ],
                          searchStyle: TextStyle(fontSize: getProportionalFontSize(12), fontFamily: AppFonts.sansFont500),
                          dialogTextStyle: TextStyle(fontSize: getProportionalFontSize(12.5), fontFamily: AppFonts.sansFont500),
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
                        textEditingController: controller.birthDateController,
                        readOnly: true,
                        validation: (value) => Validation.emptyValidation(
                          controller.birthDateController.text,
                          context,
                          AppLocalizations.of(context)!.dateOfBirth.capitalize,
                        ),
                        onTap: () async {
                          DateTime? initialDate;
                          if (controller.birthDateController.text.isNotEmpty) {
                            initialDate = DateFormat("dd/MM/yyyy").parse(controller.birthDateController.text);
                          }
                          String? selectedDate = await Utils.datePicker(
                            context,
                            firstDate: DateTime(DateTime.now().year - 100),
                            initialDate: initialDate,
                            lastDate: DateTime.now(),
                          );

                          if (selectedDate != null && selectedDate.isNotEmpty) {
                            controller.birthDateController.text = selectedDate;
                            controller.update();
                          }
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
                        // suffix: Icon(
                        //   Icons.arrow_drop_down,
                        //   size: 24,
                        //   color: AppColors.textFieldGreyColor,
                        // ),
                      ),
                      // SizedBox(
                      //   height: getProportionateScreenHeight(14),
                      // ),
                      // ButtonTheme(
                      //   alignedDropdown: true,
                      //   child: DropdownButtonFormField<String>(
                      //     value: controller.role,
                      //     iconSize: 24,
                      //     iconEnabledColor: AppColors.blackColor,
                      //     isDense: true,
                      //     isExpanded: true,
                      //     decoration: InputDecoration(
                      //       // suffixIcon: IconButton(
                      //       //   onPressed: () {},
                      //       //   icon: Icon(
                      //       //     Icons.arrow_drop_down_outlined,
                      //       //     size: 36,
                      //       //     color: AppColors.blackColor,
                      //       //   ),
                      //       // ),
                      //       errorMaxLines: 2,
                      //       isDense: true,
                      //
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(
                      //           getProportionateScreenWidth(10),
                      //         ),
                      //         borderSide: BorderSide(color: AppColors.textFieldGreyColor, width: 2),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(
                      //           getProportionateScreenWidth(10),
                      //         ),
                      //         borderSide: BorderSide(color: Colors.black87, width: 1.5),
                      //       ),
                      //       disabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(
                      //           getProportionateScreenWidth(10),
                      //         ),
                      //         borderSide: BorderSide(color: AppColors.textFieldGreyColor, width: 2),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(
                      //           getProportionateScreenWidth(10),
                      //         ),
                      //         borderSide: BorderSide(color: AppColors.textFieldGreyColor, width: 2),
                      //       ),
                      //       // labelText: widget.lableText,
                      //       hintText: "",
                      //       hintStyle: TextStyle(
                      //         fontFamily: AppFonts.sansFont400,
                      //         fontSize: getProportionalFontSize(14),
                      //         color: AppColors.textFieldGreyColor,
                      //       ),
                      //       errorStyle: TextStyle(
                      //         fontSize: getProportionalFontSize(12),
                      //         fontFamily: AppFonts.sansFont400,
                      //         color: AppColors.redDefault,
                      //       ),
                      //
                      //       contentPadding: EdgeInsets.symmetric(
                      //         horizontal: getProportionateScreenWidth(16),
                      //         vertical: getProportionateScreenHeight(20),
                      //       ),
                      //       prefixIcon: Container(
                      //         padding: EdgeInsets.only(
                      //           left: getProportionateScreenWidth(8),
                      //           top: getProportionateScreenHeight(8),
                      //           bottom: getProportionateScreenHeight(8),
                      //         ),
                      //         child: SvgPicture.asset(
                      //           AppImages.userProfile,
                      //           height: getProportionateScreenHeight(24),
                      //           width: getProportionateScreenWidth(24),
                      //         ),
                      //       ),
                      //     ),
                      //     items: controller.roleList.map<DropdownMenuItem<String>>((value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(
                      //           value,
                      //           style: TextStyle(
                      //             fontFamily: AppFonts.sansFont400,
                      //             fontSize: getProportionalFontSize(14),
                      //             color: AppColors.lightTextColor,
                      //           ),
                      //         ),
                      //       );
                      //     }).toList(),
                      //     onChanged: (value) {
                      //       controller.role = value ?? controller.roleList.first;
                      //       controller.update();
                      //     },
                      //     validator: (value) => Validation.emptyValidation(
                      //       value,
                      //       context,
                      //       AppLocalizations.of(context)!.role.capitalize,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: getProportionateScreenHeight(14),
                      ),
                      CommonTextField(
                        hintText: AppLocalizations.of(context)!.preferredUsername,
                        textEditingController: controller.userNameController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validation: (value) => Validation.emptyValidation(
                          controller.userNameController.text,
                          context,
                          AppLocalizations.of(context)!.userName.capitalize,
                        ),
                        // onChanged: (value) {
                        //   controller.userNameController.text = value;
                        //   controller.update();
                        // },
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
                        textEditingController: controller.passwordController,
                        obscure: controller.isObscure,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        validation: (value) => Validation.emptyValidation(
                          controller.passwordController.text,
                          context,
                          AppLocalizations.of(context)!.password.capitalize,
                        ),
                        // onChanged: (value) {
                        //   controller.passwordController.text = value;
                        //   controller.update();
                        // },
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
                        textEditingController: controller.confirmPasswordController,
                        obscure: controller.isObscureConfirm,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.pleaseEnterPasswordAgain;
                          } else if (value != controller.passwordController.text) {
                            return AppLocalizations.of(context)!.confirmPasswordDoesNotMatch;
                          }
                          return null;
                        },
                        // onChanged: (value) {
                        //   controller.confirmPasswordController.text = value;
                        //   controller.update();
                        // },
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
                                (states) => const BorderSide(width: 1.4, color: Colors.black),
                              ),
                            ),
                            // Text("I agree to Terms and Conditions"),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${AppLocalizations.of(context)!.iAgreeTo} ",
                                    style: TextStyle(
                                      fontSize: getProportionalFontSize(12),
                                      fontFamily: AppFonts.sansFont400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${AppLocalizations.of(context)!.termsAndConditions}",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes.HTML_SCREEN);
                                        Get.lazyPut(() => SettingsController());
                                        Get.find<SettingsController>().getTermsAndCondition();
                                      },
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
                      CommonButton(
                        text: AppLocalizations.of(context)!.register,
                        width: SizeConfig.deviceWidth,
                        radius: getProportionateScreenWidth(10),
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(22),
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.requestFocus();
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.termValue == true) {
                              controller.signUpMethod();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
