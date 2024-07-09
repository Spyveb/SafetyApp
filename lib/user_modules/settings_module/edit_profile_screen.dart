import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
          init: SettingsController(),
          builder: (controller) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(12),
                horizontal: getProportionateScreenWidth(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.editProfile,
                            style: TextStyle(
                              fontSize: getProportionalFontSize(32),
                              color: themeProvider.textThemeColor,
                              fontFamily: AppFonts.sansFont600,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: GestureDetector(
                          //     onTap: () async {
                          //       ImagePicker imagePicker = ImagePicker();
                          //       XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                          //       if (xFile != null) {
                          //         controller.selectedImage = File(xFile.path);
                          //         controller.update();
                          //       }
                          //     },
                          //     // child: Container(
                          //     //   padding: EdgeInsets.symmetric(
                          //     //     vertical: getProportionateScreenHeight(16),
                          //     //     horizontal: getProportionateScreenWidth(16),
                          //     //   ),
                          //     //   decoration: BoxDecoration(
                          //     //     shape: BoxShape.circle,
                          //     //     color: AppColors.greyColor,
                          //     //     image: controller.profileImage != null
                          //     //         ? DecorationImage(
                          //     //       image: FileImage(controller.profileImage!),
                          //     //       fit: BoxFit.cover,
                          //     //     )
                          //     //         : null,
                          //     //   ),
                          //     //   child: Container(
                          //     //     height: getProportionateScreenHeight(60),
                          //     //     width: getProportionateScreenWidth(60),
                          //     //     padding: EdgeInsets.symmetric(
                          //     //       vertical: getProportionateScreenHeight(28),
                          //     //       horizontal: getProportionateScreenWidth(28),
                          //     //     ),
                          //     //     decoration: BoxDecoration(
                          //     //       shape: BoxShape.circle,
                          //     //       color: Colors.transparent,
                          //     //       image: controller.profileImage == null
                          //     //           ? DecorationImage(
                          //     //         image: AssetImage(AppImages.userImage),
                          //     //         fit: BoxFit.cover,
                          //     //       )
                          //     //           : null,
                          //     //     ),
                          //     //     // child: SvgPicture.asset(AppImages.editIcon),
                          //     //   ),
                          //     // ),
                          //   ),
                          // ),
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
                                    validation: (value) => Validation.emptyValidation(
                                        controller.lastNameController.text, context, "Last Name"),
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
                                controller.birthDateController.text, context, "Date of Birth"),
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
                            validation: (value) =>
                                Validation.emptyValidation(controller.userNameController.text, context, "User Name"),
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
                  CommonButton(
                    text: AppLocalizations.of(context)!.save,
                    onPressed: () {},
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
