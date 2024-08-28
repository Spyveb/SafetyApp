// To parse this JSON data, do
//
//     final socialWorkerHistoryModel = socialWorkerHistoryModelFromJson(jsonString);

import 'dart:convert';

SocialWorkerHistoryModel socialWorkerHistoryModelFromJson(String str) => SocialWorkerHistoryModel.fromJson(json.decode(str));

String socialWorkerHistoryModelToJson(SocialWorkerHistoryModel data) => json.encode(data.toJson());

class SocialWorkerHistoryModel {
  int? id;
  int? userId;
  int? socialWorkerId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobileCode;
  String? mobileNumber;
  String? profileImage;

  SocialWorkerHistoryModel({
    this.id,
    this.userId,
    this.socialWorkerId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.mobileCode,
    this.mobileNumber,
    this.profileImage,
  });

  factory SocialWorkerHistoryModel.fromJson(Map<String, dynamic> json) => SocialWorkerHistoryModel(
        id: json["id"],
        userId: json["user_id"],
        socialWorkerId: json["social_worker_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        mobileCode: json["mobile_code"],
        mobileNumber: json["mobile_number"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "social_worker_id": socialWorkerId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "mobile_code": mobileCode,
        "mobile_number": mobileNumber,
        "profile_image": profileImage,
      };
}
