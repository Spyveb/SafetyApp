import 'dart:convert';
import 'dart:io';

import 'package:distress_app/imports.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<void> notificationOperation({required Map<String, dynamic> message, bool? fromTerminate = false}) async {
    print(message);
    String? accessToken = await StorageService().readSecureData(Constants.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      if (message['notification_type'] == 'sos_create' || message['notification_type'] == 'sos_decline' || message['notification_type'] == 'sos_backup') {
        Get.lazyPut(() => PoliceSOSEmergencyController());

        if (fromTerminate == true) {
          // Get.find<SplashController>().notificationType = message['notification_type'];
          Get.find<SplashController>().notificationType = 'sos_create';
          fromMain = null;
        } else {
          if (fromTerminate != true && fromMain != true) {
            if (Get.currentRoute == Routes.POLICE_SOSEMERGENCY) {
              Get.offAndToNamed(Routes.POLICE_SOSEMERGENCY);
            } else {
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

                await Get.offAndToNamed(Routes.POLICE_REPORTEDNONEMGCASE_DETAILS);
                Get.find<ReportedNonEmgCasesController>().reportCaseModel = null;
              } else {
                Get.find<ReportedNonEmgCasesController>().goToDetails(currentSOSReport);
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
    } else {
      Get.offAllNamed(Routes.SPLASH);
    }
  }
}
