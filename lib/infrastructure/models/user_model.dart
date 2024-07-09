// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobileCode;
  String? mobileNumber;
  String? dob;
  String? role;
  dynamic jobId;
  dynamic organisationId;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? token;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.mobileCode,
    this.mobileNumber,
    this.dob,
    this.role,
    this.jobId,
    this.organisationId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        mobileCode: json["mobile_code"],
        mobileNumber: json["mobile_number"],
        dob: json["dob"],
        role: json["role"],
        jobId: json["job_id"],
        organisationId: json["organisation_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "mobile_code": mobileCode,
        "mobile_number": mobileNumber,
        "dob": dob,
        "role": role,
        "job_id": jobId,
        "organisation_id": organisationId,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "token": token,
      };
}
