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
  String? type;
  String? information;
  int? alertFriends;
  int? reportAnonymously;
  int? speakToProfessional;
  String? latitude;
  String? longitude;
  String? status;
  String? requestStatus;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? policeOfficerLatitude;
  String? policeOfficerLongitude;
  int? assign_sos_emergency_case_id;
  int? assign_non_emergency_case_id;
  List<ReportCaseContent>? nonEmergencyCaseContents;
  String? note;
  int? backupRequestStatus;

  ReportCaseModel({
    this.id,
    this.userId,
    this.city,
    this.location,
    this.type,
    this.information,
    this.alertFriends,
    this.reportAnonymously,
    this.speakToProfessional,
    this.latitude,
    this.longitude,
    this.status,
    this.requestStatus,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.assign_sos_emergency_case_id,
    this.assign_non_emergency_case_id,
    this.policeOfficerLatitude,
    this.policeOfficerLongitude,
    this.nonEmergencyCaseContents,
    this.note,
    this.backupRequestStatus,
  });

  factory ReportCaseModel.fromJson(Map<String, dynamic> json) => ReportCaseModel(
        id: json["id"],
        userId: json["user_id"],
        city: json["city"],
        location: json["location"],
        type: json["type"],
        information: json["information"],
        alertFriends: json["alert_friends"],
        reportAnonymously: json["report_annonymously"],
        speakToProfessional: json["speak_to_professional"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        requestStatus: json["request_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        policeOfficerLatitude: json["police_officer_latitude"],
        policeOfficerLongitude: json["police_officer_longitude"],
        assign_sos_emergency_case_id: json["assign_sos_emergency_case_id"],
        assign_non_emergency_case_id: json["assign_non_emergency_case_id"],
        nonEmergencyCaseContents: json["non_emergency_case_contents"] == null
            ? []
            : List<ReportCaseContent>.from(
                json["non_emergency_case_contents"]!.map((x) => ReportCaseContent.fromJson(x))),
        note: json["note"],
        backupRequestStatus: json["is_backup_request"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "city": city,
        "location": location,
        "type": type,
        "information": information,
        "alert_friends": alertFriends,
        "report_annonymously": reportAnonymously,
        "speak_to_professional": speakToProfessional,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "request_status": requestStatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "first_name": firstName,
        "last_name": lastName,
        "police_officer_latitude": policeOfficerLatitude,
        "police_officer_longitude": policeOfficerLongitude,
        "assign_sos_emergency_case_id": assign_sos_emergency_case_id,
        "assign_non_emergency_case_id": assign_non_emergency_case_id,
        "non_emergency_case_contents": nonEmergencyCaseContents == null
            ? []
            : List<dynamic>.from(nonEmergencyCaseContents!.map((x) => x.toJson())),
        "note": note,
        "is_backup_request": backupRequestStatus,
      };
}

class ReportCaseContent {
  int? id;
  int? nonEmergencyCaseId;
  String? docType;
  String? value;
  String? createdAt;
  String? updatedAt;

  ReportCaseContent({
    this.id,
    this.nonEmergencyCaseId,
    this.docType,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory ReportCaseContent.fromJson(Map<String, dynamic> json) => ReportCaseContent(
        id: json["id"],
        nonEmergencyCaseId: json["non_emergency_case_id"],
        docType: json["doc_type"],
        value: json["value"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "non_emergency_case_id": nonEmergencyCaseId,
        "doc_type": docType,
        "value": value,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
