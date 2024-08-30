import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
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

  String? sessionStatus;
  int? lastMessageId;
  ScrollController scrollController = ScrollController();
  void getChatList({
    bool? showLoader = true,
    bool? showDialog,
    bool? animateScroll,
  }) async {
    if (isLoading == false) {
      isLoading = true;
      if (showLoader == true) {
        LoadingDialog.showLoader();
      }
      if (lastMessageId == null) {
        chatList.clear();
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
        isLoading = false;
        if (showLoader == true) {
          LoadingDialog.hideLoader();
        }

        if (response['success'] != null && response['success'] == true) {
          if (response['data'] != null) {
            sessionStatus = response['data']['status'];
          }
          if (response['data'] != null && response['data']['chats'] != null && response['data']['chats'] is List) {
            List list = response['data']['chats'];
            if (list.isNotEmpty) {
              for (var report in list) {
                chatList.add(SocialWorkerMessageModel.fromJson(report));
              }
            }
          } else {
            chatList.clear();
          }
          if (chatList.isNotEmpty) {
            lastMessageId = chatList.last.id;
          }
          if (animateScroll == true) {
            Future.delayed(Duration(milliseconds: 200)).then((value) {
              scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
              update();
            });
          }
          if (sessionStatus == 'Pending' && showDialog == true) {
            Utils.showCustomDialog(
              context: Get.context!,
              barrierDismissible: true,
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
                    child: Container(
                      width: SizeConfig.deviceWidth! * .85,
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16),
                        vertical: getProportionateScreenHeight(60),
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
                          Container(
                            height: getProportionateScreenHeight(141),
                            width: getProportionateScreenWidth(141),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.messageSent),
                              ),
                            ),
                          ),
                          Text(
                            "Message Sent!",
                            style: TextStyle(
                              fontFamily: AppFonts.sansFont600,
                              fontSize: getProportionalFontSize(20),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Text(
                            "Our social worker will respond to you shortly",
                            style: TextStyle(
                              fontFamily: AppFonts.sansFont400,
                              fontSize: getProportionalFontSize(16),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(28),
                          ),
                          CommonButton(
                            width: getProportionateScreenWidth(196),
                            text: AppLocalizations.of(Get.context!)!.done,
                            onPressed: () {
                              Get.back();
                            },
                            radius: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // onPop: () {
              //   if (addMessage == true) {
              //     controller.messageList.add(
              //       MessageModel(
              //           userId: 0,
              //           text: controller.messageController.text,
              //           timeStamp: DateTime.now().millisecondsSinceEpoch),
              //     );
              //
              //     controller.update();
              //     controller.messageController.clear();
              //   }
              // },
            );
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
    bool? showDialog,
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
        getChatList(showLoader: false, showDialog: showDialog, animateScroll: true);
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

class MessageModel {
  final int userId;
  final String text;
  final int timeStamp;

  MessageModel({required this.userId, required this.text, required this.timeStamp});
}
