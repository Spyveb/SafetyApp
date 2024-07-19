// To parse this JSON data, do
//
//     final policeDashboardModel = policeDashboardModelFromJson(jsonString);

import 'dart:convert';

PoliceDashboardModel policeDashboardModelFromJson(String str) => PoliceDashboardModel.fromJson(json.decode(str));

String policeDashboardModelToJson(PoliceDashboardModel data) => json.encode(data.toJson());

class PoliceDashboardModel {
  int? totalIncidentsAssigned;
  int? totalIncidentsAccepted;
  int? totalEmergencyIncidents;
  int? totalActiveCases;

  PoliceDashboardModel({
    this.totalIncidentsAssigned,
    this.totalIncidentsAccepted,
    this.totalEmergencyIncidents,
    this.totalActiveCases,
  });

  factory PoliceDashboardModel.fromJson(Map<String, dynamic> json) => PoliceDashboardModel(
        totalIncidentsAssigned: json["total_incidents_assigned"],
        totalIncidentsAccepted: json["total_incidents_accepted"],
        totalEmergencyIncidents: json["total_imergency_incidents"],
        totalActiveCases: json["total_active_cases"],
      );

  Map<String, dynamic> toJson() => {
        "total_incidents_assigned": totalIncidentsAssigned,
        "total_incidents_accepted": totalIncidentsAccepted,
        "total_imergency_incidents": totalEmergencyIncidents,
        "total_active_cases": totalActiveCases,
      };
}
