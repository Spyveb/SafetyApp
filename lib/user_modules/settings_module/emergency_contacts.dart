import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EmergencyContactsScreen extends GetView<SettingsController> {
  const EmergencyContactsScreen({super.key});

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
              controller.getEmergencyContactList();
            });
          },
          builder: (controller) {
            return BackgroundWidget(
              child: Column(
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
                          AppLocalizations.of(context)!.emergencyContacts,
                          style: TextStyle(
                            fontSize: getProportionalFontSize(24),
                            color: themeProvider.textThemeColor,
                            fontFamily: AppFonts.sansFont600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(8),
                      ),
                      IconButton.filledTonal(
                        onPressed: () {
                          Get.toNamed(
                            Routes.ADD_EMERGENCY_CONTACTS,
                            arguments: {"isFromEdit": false},
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(14),
                      ),
                    ],
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
                            child: controller.emergencyContactList.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                      vertical: getProportionateScreenHeight(12),
                                    ),
                                    itemCount: controller.emergencyContactList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      EmergencyContactModel contact = controller.emergencyContactList[index];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Divider(
                                            height: 1,
                                            color: AppColors.blackColor.withOpacity(.4),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: getProportionateScreenHeight(10),
                                              horizontal: getProportionateScreenWidth(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${contact.name}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: getProportionalFontSize(14),
                                                          color: themeProvider.textThemeColor,
                                                          fontFamily: AppFonts.sansFont600,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${contact.mobileNumber}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: getProportionalFontSize(12),
                                                          color: themeProvider.lightTextThemeColor,
                                                          fontFamily: AppFonts.sansFont400,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        Get.toNamed(
                                                          Routes.ADD_EMERGENCY_CONTACTS,
                                                          arguments: {"isFromEdit": true, "model": contact},
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: getProportionateScreenWidth(4),
                                                        ),
                                                        child: SvgPicture.asset(
                                                          AppImages.editIcon,
                                                          color: AppColors.blackColor.withOpacity(.6),
                                                          width: getProportionateScreenWidth(20),
                                                          height: getProportionateScreenHeight(20),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        if (contact.id != null) {
                                                          controller.deleteEmergencyContact(deleteId: contact.id!);
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.delete_outline,
                                                        size: 24,
                                                        color: AppColors.redDefault.withOpacity(.75),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: index == 19,
                                            child: Divider(
                                              height: 1,
                                              color: AppColors.blackColor.withOpacity(.4),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : SizedBox(),
                          ),

                          SizedBox(
                            width: SizeConfig.deviceWidth,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(
                                  Routes.ADD_EMERGENCY_CONTACTS,
                                  arguments: {"isFromEdit": false},
                                );
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.white10),
                                backgroundColor: MaterialStateProperty.all(
                                  AppColors.primaryColor,
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(16),
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
                                AppLocalizations.of(context)!.addNewContact,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: getProportionalFontSize(16),
                                  fontFamily: AppFonts.sansFont600,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          // CommonButton(
                          //   width: SizeConfig.deviceWidth,
                          //   text: AppLocalizations.of(context)!.save,
                          //   onPressed: () {
                          //     Utils.showCustomDialog(
                          //       context: context,
                          //       child: Center(
                          //         child: Material(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(
                          //             getProportionateScreenWidth(32),
                          //           ),
                          //           child: BackdropFilter(
                          //             filter: ImageFilter.blur(
                          //               sigmaX: 1.5,
                          //               sigmaY: 1.5,
                          //             ),
                          //             child: Container(
                          //               width: SizeConfig.deviceWidth! * .85,
                          //               padding: EdgeInsets.symmetric(
                          //                 horizontal: getProportionateScreenWidth(16),
                          //                 vertical: getProportionateScreenHeight(60),
                          //               ),
                          //               decoration: BoxDecoration(
                          //                 borderRadius: BorderRadius.circular(
                          //                   getProportionateScreenWidth(32),
                          //                 ),
                          //                 color: Colors.white,
                          //               ),
                          //               child: Column(
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 crossAxisAlignment: CrossAxisAlignment.center,
                          //                 mainAxisSize: MainAxisSize.min,
                          //                 children: [
                          //                   Container(
                          //                     height: getProportionateScreenHeight(141),
                          //                     width: getProportionateScreenWidth(141),
                          //                     decoration: BoxDecoration(
                          //                       image: DecorationImage(
                          //                         image: AssetImage(AppImages.registrationSuccess),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Text(
                          //                     AppLocalizations.of(context)!.emergencyContactsAdded,
                          //                     style: TextStyle(
                          //                       fontFamily: AppFonts.sansFont600,
                          //                       fontSize: getProportionalFontSize(20),
                          //                     ),
                          //                     textAlign: TextAlign.center,
                          //                   ),
                          //                   SizedBox(
                          //                     height: getProportionateScreenHeight(10),
                          //                   ),
                          //                   Text(
                          //                     AppLocalizations.of(context)!.allEmergencyContacts,
                          //                     style: TextStyle(
                          //                       fontFamily: AppFonts.sansFont400,
                          //                       fontSize: getProportionalFontSize(16),
                          //                     ),
                          //                     textAlign: TextAlign.center,
                          //                   ),
                          //                   SizedBox(
                          //                     height: getProportionateScreenHeight(28),
                          //                   ),
                          //                   CommonButton(
                          //                     width: getProportionateScreenWidth(196),
                          //                     text: AppLocalizations.of(context)!.done,
                          //                     onPressed: () {
                          //                       Get.back();
                          //                     },
                          //                     radius: 50,
                          //                   )
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // )
                        ],
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
