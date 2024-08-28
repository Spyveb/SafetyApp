import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SocialWorkerHistoryController extends GetxController {
  @override
  void onReady() {
    Get.find<SocialWorkerRequestController>().getUserData();
    super.onReady();
  }

  List<SocialWorkerHistoryModel> historyList = [];
  // List<SocialWorkerMessageModel> chatList = [];

  String? receiverName;
  List<SocialWorkerMessageModel> chatList = [
    // SocialWorkerMessageModel(userId: 0, message: "Hello", timestamp: DateTime.now().millisecondsSinceEpoch),
    // SocialWorkerMessageModel(userId: 1, message: "Hello, How can i help you?", timestamp: DateTime.now().millisecondsSinceEpoch),
    // SocialWorkerMessageModel(userId: 1, message: Constants.LoremIpsum, timestamp: DateTime.now().millisecondsSinceEpoch),
  ];

  Future<void> getHistory({bool? showLoader = true, required String search}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "search": search,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.sessionHistory,
        // formData,
        null,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      historyList.clear();

      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null && response['data'] is List) {
          List list = response['data'];
          if (list.isNotEmpty) {
            for (var report in list) {
              historyList.add(SocialWorkerHistoryModel.fromJson(report));
            }
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
}
