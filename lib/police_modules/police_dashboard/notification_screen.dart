import 'package:distress_app/componants/police_drawer_items.dart';
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends GetView<PoliceDashBoardController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PoliceDashBoardController>(
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BackgroundWidget(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
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
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 22,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                AppLocalizations.of(context)!.notification,
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
                          height: getProportionateScreenHeight(15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  drawerMenu(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            Container(
              height: getProportionateScreenHeight(90),
              width: getProportionateScreenWidth(90),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.policeUserIcon,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(12),
            ),
            Text(
              "${controller.firstName}, ${AppLocalizations.of(context)!.policeOfficer}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.sansFont600,
                fontSize: getProportionalFontSize(18),
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(4),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.status,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont500,
                      fontSize: getProportionalFontSize(14),
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: controller.status,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont700,
                      fontSize: getProportionalFontSize(14),
                      color: controller.status == 'Available' ? Colors.green : AppColors.redDefault,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(60),
            ),
            PoliceDrawerItems(
              itemName: AppLocalizations.of(context)!.dashboard,
              imageName: AppImages.policeDashboard,
              bottom: getProportionateScreenHeight(22),
              onTap: () {
                controller.advancedDrawerController.hideDrawer();
              },
            ),
            PoliceDrawerItems(
              itemName: AppLocalizations.of(context)!.sosEmergency,
              imageName: AppImages.policeSosEmergency,
              bottom: getProportionateScreenHeight(22),
              onTap: () {
                Get.toNamed(Routes.POLICE_SOSEMERGENCY);
                // controller.advancedDrawerController.hideDrawer();
              },
            ),
            PoliceDrawerItems(
              itemName: AppLocalizations.of(context)!.reportedEmergency,
              imageName: AppImages.policeReportedEmergency,
              bottom: getProportionateScreenHeight(22),
              onTap: () {
                Get.toNamed(Routes.POLICE_REPORTEDEMGCASES);
                // controller.advancedDrawerController.hideDrawer();
              },
            ),
            PoliceDrawerItems(
              itemName: AppLocalizations.of(context)!.reportedNonEmergency,
              imageName: AppImages.policeReportedNonEmergency,
              bottom: getProportionateScreenHeight(22),
              onTap: () {
                Get.toNamed(Routes.POLICE_REPORTEDNONEMGCASES);
                // controller.advancedDrawerController.hideDrawer();
              },
            ),
            PoliceDrawerItems(
              itemName: AppLocalizations.of(context)!.settings,
              imageName: AppImages.policeSetting,
              bottom: getProportionateScreenHeight(22),
              onTap: () {
                Get.toNamed(Routes.POLICE_SETTING);
              },
            ),
            // PoliceDrawerItems(
            //   itemName: AppLocalizations.of(context)!.logout,
            //   imageName: AppImages.policeLogout,
            //   onTap: () {
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
            //             child: GetBuilder<PoliceDashBoardController>(
            //               builder: (controller) {
            //                 return Container(
            //                   width: SizeConfig.deviceWidth! * .85,
            //                   padding: EdgeInsets.symmetric(
            //                     horizontal: getProportionateScreenWidth(16),
            //                     vertical: getProportionateScreenHeight(16),
            //                   ),
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(
            //                       getProportionateScreenWidth(32),
            //                     ),
            //                     color: Colors.white,
            //                   ),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: [
            //                       Text(
            //                         AppLocalizations.of(context)!.confirmationMessage,
            //                         style: TextStyle(
            //                             fontFamily: AppFonts.sansFont700,
            //                             fontSize: getProportionalFontSize(22),
            //                             color: AppColors.primaryColor),
            //                         textAlign: TextAlign.center,
            //                       ),
            //                       SizedBox(
            //                         height: getProportionateScreenHeight(10),
            //                       ),
            //                       Text(
            //                         AppLocalizations.of(context)!.areYouSureYouWantToLogout,
            //                         style: TextStyle(
            //                             fontFamily: AppFonts.sansFont500,
            //                             fontSize: getProportionalFontSize(16),
            //                             color: AppColors.blackColor),
            //                         textAlign: TextAlign.center,
            //                       ),
            //                       SizedBox(
            //                         height: getProportionateScreenHeight(24),
            //                       ),
            //                       Row(
            //                         children: [
            //                           Expanded(
            //                             child: CommonButton(
            //                               padding: EdgeInsets.symmetric(
            //                                 horizontal: getProportionateScreenWidth(24),
            //                                 vertical: getProportionateScreenHeight(18),
            //                               ),
            //                               text: AppLocalizations.of(context)!.yes,
            //                               onPressed: () async {
            //                                 Get.back();
            //                                 await StorageService().deleteAllSecureData();
            //                                 Get.offAllNamed(Routes.SIGN_IN);
            //                               },
            //                               radius: 50,
            //                             ),
            //                           ),
            //                           SizedBox(
            //                             width: getProportionateScreenWidth(18),
            //                           ),
            //                           Expanded(
            //                             child: GestureDetector(
            //                               onTap: () {
            //                                 Get.back();
            //                               },
            //                               behavior: HitTestBehavior.opaque,
            //                               child: Container(
            //                                 padding: EdgeInsets.symmetric(
            //                                   horizontal: getProportionateScreenWidth(24),
            //                                   vertical: getProportionateScreenHeight(17),
            //                                 ),
            //                                 decoration: BoxDecoration(
            //                                   borderRadius: BorderRadius.circular(
            //                                     getProportionateScreenWidth(50),
            //                                   ),
            //                                   border: Border.all(color: AppColors.blackColor, width: 1),
            //                                 ),
            //                                 child: Text(
            //                                   AppLocalizations.of(context)!.no,
            //                                   textAlign: TextAlign.center,
            //                                   maxLines: 1,
            //                                   overflow: TextOverflow.ellipsis,
            //                                   style: TextStyle(
            //                                     fontSize: getProportionalFontSize(16),
            //                                     fontFamily: AppFonts.sansFont600,
            //                                     color: AppColors.primaryColor,
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
