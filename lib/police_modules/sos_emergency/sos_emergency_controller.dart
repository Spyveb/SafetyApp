import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoliceSOSEmergencyController extends GetxController {
  Completer<GoogleMapController> googleMapControllerCompleter = Completer();
  GoogleMapController? googleMapController;
  List<ReportCaseModel> sosReportsList = [];
  ReportCaseModel? currentSOSReport;

  TextEditingController endSOSNotesController = TextEditingController();

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
      currentSOSReport = null;
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null && response['data'] is List) {
          List list = response['data'];
          if (list.isNotEmpty) {
            for (var report in list) {
              sosReportsList.add(ReportCaseModel.fromJson(report));
            }

            if (sosReportsList.length > 1) {
              currentSOSReport = sosReportsList.firstWhereOrNull((element) => element.status == 'Open' && element.requestStatus == 'Accept');
              currentSOSReport ??= sosReportsList.first;
            } else {
              currentSOSReport = sosReportsList.first;
            }
          }
        }
      } else {}

      if (currentSOSReport != null &&
          (currentSOSReport!.status == 'Pending' || currentSOSReport!.status == 'All') &&
          currentSOSReport!.requestStatus == 'Pending') {
        showSOSDialog(Get.context!, currentSOSReport!);
      }

      update();

      Future.delayed(Duration(seconds: 1)).then((value) {
        if (currentSOSReport != null && currentSOSReport!.status == 'Open' && currentSOSReport!.requestStatus == 'Accept') {
          if ((currentSOSReport!.latitude != null && currentSOSReport!.longitude != null) &&
              (currentSOSReport!.policeOfficerLatitude != null && currentSOSReport!.policeOfficerLongitude != null))
            addMarkers(
              LatLng(double.parse(currentSOSReport!.latitude!), double.parse(currentSOSReport!.longitude!)),
              LatLng(
                double.parse(currentSOSReport!.policeOfficerLatitude!),
                double.parse(currentSOSReport!.policeOfficerLongitude!),
              ),
            );
          update();
        }
      });
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

  void updateSOSEmergencyRequest({bool? showLoader = true, required int caseId, required String status, int? assignSOSEmergencyCaseId}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        // "assign_sos_emergency_case_id": caseId,
        "request_status": status,
      });
      if (assignSOSEmergencyCaseId != null) {
        formData.fields.add(MapEntry('assign_sos_emergency_case_id', assignSOSEmergencyCaseId.toString()));
      } else {
        formData.fields.add(MapEntry('sos_emergency_case_id', caseId.toString()));
      }

      var response = await ApiProvider().postAPICall(
        Endpoints.updateSOSEmergencyCaseStatus,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        Utils.showToast(response['message'] ?? 'Report request status updated successfully.');
      } else {
        Utils.showToast(response['message'] ?? 'Failed to update request status');
      }

      Get.back();
      update();
      getSOSEmergencyList(search: '');
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      Get.back();
      update();
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      update();
      Get.back();
      debugPrint(e.toString());
    }
  }

  void closeSOSEmergencyRequest({
    bool? showLoader = true,
    required int caseId,
  }) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "id": caseId,
        "note": endSOSNotesController.text,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.closeSOSEmergencyCaseStatus,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        endSOSNotesController.clear();
        Utils.showToast(response['message'] ?? 'SOS closed');
        Get.back();
        Get.back();
      } else {
        Utils.showToast(response['message'] ?? 'Failed to end SOS');
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
      // barrierDismissible: false,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       AppLocalizations.of(context)!.mobileNumber,
                  //       style: TextStyle(
                  //         fontFamily: AppFonts.sansFont600,
                  //         fontSize: getProportionalFontSize(16),
                  //       ),
                  //     ),
                  //     Flexible(
                  //       child: Text(
                  //         "${reportCaseModel.city ?? '-'}",
                  //         style: TextStyle(
                  //           fontFamily: AppFonts.sansFont400,
                  //           fontSize: getProportionalFontSize(16),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: getProportionateScreenHeight(10),
                  // ),
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
                        // AppLocalizations.of(context)!.estimatedTimeOfArrival,
                        "Distance: ",
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${calculateDistance(double.parse(reportCaseModel.policeOfficerLatitude!), double.parse(reportCaseModel.policeOfficerLongitude!), double.parse(reportCaseModel.latitude!), double.parse(reportCaseModel.longitude!))}",
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
                              if (reportCaseModel.id != null) {
                                updateSOSEmergencyRequest(
                                    caseId: reportCaseModel.id!, status: 'Accept', assignSOSEmergencyCaseId: reportCaseModel.assign_sos_emergency_case_id);
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
                              if (reportCaseModel.id != null) {
                                updateSOSEmergencyRequest(
                                    caseId: reportCaseModel.id!, status: 'Decline', assignSOSEmergencyCaseId: reportCaseModel.assign_sos_emergency_case_id);
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

  showEndSosDialog(BuildContext context, {required int caseId}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: GetBuilder<PoliceSOSEmergencyController>(
            id: 'end_sos_dialog',
            builder: (controller) {
              return Container(
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
                        AppLocalizations.of(context)!.whatHappenedThisEvent,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      TextFormField(
                        controller: endSOSNotesController,
                        maxLines: null,
                        maxLength: 300,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onChanged: (value) {
                          endSOSNotesController.text = value;
                          update(['end_sos_dialog']);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(8),
                            vertical: getProportionateScreenHeight(8),
                          ),
                          constraints: BoxConstraints(
                            maxHeight: getProportionateScreenHeight(100),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25),
                      ),
                      SizedBox(
                        width: SizeConfig.deviceWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redDefault,
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(16),
                              vertical: getProportionateScreenHeight(12),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(30),
                              ),
                            ),
                          ),
                          onPressed: endSOSNotesController.text.isNotEmpty
                              ? () {
                                  closeSOSEmergencyRequest(caseId: caseId);
                                }
                              : null,
                          child: Text(
                            AppLocalizations.of(context)!.submit,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionalFontSize(18),
                              fontFamily: AppFonts.sansFont600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void backupSOSEmergencyRequest({
    bool? showLoader = true,
    required int caseId,
  }) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "id": caseId,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.backupSOSEmergencyCaseStatus,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        currentSOSReport!.backupRequestStatus = 1;
        showBackupRequestDialog(Get.context!);
      } else {
        Utils.showToast(response['message'] ?? 'Failed to send backup request, Please try again later.');
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

  showBackupRequestDialog(BuildContext context) {
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
                    AppLocalizations.of(context)!.backupRequestSent,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont600,
                      fontSize: getProportionalFontSize(24),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    AppLocalizations.of(context)!.aBackupSentYourDestination,
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

  List<Marker> markers = [];

  addMarkers(LatLng userLatLong, LatLng policeLatLong) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MarkerId userMarkerId = MarkerId("userMarkerId");
      final marker = Marker(
        markerId: userMarkerId, icon: BitmapDescriptor.defaultMarker, position: userLatLong,
        // onTap: () {}
      );
      markers.add(marker);
      MarkerId policeMarkerId = MarkerId("policeMarkerId");
      final marker2 = Marker(
        markerId: policeMarkerId,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: policeLatLong,
        // onTap: () {}
      );
      markers.add(marker2);

      if (policeLatLong.latitude <= userLatLong.latitude) {
        LatLngBounds bound = LatLngBounds(
          southwest: policeLatLong,
          northeast: userLatLong,
        );
        CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 90);
        googleMapController!.animateCamera(u2).then((void v) {
          check(u2, googleMapController!);
        });
      } else {
        googleMapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: userLatLong,
              zoom: 14,
              // bearing: currentPositionData.heading
            ),
          ),
        );
      }
      update();
    });
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    googleMapController!.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) check(u, c);
  }

  // double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  //   var p = 0.017453292519943295;
  //   var a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Future<void> addPolyLineForMerchantRoute() async {
  //   final String polylineIdVal = 'polyline_id_69';
  //   // polylineIdCounter++;
  //   final PolylineId polylineId = PolylineId(polylineIdVal);
  //
  //   var polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     "AIzaSyAyrWhY3ALKo6NORh9f_gcwGGdWPT3Phdk",
  //
  //     PointLatLng(driverLatLong.latitude, driverLatLong.longitude),
  //     // PointLatLng(22.9642, 72.5903),
  //     PointLatLng(merchantLatLong.latitude, merchantLatLong.longitude),
  //     // PointLatLng(23.0686, 72.6536),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (mapPolylines.containsKey(polylineId)) {}
  //   List<LatLng> polylineCoordinates = [];
  //
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   }
  //
  //   final Polyline polyline = Polyline(
  //     polylineId: polylineId,
  //     consumeTapEvents: true,
  //     color: Colors.black,
  //     geodesic: true,
  //     endCap: Cap.squareCap,
  //     jointType: JointType.bevel,
  //     width: 4,
  //     points: polylineCoordinates,
  //   );
  //
  //   mapPolylines[polylineId] = polyline;
  //
  //   addMarkerForMerchantRoute();
  // }
}
