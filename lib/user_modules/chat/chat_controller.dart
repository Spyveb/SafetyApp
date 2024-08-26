import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  List<MessageModel> messageList = [
    MessageModel(userId: 0, text: "Hello", timeStamp: DateTime.now().millisecondsSinceEpoch),
    MessageModel(userId: 1, text: "Hello, How can i help you?", timeStamp: DateTime.now().millisecondsSinceEpoch),
    MessageModel(userId: 1, text: Constants.LoremIpsum, timeStamp: DateTime.now().millisecondsSinceEpoch),
  ];

  TextEditingController messageController = TextEditingController();
  @override
  void onReady() {

    super.onReady();
  }
  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  List<SocialWorkerMessageModel> chatList = [
    // SocialWorkerMessageModel(userId: 0, message: "Hello", timestamp: DateTime.now().millisecondsSinceEpoch),
    // SocialWorkerMessageModel(userId: 1, message: "Hello, How can i help you?", timestamp: DateTime.now().millisecondsSinceEpoch),
    // SocialWorkerMessageModel(userId: 1, message: Constants.LoremIpsum, timestamp: DateTime.now().millisecondsSinceEpoch),
  ];

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

class MessageModel {
  final int userId;
  final String text;
  final int timeStamp;

  MessageModel({required this.userId, required this.text, required this.timeStamp});
}
