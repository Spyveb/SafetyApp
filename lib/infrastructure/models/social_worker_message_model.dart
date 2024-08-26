// To parse this JSON data, do
//
//     final socialWorkerMessageModel = socialWorkerMessageModelFromJson(jsonString);

import 'dart:convert';

SocialWorkerMessageModel socialWorkerMessageModelFromJson(String str) => SocialWorkerMessageModel.fromJson(json.decode(str));

String socialWorkerMessageModelToJson(SocialWorkerMessageModel data) => json.encode(data.toJson());

class SocialWorkerMessageModel {
  int? id;
  int? chatSessionId;
  int? userId;
  dynamic socialWorkerId;
  String? message;
  String? createdAt;
  String? updatedAt;
  int? timestamp;

  SocialWorkerMessageModel({
    this.id,
    this.chatSessionId,
    this.userId,
    this.socialWorkerId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.timestamp,
  });

  factory SocialWorkerMessageModel.fromJson(Map<String, dynamic> json) => SocialWorkerMessageModel(
        id: json["id"],
        chatSessionId: json["chat_session_id"],
        userId: json["user_id"],
        socialWorkerId: json["social_worker_id"],
        message: json["message"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chat_session_id": chatSessionId,
        "user_id": userId,
        "social_worker_id": socialWorkerId,
        "message": message,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "timestamp": timestamp,
      };
}
