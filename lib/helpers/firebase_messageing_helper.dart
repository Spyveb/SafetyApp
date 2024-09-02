import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class FirebaseMessages extends Object {
  late Map<String, dynamic> pendingNotification;
  late FirebaseMessaging _firebaseMessaging;
  String _fcmToken = "";

  String get fcmToken => _fcmToken;

  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  factory FirebaseMessages() {
    return _singleton;
  }

  static final FirebaseMessages _singleton = FirebaseMessages._internal();

  FirebaseMessages._internal() {
    print("======== Firebase Messaging instance created ========");
    _firebaseMessaging = FirebaseMessaging.instance;

    firebaseCloudMessagingListeners();
    initializeLocalNotification();
  }

  Future<void> getFCMToken() async {
    try {
      if (_fcmToken.isEmpty) {
        String? token = await _firebaseMessaging.getToken();

        if (token != null && token.isNotEmpty) {
          print("========= FCM Token :: $token =======");
          _fcmToken = token;
        }
      }
    } catch (e) {
      print("Error :: ${e.toString()}");
      // return null;
    }
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) {
      iOSPermission();
    }
    FirebaseMessaging.onMessage.listen((event) {
      Future.delayed(const Duration(seconds: 1), () => displayNotificationView(payload: event.data, remoteNotification: event.notification!));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("data -- ${event.data}");
      FirebaseMessages.notificationOperation(message: event.data);
    });
  }

  void initializeLocalNotification() {
    _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    _notificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    getFCMToken();
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (
      int id,
      String? title,
      String? body,
      String? payload,
    ) async {});

    final InitializationSettings initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: initializationSettingsIOS,
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        notificationOperation(message: jsonDecode(response.payload!));
      },
    );
  }

  Future<void> iOSPermission() async {
    await _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
    getFCMToken();
  }

  static Future<void> displayNotificationView({required Map<String, dynamic> payload, required RemoteNotification remoteNotification}) async {
    String title = remoteNotification.title!;
    String body = remoteNotification.body!;

    print("title -- ${title}");
    print("body -- ${body}");

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "com.app.distress_app.notification",
            "com.app.distress_app.notification.channel",
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails());

      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: jsonEncode(payload),
      );
      showRequestDialog(payload);
    } on Exception catch (e) {
      print(e);
    }
  }

  static bool sosOpen = false;
  static bool nonOpen = false;
  static void showRequestDialog(Map<String, dynamic> payload) {
    if (payload['notification_type'] == 'sos_create' || payload['notification_type'] == 'sos_decline' || payload['notification_type'] == 'sos_backup') {
      if (payload['data'] != null) {
        Map<String, dynamic> caseJson = jsonDecode(payload['data'].toString());
        ReportCaseModel currentSOSReport = ReportCaseModel.fromJson(caseJson);
        // if ((currentSOSReport.status == 'Pending' || currentSOSReport.status == 'All') && currentSOSReport.requestStatus == 'Pending') {
        showSOSDialog(Get.context!, currentSOSReport);
        // }
      }
    } else if (payload['notification_type'] == 'non_create' || payload['notification_type'] == 'non_decline') {
      if (payload['data'] != null) {
        Map<String, dynamic> caseJson = jsonDecode(payload['data'].toString());
        ReportCaseModel currentSOSReport = ReportCaseModel.fromJson(caseJson);
        // if ((currentSOSReport.status == 'Pending' || currentSOSReport.status == 'All') && currentSOSReport.requestStatus == 'Pending') {
        showReportRequestDialog(Get.context!, currentSOSReport);
        // }
      }
    }
  }

  static void showSOSDialog(BuildContext context, ReportCaseModel reportCaseModel) {
    sosOpen = true;
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
                          AppLocalizations.of(context)!.liveEmergency,
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
                        AppLocalizations.of(context)!.distance,
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
                                    caseId: reportCaseModel.id!,
                                    status: AppLocalizations.of(context)!.accept,
                                    assignSOSEmergencyCaseId: reportCaseModel.assign_sos_emergency_case_id);
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
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    AppLocalizations.of(context)!.accept,
                                    textAlign: TextAlign.center,
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
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(30),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (reportCaseModel.id != null) {
                                updateSOSEmergencyRequest(
                                    caseId: reportCaseModel.id!,
                                    status: AppLocalizations.of(context)!.decline,
                                    assignSOSEmergencyCaseId: reportCaseModel.assign_sos_emergency_case_id);
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
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    AppLocalizations.of(context)!.decline,
                                    textAlign: TextAlign.center,
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
    ).then((value) {
      sosOpen = false;
    });
  }

  static void updateSOSEmergencyRequest({bool? showLoader = true, required int caseId, required String status, int? assignSOSEmergencyCaseId}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "request_status": status,
      });
      if (assignSOSEmergencyCaseId != null) {
        formData.fields.add(MapEntry('assign_sos_emergency_case_id', assignSOSEmergencyCaseId.toString()));
      } else {
        formData.fields.add(MapEntry('sos_emergency_case_id', caseId.toString()));
      }

      print(formData.toString());
      var response = await ApiProvider().postAPICall(
        Endpoints.updateSOSEmergencyCaseStatus,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        Get.back();
        Utils.showToast(response['message'] ?? 'Report request status updated successfully.');
        if (status == 'Accept') {
          if (Get.currentRoute == Routes.POLICE_SOSEMERGENCY) {
            Get.offAndToNamed(Routes.POLICE_SOSEMERGENCY);
          } else {
            Get.toNamed(Routes.POLICE_SOSEMERGENCY);
          }
        }
      } else {
        Get.back();
        Utils.showToast(response['message'] ?? 'Failed to update request status');
      }
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      Get.back();
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      Get.back();
      debugPrint(e.toString());
    }
  }

  static void updateNonEmergencyRequest({bool? showLoader = true, required int caseId, required String status, int? assignNonEmergencyCaseId}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "request_status": status,
      });

      if (assignNonEmergencyCaseId != null) {
        formData.fields.add(MapEntry('assign_non_emergency_case_id', assignNonEmergencyCaseId.toString()));
      } else {
        formData.fields.add(MapEntry('non_emergency_case_id', caseId.toString()));
      }

      var response = await ApiProvider().postAPICall(
        Endpoints.updateNonEmergencyCaseStatus,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        Utils.showToast(response['message'] ?? 'Report request status updated successfully.');
        if (status == 'Decline') {
          Get.back();
        } else {
          Get.back();
          if (response['data'] != null) {
            ReportCaseModel reportCaseModel = ReportCaseModel.fromJson(response['data']);

            if (Get.currentRoute == Routes.POLICE_REPORTEDNONEMGCASE_DETAILS) {
              Get.find<ReportedNonEmgCasesController>().goToDetails(reportCaseModel);

              await Get.offAndToNamed(Routes.POLICE_REPORTEDNONEMGCASE_DETAILS);
              Get.find<ReportedNonEmgCasesController>().reportCaseModel = null;
            } else {
              Get.find<ReportedNonEmgCasesController>().goToDetails(reportCaseModel);
              await Get.toNamed(Routes.POLICE_REPORTEDNONEMGCASE_DETAILS);
              Get.find<ReportedNonEmgCasesController>().reportCaseModel = null;
            }
          } else {
            Utils.showToast(response['message'] ?? 'Report request status updated successfully.');
            Get.back();
          }
        }
      } else {
        Utils.showToast(response['message'] ?? 'Failed to update request status');
      }
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      Get.back();
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      Get.back();
      debugPrint(e.toString());
    }
  }

  static void showReportRequestDialog(BuildContext context, ReportCaseModel reportCaseModel) {
    nonOpen = true;
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
                horizontal: getProportionateScreenWidth(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.reportedRequest,
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
                        AppLocalizations.of(context)!.emergencyEvent,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!.nonEmergency,
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
                        AppLocalizations.of(context)!.distance,
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
                                updateNonEmergencyRequest(
                                    caseId: reportCaseModel.id!,
                                    status: AppLocalizations.of(context)!.accept,
                                    assignNonEmergencyCaseId: reportCaseModel.assign_non_emergency_case_id);
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
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    AppLocalizations.of(context)!.accept,
                                    textAlign: TextAlign.center,
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
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(30),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (reportCaseModel.id != null) {
                                updateNonEmergencyRequest(
                                    caseId: reportCaseModel.id!,
                                    status: AppLocalizations.of(context)!.decline,
                                    assignNonEmergencyCaseId: reportCaseModel.assign_non_emergency_case_id);
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
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    AppLocalizations.of(context)!.decline,
                                    textAlign: TextAlign.center,
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
    ).then((value) {
      nonOpen = false;
    });
    // ).then((value) {
    //   Get.back();
    // });
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
  }

  static Future<void> notificationOperation({required Map<String, dynamic> message, bool? fromTerminate = false}) async {
    print(message);
    String? accessToken = await StorageService().readSecureData(Constants.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      if (message['notification_type'] == 'sos_create' ||
              message['notification_type'] == 'sos_decline' ||
              message['notification_type'] == 'sos_backup' ||
              message['notification_type'] == 'sos_backup_accept'
          // ||  message['notification_type'] == 'sos_backup_decline'
          ) {
        Get.lazyPut(() => PoliceSOSEmergencyController());

        if (fromTerminate == true) {
          // Get.find<SplashController>().notificationType = message['notification_type'];
          Get.find<SplashController>().notificationType = 'sos_create';
          fromMain = null;
        } else {
          if (fromTerminate != true && fromMain != true) {
            if (Get.currentRoute == Routes.POLICE_SOSEMERGENCY) {
              // if(sosOpen==true){
              //   Get.back();
              // }
              Get.offAndToNamed(Routes.POLICE_SOSEMERGENCY);
            } else {
              if (sosOpen == true) {
                Get.back();
              }
              Get.toNamed(Routes.POLICE_SOSEMERGENCY);
            }
          }
        }
        // if (message['data'] != null) {
        //   Map<String, dynamic> caseJson = jsonDecode(message['data'].toString());
        //   ReportCaseModel currentSOSReport = ReportCaseModel.fromJson(caseJson);
        //   // if (
        //   //     (currentSOSReport.status == 'Pending' || currentSOSReport.status == 'All') &&
        //   //     currentSOSReport.requestStatus == 'Pending') {
        //   Get.find<PoliceSOSEmergencyController>().showSOSDialog(Get.context!, currentSOSReport);
        //   // }
        // }
      } else if (message['notification_type'] == 'non_create' || message['notification_type'] == 'non_decline') {
        if (message['data'] != null) {
          Get.lazyPut(() => ReportedNonEmgCasesController());
          Map<String, dynamic> caseJson = jsonDecode(message['data'].toString());
          ReportCaseModel currentSOSReport = ReportCaseModel.fromJson(caseJson);

          if (fromTerminate == true) {
            Get.find<SplashController>().notificationType = 'non_create';
            Get.find<SplashController>().goToDetails(currentSOSReport);
            fromMain = null;
          } else {
            if (fromTerminate != true && fromMain != true) {
              if (Get.currentRoute == Routes.POLICE_REPORTEDNONEMGCASE_DETAILS) {
                Get.find<ReportedNonEmgCasesController>().goToDetails(currentSOSReport);
                // if(nonOpen==true){
                //   Get.back();
                // }
                await Get.offAndToNamed(Routes.POLICE_REPORTEDNONEMGCASE_DETAILS);
                Get.find<ReportedNonEmgCasesController>().reportCaseModel = null;
              } else {
                Get.find<ReportedNonEmgCasesController>().goToDetails(currentSOSReport);
                if (nonOpen == true) {
                  Get.back();
                }
                await Get.toNamed(Routes.POLICE_REPORTEDNONEMGCASE_DETAILS);
                Get.find<ReportedNonEmgCasesController>().reportCaseModel = null;
              }
            }
          }
        }
      } else if (message['notification_type'] == 'sos_accept' || message['notification_type'] == 'sos_close') {
        if (fromTerminate == true) {
          Get.find<SplashController>().notificationType = 'sos_accept';
          fromMain = null;
        } else {
          if (fromTerminate != true && fromMain != true) {
            Get.lazyPut(() => HomeController());

            if (Get.currentRoute == Routes.USERSOSREQUESTDETAIL) {
              Get.offAndToNamed(Routes.USERSOSREQUESTDETAIL);
            } else {
              Get.toNamed(Routes.USERSOSREQUESTDETAIL);
            }
          }
        }
      } else if (message['notification_type'] == 'non_accept' || message['notification_type'] == 'non_close') {
        if (fromTerminate == true) {
          Get.find<SplashController>().notificationType = 'non_accept';
          fromMain = null;
        } else {
          if (fromTerminate != true && fromMain != true) {
            Get.offAndToNamed(Get.currentRoute);
          }
        }
      } else if (message['notification_type'] == 'send_message_social_user' ||
          message['notification_type'] == 'end_session_social_user' ||
          message['notification_type'] == 'accept_chat_request') {
        if (fromTerminate == true) {
          Get.find<SplashController>().notificationType = 'send_message_social_user';
          fromMain = null;
        } else {
          if (fromTerminate != true && fromMain != true) {
            if (Get.currentRoute == Routes.DASHBOARD) {
              Get.find<DashBoardController>().currentIndex = 3;
              Get.find<DashBoardController>().update();
            } else {
              Get.offAllNamed(Routes.DASHBOARD);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Get.find<DashBoardController>().currentIndex = 3;
                Get.find<DashBoardController>().update();
              });
            }
          }
        }
      } else if (message['notification_type'] == 'chat_request') {
        if (fromTerminate == true) {
          Get.find<SplashController>().notificationType = 'chat_request';
          fromMain = null;
        } else {
          if (fromTerminate != true && fromMain != true) {
            if (Get.currentRoute == Routes.SOCIAL_WORKER_DASHBOARD) {
              Get.find<SocialWorkerDashBoardController>().currentIndex = 0;
              Get.find<SocialWorkerDashBoardController>().update();
              Get.find<SocialWorkerRequestController>().getRequestList(search: '', showLoader: false);
            } else {
              Get.offAllNamed(Routes.SOCIAL_WORKER_DASHBOARD);
            }
          }
        }
      } else if (message['notification_type'] == 'send_message_user') {
        if (fromTerminate == true) {
          if (message['session_id'] != null && int.tryParse(message['session_id'].toString()) != null) {
            Get.find<SplashController>().socialWorkerChatSessionId = int.tryParse(message['session_id'].toString());
            Get.find<SocialWorkerRequestController>().receiverName = message['sender_name'] ?? '-';
          }
          Get.find<SplashController>().notificationType = 'send_message_user';

          fromMain = null;
        } else {
          if (fromTerminate != true && fromMain != true) {
            if (Get.currentRoute == Routes.SOCIAL_WORKER_CHAT) {
              if (message['session_id'] != null && int.tryParse(message['session_id'].toString()) != null) {
                if (Get.find<SocialWorkerRequestController>().sessionId == int.tryParse(message['session_id'].toString())) {
                  Get.find<SocialWorkerRequestController>().getChatList(animateScroll: true, showLoader: false);
                } else {
                  Get.find<SocialWorkerRequestController>().sessionId = int.tryParse(message['session_id'].toString());
                  Get.find<SocialWorkerRequestController>().receiverName = message['sender_name'] ?? '-';
                  Get.offAndToNamed(Routes.SOCIAL_WORKER_CHAT);
                }
              }
            } else {
              if (message['session_id'] != null && int.tryParse(message['session_id'].toString()) != null) {
                Get.find<SocialWorkerRequestController>().sessionId = int.tryParse(message['session_id'].toString());
                Get.find<SocialWorkerRequestController>().receiverName = message['sender_name'] ?? '-';
                Get.toNamed(Routes.SOCIAL_WORKER_CHAT);
              }
            }
          }
        }
      } else {
        Get.offAllNamed(Routes.SPLASH);
      }
    }
  }
}
