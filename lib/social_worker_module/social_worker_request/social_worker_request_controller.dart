import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SocialWorkerRequestController extends GetxController {
  int currentIndex = 0;
  bool canPop = false;
  DateTime? currentBackPressTime;

  @override
  void onReady() {
    getUserData();
    super.onReady();
  }

  List<SocialWorkerRequestModel> requestList = [];
  // List<SocialWorkerMessageModel> chatList = [];

  String? receiverName;
  List<SocialWorkerMessageModel> chatList = [
    // SocialWorkerMessageModel(userId: 0, message: "Hello", timestamp: DateTime.now().millisecondsSinceEpoch),
    // SocialWorkerMessageModel(userId: 1, message: "Hello, How can i help you?", timestamp: DateTime.now().millisecondsSinceEpoch),
    // SocialWorkerMessageModel(userId: 1, message: Constants.LoremIpsum, timestamp: DateTime.now().millisecondsSinceEpoch),
  ];

  TextEditingController messageController = TextEditingController();
  void getRequestList({bool? showLoader = true, required String search}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "search": search,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.socialWorkerRequestList,
        // formData,
        null,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      requestList.clear();

      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null && response['data'] is List) {
          List list = response['data'];
          if (list.isNotEmpty) {
            for (var report in list) {
              requestList.add(SocialWorkerRequestModel.fromJson(report));
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

  void updateRequestStatus({bool? showLoader = true, required int id, required String status}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "id": id,
        "status": status,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.acceptDeclineChatRequest,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }

      if (response['success'] != null && response['success'] == true) {
        Utils.showToast(response['message'] ?? 'Request status updated successfully.');
        if (status == 'Decline') {
          getRequestList(search: '', showLoader: false);
        } else if (status == 'Accept') {
          await Get.toNamed(Routes.SOCIAL_WORKER_CHAT);
          getRequestList(search: '', showLoader: false);
        }
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

  int? lastMessageId;
  void getChatList({
    bool? showLoader = true,
  }) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      print("LAST_ID------$lastMessageId");
      Dio.FormData formData = Dio.FormData.fromMap({
        "last_id": lastMessageId,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.getMessages,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (lastMessageId == null) {
        chatList.clear();
      }

      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null && response['data']['chats'] != null && response['data']['chats'] is List) {
          List list = response['data']['chats'];
          if (list.isNotEmpty) {
            for (var report in list) {
              chatList.add(SocialWorkerMessageModel.fromJson(report));
            }
          }
        }
        if (chatList.isNotEmpty) {
          lastMessageId = chatList.last.id;
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

  void sendMessage({
    bool? showLoader = true,
  }) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "message": messageController.text,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.sendMessage,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        messageController.clear();
        getChatList(showLoader: false);
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

  String? userId;
  Future<void> getUserData() async {
    userId = await StorageService().readSecureData(Constants.userId);
  }
}
