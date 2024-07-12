// To parse this JSON data, do
//
//     final emerygencyContactModel = emerygencyContactModelFromJson(jsonString);

import 'dart:convert';

EmergencyContactModel emergencyContactModelFromJson(String str) => EmergencyContactModel.fromJson(json.decode(str));

String emergencyContactModelToJson(EmergencyContactModel data) => json.encode(data.toJson());

class EmergencyContactModel {
  int? id;
  int? userId;
  String? name;
  String? mobileNumber;
  String? createdAt;
  String? updatedAt;

  EmergencyContactModel({
    this.id,
    this.userId,
    this.name,
    this.mobileNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) => EmergencyContactModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        mobileNumber: json["mobile_number"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "mobile_number": mobileNumber,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
