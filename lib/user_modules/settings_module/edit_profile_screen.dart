import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends GetView<SettingsController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: SafeArea(
        child: GetBuilder<SettingsController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     IconButton(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: getProportionateScreenWidth(12),
                //       ),
                //       onPressed: () {
                //         Get.back();
                //       },
                //       icon: Icon(
                //         Icons.arrow_back,
                //         size: 24,
                //         color: AppColors.blackColor,
                //       ),
                //     ),
                //     SizedBox(
                //       width: getProportionateScreenWidth(12),
                //     ),
                //     Text(
                //       AppLocalizations.of(context)!.editProfile,
                //       style: TextStyle(
                //         fontSize: getProportionalFontSize(24),
                //         color: themeProvider.textThemeColor,
                //         fontFamily: AppFonts.sansFont600,
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(4),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.editProfile,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(24),
                          color: themeProvider.textThemeColor,
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(12),
                      horizontal: getProportionateScreenWidth(24),
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () async {
                                ImagePicker imagePicker = ImagePicker();
                                XFile? xFile =
                                    await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                                if (xFile != null) {
                                  controller.selectedImage = File(xFile.path);
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
                                  image: controller.selectedImage != null
                                      ? DecorationImage(
                                          image: FileImage(controller.selectedImage!),
                                          fit: BoxFit.cover,
                                        )
                                      : controller.profileImage != null && controller.profileImage!.isNotEmpty
                                          ? DecorationImage(
                                              image: CachedNetworkImageProvider(controller.profileImage!),
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
                                    image: controller.profileImage == null || controller.profileImage!.isEmpty
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
                            height: getProportionateScreenHeight(26),
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
                                        AppLocalizations.of(context)!.firstName.capitalize),
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
                                    validation: (value) => Validation.emptyValidation(
                                      controller.lastNameController.text,
                                      context,
                                      AppLocalizations.of(context)!.lastName.capitalize,
                                    ),
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
                            readOnly: true,
                            keyboardType: TextInputType.emailAddress,
                            validation: (value) => Validation.emailValidation(controller.emailController.text,
                                AppLocalizations.of(context)!.email.capitalize, context),
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
                              controller.phoneNumberController.text,
                              context,
                              AppLocalizations.of(context)!.phoneNumber.capitalize,
                            ),
                            onChanged: (value) {
                              controller.phoneNumberController.text = value;
                              controller.update();
                            },
                            prefixIcon: CountryCodePicker(
                              hideMainText: true,
                              onChanged: (value) {
                                controller.selectedCountryCode = value;
                                controller.update();
                              },
                              // enabled: false,
                              initialSelection: controller.selectedCountryCode.dialCode,
                              alignLeft: true,
                              barrierColor: Colors.transparent,
                              favorite: [
                                controller.selectedCountryCode.dialCode ?? '+93',
                              ],
                              searchStyle:
                                  TextStyle(fontSize: getProportionalFontSize(12), fontFamily: AppFonts.sansFont500),
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
                            readOnly: true,
                            validation: (value) => Validation.emptyValidation(controller.userNameController.text,
                                context, AppLocalizations.of(context)!.userName.capitalize),
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
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    // vertical: getProportionateScreenHeight(12),
                    horizontal: getProportionateScreenWidth(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonButton(
                        text: AppLocalizations.of(context)!.save,
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(18),
                          horizontal: getProportionateScreenWidth(12),
                        ),
                        width: SizeConfig.deviceWidth,
                        onPressed:
                            controller.formKey.currentState != null && controller.formKey.currentState!.validate()
                                ? () {
                                    controller.updateUserProfile();
                                  }
                                : null,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(8),
                      ),
                      TextButton(
                        onPressed: () {
                          Utils.showCustomDialog(
                            context: context,
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
                                  child: GetBuilder<SettingsController>(
                                    builder: (controller) {
                                      return Container(
                                        width: SizeConfig.deviceWidth! * .85,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: getProportionateScreenWidth(16),
                                          vertical: getProportionateScreenHeight(16),
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
                                            Text(
                                              AppLocalizations.of(context)!.confirmationMessage,
                                              style: TextStyle(
                                                  fontFamily: AppFonts.sansFont700,
                                                  fontSize: getProportionalFontSize(22),
                                                  color: AppColors.primaryColor),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: getProportionateScreenHeight(10),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.sureDeleteAccount,
                                              style: TextStyle(
                                                  fontFamily: AppFonts.sansFont500,
                                                  fontSize: getProportionalFontSize(16),
                                                  color: AppColors.blackColor),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: getProportionateScreenHeight(24),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CommonButton(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: getProportionateScreenWidth(24),
                                                      vertical: getProportionateScreenHeight(18),
                                                    ),
                                                    text: AppLocalizations.of(context)!.yes,
                                                    onPressed: () {
                                                      Get.back();
                                                      controller.deleteAccount();
                                                    },
                                                    radius: 50,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: getProportionateScreenWidth(18),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    behavior: HitTestBehavior.opaque,
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: getProportionateScreenWidth(24),
                                                        vertical: getProportionateScreenHeight(17),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(
                                                          getProportionateScreenWidth(50),
                                                        ),
                                                        border: Border.all(color: AppColors.blackColor, width: 1),
                                                      ),
                                                      child: Text(
                                                        AppLocalizations.of(context)!.no,
                                                        textAlign: TextAlign.center,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: getProportionalFontSize(16),
                                                          fontFamily: AppFonts.sansFont600,
                                                          color: AppColors.primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Delete Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont600,
                            color: AppColors.redDefault,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
