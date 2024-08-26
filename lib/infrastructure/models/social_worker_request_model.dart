// To parse this JSON data, do
//
//     final socialWorkerRequestModel = socialWorkerRequestModelFromJson(jsonString);

import 'dart:convert';

SocialWorkerRequestModel socialWorkerRequestModelFromJson(String str) => SocialWorkerRequestModel.fromJson(json.decode(str));

String socialWorkerRequestModelToJson(SocialWorkerRequestModel data) => json.encode(data.toJson());

class SocialWorkerRequestModel {
  int? id;
  int? userId;
  dynamic socialWorkerId;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  SocialWorkerRequestModel({
    this.id,
    this.userId,
    this.socialWorkerId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory SocialWorkerRequestModel.fromJson(Map<String, dynamic> json) => SocialWorkerRequestModel(
        id: json["id"],
        userId: json["user_id"],
        socialWorkerId: json["social_worker_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "social_worker_id": socialWorkerId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobileCode;
  String? mobileNumber;
  String? profileImage;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.mobileCode,
    this.mobileNumber,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
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
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "mobile_code": mobileCode,
        "mobile_number": mobileNumber,
        "profile_image": profileImage,
      };
}
