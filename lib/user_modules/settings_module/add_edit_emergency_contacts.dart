import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddEditEmergencyContactsScreen extends GetView<SettingsController> {
  AddEditEmergencyContactsScreen({super.key});

  bool fromEdit = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: SafeArea(
        child: GetBuilder<SettingsController>(
          initState: (state) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              fromEdit = Get.arguments['isFromEdit'] ?? false;
              if (fromEdit) {
                if (Get.arguments['model'] != null && Get.arguments['model'] is EmergencyContactModel) {
                  controller.editContactModel = Get.arguments['model'];
                  controller.contactNameController.text = controller.editContactModel!.name ?? '';
                  controller.contactNumberController.text = controller.editContactModel!.mobileNumber ?? '';
                } else {
                  controller.editContactModel = null;
                  controller.clearData();
                }
              } else {
                controller.editContactModel = null;
                controller.clearData();
              }
            });
          },
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        AppLocalizations.of(context)!.addContact,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(24),
                          color: themeProvider.textThemeColor,
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(50),
                    right: getProportionateScreenWidth(8),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.pleaseAddYourEmergencyContacts,
                    style: TextStyle(
                      fontSize: getProportionalFontSize(14),
                      color: themeProvider.lightTextThemeColor,
                      fontFamily: AppFonts.sansFont400,
                    ),
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
                  height: getProportionateScreenHeight(8),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(12),
                      horizontal: getProportionateScreenWidth(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextField(
                                textEditingController: controller.contactNameController,
                                hintText: AppLocalizations.of(context)!.enterContactName,
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
                                hintText: AppLocalizations.of(context)!.enterContactNumber,
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
                            if (fromEdit) {
                              if (controller.editContactModel != null && controller.editContactModel!.id != null) {
                                controller.updateEmergencyContact(editId: controller.editContactModel!.id!);
                              }
                            } else {
                              controller.addEmergencyContact(context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
