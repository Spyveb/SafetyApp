import 'dart:async';

import 'package:distress_app/componants/police_drawer_items.dart';
import 'package:distress_app/imports.dart';
import 'package:distress_app/packages/staggered_gridview/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../packages/advanced_drawer/flutter_advanced_drawer.dart';

class PoliceDashBoardScreen extends GetView<PoliceDashBoardController> {
  const PoliceDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PoliceDashBoardController>(
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // controller.showSOSDialog(context);
          controller.getUserName();
        });
      },
      init: PoliceDashBoardController(),
      global: true,
      autoRemove: false,
      builder: (controller) {
        return PopScope(
          canPop: controller.canPop,
          onPopInvoked: (didPop) {
            controller.canPop = true;
            controller.update();
            Utils.showToast(AppLocalizations.of(context)!.pressAgainToExit);
            Future.delayed(
              const Duration(seconds: 2),
              () {
                controller.canPop = false;
                controller.update();
              },
            );
          },
          child: AdvancedDrawer(
            backdropColor: Colors.white,
            controller: controller.advancedDrawerController,
            animationController: controller.animationController,
            openRatio: .60,
            disabledGestures: false,
            backdrop: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
            ),
            animationDuration: const Duration(milliseconds: 300),
            openScale: 0.7,
            childDecoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xFFF2EAEA),
                  blurRadius: 99,
                  spreadRadius: 0,
                  offset: Offset(-25.0, 19.0),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
            drawer: drawerMenu(context),
            animateChildDecoration: true,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      controller.advancedDrawerController.showDrawer();
                                    },
                                    child: Container(
                                      height: getProportionateScreenHeight(40),
                                      width: getProportionateScreenWidth(40),
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        AppImages.policeDrawerIcon,
                                        height: getProportionateScreenHeight(24),
                                        width: getProportionateScreenWidth(24),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.dashboard,
                                    style: TextStyle(
                                      fontSize: getProportionalFontSize(28),
                                      fontFamily: AppFonts.sansFont600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.showSOSDialog(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getProportionateScreenWidth(10),
                                        vertical: getProportionateScreenHeight(5),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: AppColors.policeDarkRedColor,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.logNewIncident,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getProportionalFontSize(10),
                                          fontFamily: AppFonts.sansFont600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(8),
                                  ),
                                  Image.asset(
                                    AppImages.policeNotification,
                                    height: getProportionateScreenHeight(24),
                                    width: getProportionateScreenWidth(24),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // controller.sosRequestAccept == false
                          //     ? SingleChildScrollView(
                          //         scrollDirection: Axis.horizontal,
                          //         clipBehavior: Clip.none,
                          //         child: Row(
                          //           children: List.generate(
                          //             4,
                          //             (index) {
                          //               return Container(
                          //                 padding: EdgeInsets.symmetric(
                          //                   horizontal: getProportionateScreenWidth(8),
                          //                   vertical: getProportionateScreenHeight(8),
                          //                 ),
                          //                 margin: EdgeInsets.only(
                          //                   right: getProportionateScreenWidth(14),
                          //                 ),
                          //                 decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(
                          //                     getProportionateScreenWidth(16),
                          //                   ),
                          //                   border: Border.all(
                          //                     color: AppColors.policeDarkBlueColor,
                          //                   ),
                          //                 ),
                          //                 constraints: BoxConstraints(minHeight: getProportionateScreenHeight(70)),
                          //                 child: Column(
                          //                   crossAxisAlignment: CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       "Total Incidents Assigned",
                          //                       style: TextStyle(
                          //                         fontSize: getProportionalFontSize(11),
                          //                         fontFamily: AppFonts.sansFont600,
                          //                       ),
                          //                     ),
                          //                     Text(
                          //                       "80",
                          //                       style: TextStyle(
                          //                         fontSize: getProportionalFontSize(25),
                          //                         fontFamily: AppFonts.sansFont600,
                          //                         color: AppColors.policeDarkBlueColor,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               );
                          //             },
                          //           ),
                          //         ),
                          //       )
                          //     : Row(
                          //         children: [
                          //           Flexible(
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.start,
                          //               children: [
                          //                 Text(
                          //                   "You are heading towards Anne Krane’s house",
                          //                   style: TextStyle(
                          //                     fontSize: getProportionalFontSize(14),
                          //                     fontFamily: AppFonts.sansFont600,
                          //                   ),
                          //                 ),
                          //                 Text(
                          //                   "You can also use the siren if there is traffic",
                          //                   style: TextStyle(
                          //                     fontSize: getProportionalFontSize(11),
                          //                     fontFamily: AppFonts.sansFont600,
                          //                     color: AppColors.redDefault,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           Column(
                          //             children: [
                          //               GestureDetector(
                          //                 onTap: () {
                          //                   controller.showBackupRequestDialog(context);
                          //                 },
                          //                 child: Container(
                          //                   decoration: BoxDecoration(
                          //                     color: AppColors.redDefault,
                          //                     borderRadius: BorderRadius.circular(
                          //                       getProportionateScreenWidth(30),
                          //                     ),
                          //                   ),
                          //                   padding: EdgeInsets.symmetric(
                          //                     horizontal: getProportionateScreenWidth(15),
                          //                     vertical: getProportionateScreenHeight(8),
                          //                   ),
                          //                   constraints: BoxConstraints(minWidth: getProportionateScreenWidth(130)),
                          //                   child: Center(
                          //                     child: Text(
                          //                       AppLocalizations.of(context)!.requestBackup,
                          //                       style: TextStyle(
                          //                         color: Colors.white,
                          //                         fontSize: getProportionalFontSize(12),
                          //                         fontFamily: AppFonts.sansFont600,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //               SizedBox(
                          //                 height: getProportionateScreenHeight(10),
                          //               ),
                          //               GestureDetector(
                          //                 onTap: () {
                          //                   Get.back();
                          //                   controller.showEndSosDialog(context);
                          //                 },
                          //                 child: Container(
                          //                   decoration: BoxDecoration(
                          //                     color: AppColors.redDefault,
                          //                     borderRadius: BorderRadius.circular(
                          //                       getProportionateScreenWidth(30),
                          //                     ),
                          //                   ),
                          //                   constraints: BoxConstraints(minWidth: getProportionateScreenWidth(130)),
                          //                   padding: EdgeInsets.symmetric(
                          //                     horizontal: getProportionateScreenWidth(15),
                          //                     vertical: getProportionateScreenHeight(8),
                          //                   ),
                          //                   child: Center(
                          //                     child: Text(
                          //                       AppLocalizations.of(context)!.endSos,
                          //                       style: TextStyle(
                          //                         color: Colors.white,
                          //                         fontSize: getProportionalFontSize(12),
                          //                         fontFamily: AppFonts.sansFont600,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           )
                          //         ],
                          //       ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(14),
                          vertical: getProportionateScreenHeight(14),
                        ),
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: getProportionateScreenHeight(20),
                          crossAxisSpacing: getProportionateScreenWidth(20),
                          children: List.generate(8, (index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(14),
                                vertical: getProportionateScreenHeight(14),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(16),
                                ),
                                border: Border.all(
                                  color: AppColors.policeDarkBlueColor,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Incidents Assigned ",
                                    style: TextStyle(
                                      fontSize: getProportionalFontSize(19),
                                      fontFamily: AppFonts.sansFont600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Text(
                                    "80",
                                    style: TextStyle(
                                      fontSize: getProportionalFontSize(25),
                                      fontFamily: AppFonts.sansFont600,
                                      color: AppColors.policeDarkBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: getProportionateScreenHeight(12),
                    // ),
                    // Flexible(
                    //   child: GoogleMap(
                    //     zoomControlsEnabled: true,
                    //     mapType: MapType.normal,
                    //
                    //     buildingsEnabled: true,
                    //
                    //     onCameraIdle: () {},
                    //     initialCameraPosition: CameraPosition(
                    //       target: LatLng(23.0296, 72.5301),
                    //       zoom: 12,
                    //     ),
                    //     myLocationButtonEnabled: false,
                    //     fortyFiveDegreeImageryEnabled: true,
                    //
                    //     // Update location on camera move
                    //     onCameraMove: (CameraPosition cameraPosition) async {},
                    //     onMapCreated: (GoogleMapController gController) {
                    //       // Complete the Google Map controller
                    //       controller.googleMapControllerCompleter = Completer();
                    //       controller.googleMapControllerCompleter.complete(gController);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
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
              "${controller.firstName}, Police Officer",
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
                    text: "Available",
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont700,
                      fontSize: getProportionalFontSize(14),
                      color: Colors.green,
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
