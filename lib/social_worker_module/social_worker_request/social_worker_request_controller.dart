import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  bool? fromHistory;
  List<SocialWorkerRequestModel> requestList = [];
  // List<SocialWorkerMessageModel> chatList = [];

  String? receiverName;
  List<SocialWorkerMessageModel> chatList = [
    // SocialWorkerMessageModel(userId: 0, message: "Hello", timestamp: DateTime.now().millisecondsSinceEpoch),
    // SocialWorkerMessageModel(userId: 1, message: "Hello, How can i help you?", timestamp: DateTime.now().millisecondsSinceEpoch),
    // SocialWorkerMessageModel(userId: 1, message: Constants.LoremIpsum, timestamp: DateTime.now().millisecondsSinceEpoch),
  ];

  TextEditingController messageController = TextEditingController();
  Future<void> getRequestList({bool? showLoader = true, required String search}) async {
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

  void updateRequestStatus({bool? showLoader = true, required int id, required String status, String? userName}) async {
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
          receiverName = userName;
          sessionId = id;
          await Get.toNamed(Routes.SOCIAL_WORKER_CHAT);
          receiverName = null;
          sessionId = null;
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

  ScrollController scrollController = ScrollController();
  int? lastMessageId;
  int? sessionId;
  void getChatList({
    bool? showLoader = true,
    bool? animateScroll,
  }) async {
    if (isLoading == false) {
      isLoading = true;
      if (showLoader == true) {
        LoadingDialog.showLoader();
      }
      if (lastMessageId == null) {
        chatList.clear();
        update();
      }

      try {
        print("LAST_ID------$lastMessageId");
        Dio.FormData formData = Dio.FormData.fromMap({
          "last_id": lastMessageId,
          "id": sessionId,
        });
        var response = await ApiProvider().postAPICall(
          Endpoints.getMessages,
          formData,
          onSendProgress: (count, total) {},
        );
        isLoading = false;
        if (showLoader == true) {
          LoadingDialog.hideLoader();
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
          if (animateScroll == true) {
            Future.delayed(Duration(milliseconds: 500)).then((value) {
              scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
              update();
            });
          }
        } else {}

        update();
      } on Dio.DioException catch (e) {
        isLoading = false;
        if (showLoader == true) {
          LoadingDialog.hideLoader();
        }
        Utils.showToast(e.message ?? "Something went wrong");
        update();
        debugPrint(e.toString());
      } catch (e) {
        isLoading = false;
        if (showLoader == true) {
          LoadingDialog.hideLoader();
        }
        Utils.showToast("Something went wrong");
        update();
        debugPrint(e.toString());
      }
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
        "id": sessionId,
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
        getChatList(showLoader: false, animateScroll: true);
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

  void endSession({
    bool? showLoader = true,
    required int id,
  }) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "id": id,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.endSession,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }

      if (response['success'] != null && response['success'] == true) {
        Utils.showToast(response['message'] ?? 'Session closed successfully.');

        await getRequestList(search: '', showLoader: false);
        Get.back();
      } else {
        Utils.showToast(response['message'] ?? 'Failed to close session');
      }
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      debugPrint(e.toString());
    }
  }

  Timer? timer;
  bool isLoading = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 7), (Timer t) {
      getChatList(showLoader: false);
    });
  }

  void closeTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }
}
