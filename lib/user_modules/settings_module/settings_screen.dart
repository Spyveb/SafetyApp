import 'dart:ui';

import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

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
          initState: (state) {
            controller.getUserProfile(showLoader: false);
          },
          builder: (controller) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(12),
                horizontal: getProportionateScreenWidth(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.settings,
                    style: TextStyle(
                      fontSize: getProportionalFontSize(32),
                      color: themeProvider.textThemeColor,
                      fontFamily: AppFonts.sansFont600,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.customizeApp,
                    style: TextStyle(
                      fontSize: getProportionalFontSize(16),
                      color: themeProvider.lightTextThemeColor,
                      fontFamily: AppFonts.sansFont400,
                    ),
                  ),
                  // SizedBox(
                  //   height: getProportionateScreenHeight(32),
                  // ),
                  // SettingsTile(
                  //   themeProvider: themeProvider,
                  //   text: AppLocalizations.of(context)!.chooseAppLanguage,
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //       context: context,
                  //       enableDrag: true,
                  //       clipBehavior: Clip.none,
                  //       builder: (context) {
                  //         return GetBuilder<SettingsController>(
                  //           builder: (controller) {
                  //             return GridView.builder(
                  //               itemCount: controller.languages.length,
                  //               shrinkWrap: true,
                  //               padding: EdgeInsets.symmetric(
                  //                 horizontal: getProportionateScreenWidth(12),
                  //                 vertical: getProportionateScreenHeight(12),
                  //               ),
                  //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //                 crossAxisCount: 2,
                  //                 childAspectRatio: 1,
                  //               ),
                  //               itemBuilder: (context, index) {
                  //                 LanguageModel languageModel = controller.languages[index];
                  //                 return GestureDetector(
                  //                   onTap: () async {
                  //                     controller.updateLanguage(languageModel, context);
                  //                   },
                  //                   behavior: HitTestBehavior.opaque,
                  //                   child: Container(
                  //                     padding: EdgeInsets.symmetric(
                  //                       vertical: getProportionateScreenHeight(16),
                  //                       horizontal: getProportionateScreenWidth(16),
                  //                     ),
                  //                     margin: EdgeInsets.symmetric(
                  //                       horizontal: getProportionateScreenWidth(12),
                  //                       vertical: getProportionateScreenHeight(12),
                  //                     ),
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.circular(
                  //                         getProportionateScreenWidth(10),
                  //                       ),
                  //                       boxShadow: [
                  //                         BoxShadow(
                  //                           color: Colors.grey[200]!,
                  //                           blurRadius: 5,
                  //                           spreadRadius: 1,
                  //                         )
                  //                       ],
                  //                     ),
                  //                     // child: Stack(
                  //                     //   children: [
                  //                     //     Center(
                  //                     //       child: Column(
                  //                     //         mainAxisSize: MainAxisSize.min,
                  //                     //         children: [
                  //                     //           const SizedBox(
                  //                     //             height: 5,
                  //                     //           ),
                  //                     //         ],
                  //                     //       ),
                  //                     //     ),
                  //                     //     controller.locale?.languageCode == languageModel.languageCode
                  //                     //         ? const Positioned(
                  //                     //             top: 0,
                  //                     //             left: 0,
                  //                     //             right: 0,
                  //                     //             bottom: 90,
                  //                     //             child: Icon(
                  //                     //               Icons.check_circle,
                  //                     //               color: Color(0xFF0043CE),
                  //                     //             ),
                  //                     //           )
                  //                     //         : const SizedBox(),
                  //                     //   ],
                  //                     // ),
                  //
                  //                     child: Column(
                  //                       crossAxisAlignment: CrossAxisAlignment.center,
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       children: [
                  //                         Image.asset(
                  //                           languageModel.imageUrl,
                  //                           height: getProportionateScreenHeight(40),
                  //                           width: getProportionateScreenWidth(40),
                  //                         ),
                  //                         SizedBox(
                  //                           height: getProportionateScreenHeight(4),
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment: MainAxisAlignment.center,
                  //                           crossAxisAlignment: CrossAxisAlignment.center,
                  //                           children: [
                  //                             Text(
                  //                               languageModel.languageName,
                  //                               maxLines: 1,
                  //                               overflow: TextOverflow.ellipsis,
                  //                               style: TextStyle(
                  //                                   color: themeProvider.textThemeColor,
                  //                                   fontSize: getProportionalFontSize(16),
                  //                                   fontFamily: AppFonts.sansFont500),
                  //                             ),
                  //                             controller.locale?.languageCode == languageModel.languageCode
                  //                                 ? Padding(
                  //                                     padding: EdgeInsets.symmetric(
                  //                                       horizontal: getProportionateScreenWidth(4),
                  //                                     ),
                  //                                     child: Icon(
                  //                                       Icons.check_circle,
                  //                                       color: AppColors.primaryColor,
                  //                                       size: 24,
                  //                                     ),
                  //                                   )
                  //                                 : SizedBox(),
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 );
                  //               },
                  //             );
                  //           },
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  // SettingsTile(
                  //   themeProvider: themeProvider,
                  //   text: AppLocalizations.of(context)!.setAppTheme,
                  //   onTap: () {},
                  // ),
                  // SizedBox(
                  //   height: getProportionateScreenHeight(8),
                  // ),
                  SettingsTile(
                    themeProvider: themeProvider,
                    text: AppLocalizations.of(context)!.addEmergencyContacts,
                    onTap: () {
                      Get.toNamed(Routes.EMERGENCY_CONTACTS);
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  SettingsTile(
                    themeProvider: themeProvider,
                    text: AppLocalizations.of(context)!.editProfile,
                    onTap: () {
                      Get.toNamed(Routes.EDIT_PROFILE);
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  SettingsTile(
                    themeProvider: themeProvider,
                    text: AppLocalizations.of(context)!.changePassword,
                    onTap: () {
                      Get.toNamed(Routes.EDIT_PROFILE);
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  SettingsTile(
                    themeProvider: themeProvider,
                    text: AppLocalizations.of(context)!.reportAnonymously,
                    onTap: () {},
                    suffix: CommonSwitch(
                      value: controller.reportAnonymously,
                      onChanged: (value) {
                        controller.switchReportAnonymously(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  SettingsTile(
                    themeProvider: themeProvider,
                    text: AppLocalizations.of(context)!.logout,
                    onTap: () {
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
                                          style:
                                              TextStyle(fontFamily: AppFonts.sansFont700, fontSize: getProportionalFontSize(22), color: AppColors.primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: getProportionateScreenHeight(10),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.areYouSureYouWantToLogout,
                                          style:
                                              TextStyle(fontFamily: AppFonts.sansFont500, fontSize: getProportionalFontSize(16), color: AppColors.blackColor),
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
                                                onPressed: () async {
                                                  Get.back();
                                                  await StorageService().deleteAllSecureData();
                                                  Get.offAllNamed(Routes.SIGN_IN);
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
                    suffix: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.logout,
                        color: themeProvider.textThemeColor,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
