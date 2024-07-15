// To parse this JSON data, do
//
//     final reportCaseModel = reportCaseModelFromJson(jsonString);

import 'dart:convert';

ReportCaseModel reportCaseModelFromJson(String str) => ReportCaseModel.fromJson(json.decode(str));

String reportCaseModelToJson(ReportCaseModel data) => json.encode(data.toJson());

class ReportCaseModel {
  int? id;
  int? userId;
  String? city;
  String? location;
  String? latitude;
  String? longitude;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;

  ReportCaseModel({
    this.id,
    this.userId,
    this.city,
    this.location,
    this.latitude,
    this.longitude,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
  });

  factory ReportCaseModel.fromJson(Map<String, dynamic> json) => ReportCaseModel(
        id: json["id"],
        userId: json["user_id"],
        city: json["city"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "city": city,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "first_name": firstName,
        "last_name": lastName,
      };
}
