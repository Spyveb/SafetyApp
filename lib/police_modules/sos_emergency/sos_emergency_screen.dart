import 'dart:ui';

import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoliceSOSEmergencyScreen extends GetView<PoliceSOSEmergencyController> {
  const PoliceSOSEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<PoliceSOSEmergencyController>(
          init: PoliceSOSEmergencyController(),
          initState: (state) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              controller.getSOSEmergencyList(search: '');
            });
          },
          global: true,
          autoRemove: false,
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              AppLocalizations.of(context)!.sosEmergencyCases,
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
                        height: getProportionateScreenHeight(12),
                      ),
                    ],
                  ),
                ),

                controller.currentSOSReport != null
                    ? controller.currentSOSReport!.status == 'Open' && controller.currentSOSReport!.requestStatus == 'Accept'
                        ? Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(14),
                                    vertical: getProportionateScreenHeight(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "You are heading towards ${controller.currentSOSReport!.firstName} ${controller.currentSOSReport!.lastName}’s house",
                                              style: TextStyle(
                                                fontSize: getProportionalFontSize(14),
                                                fontFamily: AppFonts.sansFont600,
                                              ),
                                            ),
                                            Text(
                                              "You can also use the siren if there is traffic",
                                              style: TextStyle(
                                                fontSize: getProportionalFontSize(11),
                                                fontFamily: AppFonts.sansFont600,
                                                color: AppColors.redDefault,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          controller.currentSOSReport!.backupRequestStatus == 1
                                              // ? Container(
                                              //     decoration: BoxDecoration(
                                              //       color: Colors.green,
                                              //       borderRadius: BorderRadius.circular(
                                              //         getProportionateScreenWidth(
                                              //           getProportionateScreenWidth(50),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     padding: EdgeInsets.symmetric(
                                              //       horizontal: getProportionateScreenWidth(12),
                                              //       vertical: getProportionateScreenHeight(6),
                                              //     ),
                                              //     child: Row(
                                              //       children: [
                                              //         Text(
                                              //           "Backup request sent",
                                              //           style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontSize: getProportionalFontSize(12),
                                              //             fontFamily: AppFonts.sansFont600,
                                              //           ),
                                              //         ),
                                              //         Icon(
                                              //           Icons.check,
                                              //           color: AppColors.whiteColor,
                                              //           size: 18,
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   )
                                              ? Text(
                                                  "Backup request sent!!!",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: getProportionalFontSize(12),
                                                    fontFamily: AppFonts.sansFont600,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    // controller.showBackupRequestDialog(context);
                                                    if (controller.currentSOSReport!.id != null) {
                                                      controller.backupSOSEmergencyRequest(caseId: controller.currentSOSReport!.id!);
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.redDefault,
                                                      borderRadius: BorderRadius.circular(
                                                        getProportionateScreenWidth(
                                                          getProportionateScreenWidth(50),
                                                        ),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: getProportionateScreenWidth(12),
                                                      vertical: getProportionateScreenHeight(6),
                                                    ),
                                                    child: Text(
                                                      AppLocalizations.of(context)!.requestBackup,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: getProportionalFontSize(12),
                                                        fontFamily: AppFonts.sansFont600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            height: getProportionateScreenHeight(10),
                                          ),
                                          GestureDetector(
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
                                                      child: GetBuilder<PoliceSOSEmergencyController>(
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
                                                                  AppLocalizations.of(context)!.areYouSureYouWantToEndTheSOS,
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
                                                                        onPressed: () async {
                                                                          Get.back();
                                                                          if (controller.currentSOSReport!.id != null) {
                                                                            controller.showEndSosDialog(context, caseId: controller.currentSOSReport!.id!);
                                                                            // controller.closeSOSEmergencyRequest(
                                                                            //     caseId:
                                                                            //         controller.currentSOSReport!.id!);
                                                                          }
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
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.redDefault,
                                                borderRadius: BorderRadius.circular(
                                                  getProportionateScreenWidth(
                                                    getProportionateScreenWidth(50),
                                                  ),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: getProportionateScreenWidth(16),
                                                vertical: getProportionateScreenHeight(6),
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)!.endSos,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: getProportionalFontSize(12),
                                                  fontFamily: AppFonts.sansFont600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(14),
                                  ),
                                  child: CustomCasesList(
                                    caseNo: "${controller.currentSOSReport!.id}",
                                    status: "${controller.currentSOSReport!.status}",
                                    firstName: "${controller.currentSOSReport!.firstName ?? '-'}",
                                    lastName: "${controller.currentSOSReport!.lastName ?? '-'}",
                                    date: "${Utils.displayDateFormat(
                                      controller.currentSOSReport!.updatedAt ?? DateTime.now().toString(),
                                    )}",
                                    location: "${controller.currentSOSReport!.location ?? '-'}",
                                    city: "${controller.currentSOSReport!.city ?? '-'}",
                                    requestStatus: "${controller.currentSOSReport!.requestStatus}",
                                  ),
                                ),
                                Flexible(
                                  child: GoogleMap(
                                    zoomControlsEnabled: true,
                                    mapType: MapType.normal,
                                    markers: controller.markers.toSet(),
                                    buildingsEnabled: true,
                                    onCameraIdle: () {},
                                    initialCameraPosition: CameraPosition(
                                      target: controller.currentSOSReport!.latitude != null && controller.currentSOSReport!.longitude != null
                                          ? LatLng(
                                              double.parse(controller.currentSOSReport!.latitude!),
                                              double.parse(controller.currentSOSReport!.longitude!),
                                            )
                                          : LatLng(23.0296, 72.5301),
                                      zoom: 12,
                                    ),
                                    myLocationButtonEnabled: false,
                                    fortyFiveDegreeImageryEnabled: true,

                                    // Update location on camera move
                                    onCameraMove: (CameraPosition cameraPosition) async {},
                                    onMapCreated: (GoogleMapController gController) {
                                      // Complete the Google Map controller
                                      // controller.googleMapControllerCompleter = Completer();
                                      // controller.googleMapControllerCompleter.complete(gController);
                                      controller.googleMapController = gController;
                                      controller.update();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox()
                    : SizedBox(),
                // Expanded(
                //   child: controller.sosReportsList.isNotEmpty
                //       ? ListView.builder(
                //           shrinkWrap: true,
                //           itemCount: controller.sosReportsList.length,
                //           itemBuilder: (context, index) {
                //             ReportCaseModel report = controller.sosReportsList[index];
                //             return CustomCasesList(
                //               caseNo: "${report.id}",
                //               status: "${report.status == 0 ? 'Open' : 'Closed'}",
                //               firstName: "${report.firstName ?? '-'}",
                //               lastName: "${report.lastName ?? '-'}",
                //               date: "${Utils.displayDateFormat(
                //                 report.updatedAt ?? DateTime.now().toString(),
                //               )}",
                //               location: "${report.location ?? '-'}",
                //               city: "${report.city ?? '-'}",
                //             );
                //           },
                //         )
                //       : SizedBox(),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
