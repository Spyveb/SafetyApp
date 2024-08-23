import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pod_player/pod_player.dart';

import '../../imports.dart';

class ReportedNonEmgCasesController extends GetxController {
  bool showOverlay = false;

  PageController pageController = PageController();
  PodPlayerController? videoController;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? totalDuration;
  Duration? position;
  StreamSubscription? durationSubscription;
  StreamSubscription? positionSubscription;
  StreamSubscription? playerCompleteSubscription;
  StreamSubscription? playerStateChangeSubscription;
  PlayerState? playerState;

  List<ReportCaseModel> nonEmergencyReportsList = [];

  void getNonEmergencyReportsList({bool? showLoader = true, required String search}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "search": search,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.nonEmergencyList,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      nonEmergencyReportsList.clear();
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null && response['data'] is List) {
          List list = response['data'];
          for (var report in list) {
            nonEmergencyReportsList.add(ReportCaseModel.fromJson(report));
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

  void getOpenNonEmergencyReportsList({bool? showLoader = true, required String search}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "search": search,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.openNonEmergencyList,
        // Endpoints.nonEmergencyList,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      nonEmergencyReportsList.clear();
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null && response['data'] is List) {
          List list = response['data'];
          for (var report in list) {
            nonEmergencyReportsList.add(ReportCaseModel.fromJson(report));
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

  ReportCaseModel? reportCaseModel;

  void goToDetails(ReportCaseModel model) {
    reportCaseModel = model;
    update();
  }

  void updateNonEmergencyRequest({bool? showLoader = true, required int caseId, required String status, int? assignNonEmergencyCaseId}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        // "non_emergency_case_id": caseId,
        "request_status": status,
      });

      if (assignNonEmergencyCaseId != null) {
        formData.fields.add(MapEntry('assign_non_emergency_case_id', assignNonEmergencyCaseId.toString()));
      } else {
        formData.fields.add(MapEntry('non_emergency_case_id', caseId.toString()));
      }

      var response = await ApiProvider().postAPICall(
        Endpoints.updateNonEmergencyCaseStatus,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        Utils.showToast(response['message'] ?? 'Report request status updated successfully.');
        if (status == 'Decline') {
          getOpenNonEmergencyReportsList(search: '', showLoader: false);
          Get.back();
          Get.back();
        } else {
          Get.back();
          if (response['data'] != null) {
            reportCaseModel = ReportCaseModel.fromJson(response['data']);
            update();
            getOpenNonEmergencyReportsList(search: '', showLoader: false);
          } else {
            getOpenNonEmergencyReportsList(search: '', showLoader: false);
            Get.back();
          }
        }
      } else {
        Utils.showToast(response['message'] ?? 'Failed to update request status');
      }

      update();
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      Get.back();
      update();
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      update();
      Get.back();
      debugPrint(e.toString());
    }
  }

  showReportRequestDialog(BuildContext context, ReportCaseModel reportCaseModel) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.policeDarkBlueColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.reportedRequest,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont600,
                      fontSize: getProportionalFontSize(30),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.requester,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${reportCaseModel.firstName ?? '-'} ${reportCaseModel.lastName ?? '-'}",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.location,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          reportCaseModel.location ?? '-',
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       AppLocalizations.of(context)!.mobileNumber,
                  //       style: TextStyle(
                  //         fontFamily: AppFonts.sansFont600,
                  //         fontSize: getProportionalFontSize(16),
                  //       ),
                  //     ),
                  //     Flexible(
                  //       child: Text(
                  //         "${reportCaseModel.city ?? '-'}",
                  //         style: TextStyle(
                  //           fontFamily: AppFonts.sansFont400,
                  //           fontSize: getProportionalFontSize(16),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: getProportionateScreenHeight(10),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.emergencyEvent,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Non emergency",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                            color: AppColors.redDefault,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // AppLocalizations.of(context)!.estimatedTimeOfArrival,
                        "Distance: ",
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${calculateDistance(double.parse(reportCaseModel.policeOfficerLatitude!), double.parse(reportCaseModel.policeOfficerLongitude!), double.parse(reportCaseModel.latitude!), double.parse(reportCaseModel.longitude!))}",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (reportCaseModel.id != null) {
                                updateNonEmergencyRequest(
                                    caseId: reportCaseModel.id!, status: 'Accept', assignNonEmergencyCaseId: reportCaseModel.assign_non_emergency_case_id);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.policeDarkBlueColor,
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(30),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    AppLocalizations.of(context)!.accept,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getProportionalFontSize(18),
                                      fontFamily: AppFonts.sansFont600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(30),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (reportCaseModel.id != null) {
                                updateNonEmergencyRequest(
                                    caseId: reportCaseModel.id!, status: 'Decline', assignNonEmergencyCaseId: reportCaseModel.assign_non_emergency_case_id);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.redDefault,
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(30),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    AppLocalizations.of(context)!.decline,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getProportionalFontSize(18),
                                      fontFamily: AppFonts.sansFont600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    // ).then((value) {
    //   Get.back();
    // });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> initAudio() async {
    playerState = PlayerState.stopped;
    audioPlayer.getDuration().then((value) {
      totalDuration = value;
      update(["audio_controller"]);
    });

    audioPlayer.getCurrentPosition().then((value) {
      position = value;
      update(["audio_controller"]);
    });

    // initAudioStreams();
    durationSubscription = audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      update(["audio_controller"]);
      print("totalDuration---->  $totalDuration ");
    });

