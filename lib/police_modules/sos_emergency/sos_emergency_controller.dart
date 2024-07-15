import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoliceSOSEmergencyController extends GetxController {
  Completer<GoogleMapController> googleMapControllerCompleter = Completer();
  List<ReportCaseModel> sosReportsList = [];
  void getSOSEmergencyList({bool? showLoader = true, required String search}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "search": search,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.sosEmergencyList,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      sosReportsList.clear();
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null && response['data'] is List) {
          List list = response['data'];
          for (var report in list) {
            sosReportsList.add(ReportCaseModel.fromJson(report));
          }
        }
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
}
