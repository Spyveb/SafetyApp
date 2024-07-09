import 'package:distress_app/helpers/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../imports.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

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
                                  controller.firstNameController.text, context, "First Name"),
                              onChanged: (value) {
                                controller.firstNameController.text = value;
                                controller.update();
                              },
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
                              validation: (value) =>
                                  Validation.emptyValidation(controller.lastNameController.text, context, "Last Name"),
                              onChanged: (value) {
                                controller.lastNameController.text = value;
                                controller.update();
                              },
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
                          Validation.emailValidation(controller.emailController.text, "email", context),
                      onChanged: (value) {
                        controller.emailController.text = value;
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
                      height: getProportionateScreenHeight(14),
                    ),
                    CommonTextField(
                      hintText: AppLocalizations.of(context)!.phoneNumber,
                      textEditingController: controller.phoneNumberController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validation: (value) => Validation.mobileValidationWithCode(
                          controller.phoneNumberController.text, context, "Phone Number"),
                      onChanged: (value) {
                        controller.phoneNumberController.text = value;
                        controller.update();
                      },
                      prefixIcon: CountryCodePicker(
                        hideMainText: true,
                        onChanged: (value) {
                          controller.selectedCountryCode = value;
                        },
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
                      textEditingController: controller.birthDateController,
                      readOnly: true,
                      validation: (value) =>
                          Validation.emptyValidation(controller.birthDateController.text, context, "Date of Birth"),
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
                      textEditingController: controller.userNameController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validation: (value) =>
                          Validation.emptyValidation(controller.userNameController.text, context, "User Name"),
                      onChanged: (value) {
                        controller.userNameController.text = value;
                        controller.update();
                      },
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
                      validation: (value) =>
                          Validation.emptyValidation(controller.passwordController.text, context, "Password"),
                      onChanged: (value) {
                        controller.passwordController.text = value;
                        controller.update();
                      },
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
                          return 'Please enter password again';
                        } else if (value != controller.passwordController.text) {
                          return "Password and confirm password does not match";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.confirmPasswordController.text = value;
                        controller.update();
                      },
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
                    CommonButton(
                      text: AppLocalizations.of(context)!.register,
                      radius: getProportionateScreenWidth(10),
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(22),
                      ),
                      onPressed: controller.formKey.currentState != null &&
                              controller.formKey.currentState!.validate() &&
                              controller.termValue == true
                          ? () {
                              controller.signUpMethod();
                            }
                          : null,
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