    positionSubscription = audioPlayer.onPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      update(["audio_controller"]);
      print("position---> $position");
    });

    playerStateChangeSubscription = audioPlayer.onPlayerStateChanged.listen((state) {
      playerState = state;
      update(["audio_controller"]);
      print("audioState----> $playerState");
    });

    playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
      playerState = PlayerState.completed;
      position = Duration.zero;
      update(["audio_controller"]);
      print("completePosition ---->  $position");
      print("completeState ---->  $playerState");
    });
  }

  playAudio(String url) async {
    String path = url.split('/').last.split('.').first;
    Directory directory = await getTemporaryDirectory();
    String dirPath = "${directory.path}/${path}.m4a";
    if (playerState == PlayerState.paused) {
      audioPlayer.resume();
      playerState = PlayerState.playing;
    } else if (playerState == PlayerState.completed || playerState == PlayerState.stopped) {
      try {
        audioPlayer.play(
          DeviceFileSource(
            dirPath,
          ),
        );
      } on PlatformException catch (e) {
        if (e.code == 'DarwinAudioError') {
          audioPlayer.play(
            DeviceFileSource(dirPath, mimeType: 'audio/mpeg'),
          );
        }
      }
      playerState = PlayerState.playing;
    }
    update(["audio_controller"]);
  }

  pauseAudio() async {
    audioPlayer.pause();
    playerState = PlayerState.paused;
    update(["audio_controller"]);
  }

  stopAudio() async {
    audioPlayer.stop();
    playerState = PlayerState.stopped;
    // position = Duration.zero;
    update(["audio_controller"]);
  }

  setSourceUrl(String url) async {
    String path = url.split('/').last.split('.').first;
    Directory directory = await getTemporaryDirectory();
    String dirPath = "${directory.path}/${path}.m4a";
    if (await File(dirPath).exists()) {
      try {
        await audioPlayer.setSourceDeviceFile(
          dirPath,
        );
      } on PlatformException catch (e) {
        if (e.code == 'DarwinAudioError') {
          await audioPlayer.setSourceDeviceFile(dirPath, mimeType: 'audio/mpeg');
        }
      }
    } else {
      var response = await Dio.Dio().download(
        url,
        dirPath,
      );
      if (response.statusCode == 200) {
        // await audioPlayer.setSourceDeviceFile(dirPath, mimeType: 'audio/mpeg');
        try {
          await audioPlayer.setSourceDeviceFile(
            dirPath,
          );
        } on PlatformException catch (e) {
          if (e.code == 'DarwinAudioError') {
            await audioPlayer.setSourceDeviceFile(dirPath, mimeType: 'audio/mpeg');
          }
        }
      }
    }
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }

  TextEditingController endReportNotesController = TextEditingController();

  showEndReportDialog(BuildContext context, {required int caseId}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: GetBuilder<ReportedNonEmgCasesController>(
            id: 'end_report_dialog',
            builder: (controller) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.policeDarkBlueColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.whatHappenedThisEvent,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      TextFormField(
                        controller: endReportNotesController,
                        maxLines: null,
                        maxLength: 300,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onChanged: (value) {
                          endReportNotesController.text = value;
                          update(['end_report_dialog']);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(8),
                            vertical: getProportionateScreenHeight(8),
                          ),
                          constraints: BoxConstraints(
                            maxHeight: getProportionateScreenHeight(100),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25),
                      ),
                      SizedBox(
                        width: SizeConfig.deviceWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redDefault,
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(16),
                              vertical: getProportionateScreenHeight(12),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(30),
                              ),
                            ),
                          ),
                          onPressed: endReportNotesController.text.isNotEmpty
                              ? () {
                                  closeNonEmergencyCaseRequest(caseId: caseId);
                                }
                              : null,
                          child: Text(
                            AppLocalizations.of(context)!.submit,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionalFontSize(18),
                              fontFamily: AppFonts.sansFont600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void closeNonEmergencyCaseRequest({
    bool? showLoader = true,
    required int caseId,
  }) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "id": caseId,
        "note": endReportNotesController.text,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.closeNonEmergencyCase,
        formData,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        endReportNotesController.clear();
        Utils.showToast(response['message'] ?? 'Report closed');
        Get.back();
        Get.back();
      } else {
        Utils.showToast(response['message'] ?? 'Failed to end report');
      }

      update();
      getOpenNonEmergencyReportsList(search: '', showLoader: false);
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
