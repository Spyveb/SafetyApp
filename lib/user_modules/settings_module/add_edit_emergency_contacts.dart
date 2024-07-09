import 'dart:ui';

import 'package:distress_app/componants/common_button.dart';
import 'package:distress_app/componants/common_textfield.dart';
import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/helpers/utils.dart';
import 'package:distress_app/localization/app_localizations.dart';
import 'package:distress_app/modules/settings_module/settings_controller.dart';
import 'package:distress_app/providers/theme_provider.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddEditEmergencyContactsScreen extends GetView<SettingsController> {
  const AddEditEmergencyContactsScreen({super.key});

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
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(12),
                horizontal: getProportionateScreenWidth(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add contact",
                    style: TextStyle(
                      fontSize: getProportionalFontSize(28),
                      color: themeProvider.textThemeColor,
                      fontFamily: AppFonts.sansFont600,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(4),
                  ),
                  Text(
                    AppLocalizations.of(context)!.pleaseAddYourEmergencyContacts,
                    style: TextStyle(
                      fontSize: getProportionalFontSize(16),
                      color: themeProvider.lightTextThemeColor,
                      fontFamily: AppFonts.sansFont400,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  Divider(
                    height: 1,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(18),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextField(
                          textEditingController: controller.contactNameController,
                          hintText: "Enter contact name",
                          prefixIcon: Image.asset(
                            AppImages.contact,
                            height: getProportionateScreenHeight(18),
                            width: getProportionateScreenWidth(18),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(12),
                        ),
                        CommonTextField(
                          textEditingController: controller.contactNumberController,
                          hintText: "Enter contact number",
                          keyboardType: TextInputType.phone,
                          prefixIcon: Image.asset(
                            AppImages.contact,
                            height: getProportionateScreenHeight(18),
                            width: getProportionateScreenWidth(18),
                          ),
                          suffix: IconButton(
                            onPressed: () async {
                              controller.selectContact();
                            },
                            icon: Icon(
                              Icons.perm_contact_cal,
                              size: 32,
                              color: AppColors.blackColor.withOpacity(.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(12),
                  ),
                  CommonButton(
                    width: SizeConfig.deviceWidth,
                    text: AppLocalizations.of(context)!.save,
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(16),
                      horizontal: getProportionateScreenWidth(16),
                    ),
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
                                      AppLocalizations.of(context)!.emergencyContactsAdded,
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
                                      AppLocalizations.of(context)!.allEmergencyContacts,
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
                                        Get.back();
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
                    },
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
