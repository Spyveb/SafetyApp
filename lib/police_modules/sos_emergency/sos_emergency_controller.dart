import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoliceSOSEmergencyController extends GetxController {
  Completer<GoogleMapController> googleMapControllerCompleter = Completer();
  List<ReportCaseModel> sosReportsList = [];
  ReportCaseModel? currentSOSReport;
  void getSOSEmergencyList({bool? showLoader = true, required String search}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "search": search,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.openSOSEmergencyList,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      sosReportsList.clear();
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null && response['data'] is List) {
          List list = response['data'];
          for (var report in list) {
            sosReportsList.add(ReportCaseModel.fromJson(report));
          }
        }
      } else {}
      update();
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      update();
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      update();
      debugPrint(e.toString());
    }
  }

  void updateSOSEmergencyRequest({bool? showLoader = true, required int caseId, required String status}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "assign_sos_emergency_case_id": caseId,
        "request_status": status,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.openSOSEmergencyList,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
      } else {
        Utils.showToast(response['message'] ?? 'Failed to update request status');
      }
      update();
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      update();
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      update();
      debugPrint(e.toString());
    }
  }

  showSOSDialog(BuildContext context, ReportCaseModel reportCaseModel) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.policeDarkBlueColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sosRequest,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont600,
                      fontSize: getProportionalFontSize(30),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.requester,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${reportCaseModel.firstName ?? '-'} ${reportCaseModel.lastName ?? '-'}",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.location,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          reportCaseModel.location ?? '-',
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.mobileNumber,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${reportCaseModel.city ?? '-'}",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.emergencyEvent,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Live emergency",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                            color: AppColors.redDefault,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.estimatedTimeOfArrival,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          ///Calculate distance
                          "3 minutes",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              // showRequestDeclineDialog(context);
                              if (reportCaseModel.id != null) {
                                updateSOSEmergencyRequest(caseId: reportCaseModel.id!, status: 'Accept');
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.policeDarkBlueColor,
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(30),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(30),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.accept,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getProportionalFontSize(18),
                                    fontFamily: AppFonts.sansFont600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(30),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              // showRequestDeclineDialog(context);
                              if (reportCaseModel.id != null) {
                                updateSOSEmergencyRequest(caseId: reportCaseModel.id!, status: 'Decline');
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.redDefault,
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(30),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(30),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.decline,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getProportionalFontSize(18),
                                    fontFamily: AppFonts.sansFont600,
                                  ),
                                ),
                              ),
                            ),
                          ),
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

  showRequestDeclineDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.policeDarkBlueColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sosRequest,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont600,
                      fontSize: getProportionalFontSize(24),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    AppLocalizations.of(context)!.youHaveDeclinedSosRequest,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont500,
                      fontSize: getProportionalFontSize(16),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.policeDarkBlueColor,
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(30),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30),
                        vertical: getProportionateScreenHeight(15),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.ok,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionalFontSize(18),
                            fontFamily: AppFonts.sansFont600,
                          ),
                        ),
                      ),
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
}
