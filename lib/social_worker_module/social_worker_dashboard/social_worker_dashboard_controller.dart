import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SocialWorkerDashBoardController extends GetxController {
  int currentIndex = 0;
  bool canPop = false;
  DateTime? currentBackPressTime;

  @override
  void onInit() {
    saveFCMToken();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void saveFCMToken() async {
    String? accessToken = await StorageService().readSecureData(Constants.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      // LoadingDialog.showLoader();
      try {
        Dio.FormData formData = Dio.FormData.fromMap({
          "fcm_token": FirebaseMessages().fcmToken,
        });
        var response = await ApiProvider().postAPICall(
          Endpoints.saveFCMToken,
          formData,
          onSendProgress: (count, total) {},
        );
        // LoadingDialog.hideLoader();
      } on Dio.DioException catch (e) {
        debugPrint(e.toString());
        // LoadingDialog.hideLoader();
      } catch (e) {
        debugPrint(e.toString());
        // LoadingDialog.hideLoader();
      }
    }
  }
}
