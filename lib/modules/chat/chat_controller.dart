import 'package:distress_app/utils/constants.dart';
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
}

class MessageModel {
  final int userId;
  final String text;
  final int timeStamp;

  MessageModel({required this.userId, required this.text, required this.timeStamp});
}
