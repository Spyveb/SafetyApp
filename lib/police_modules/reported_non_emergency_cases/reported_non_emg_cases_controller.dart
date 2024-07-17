import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  String audioState = "Stopped";
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

  ReportCaseModel? reportCaseModel;

  void goToDetails(ReportCaseModel model) {
    reportCaseModel = model;
    update();
  }

  initAudio() async {
    playerState = audioPlayer.state;

    await audioPlayer.getDuration().then((value) {
      totalDuration = value;
      update();
    });

    audioPlayer.getCurrentPosition().then((value) {
      position = value;
      update();
    });

    // initAudioStreams();
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      update();
      print("totalDuration---->  $totalDuration ");
    });

    audioPlayer.onPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      update();
      print("position---> $position");
    });

    audioPlayer.onPlayerStateChanged.listen((state) {
      playerState = state;
      update();
      print("audioState----> $audioState");
    });
  }

  // void initAudioStreams() {
  //   durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
  //     totalDuration = duration;
  //     update();
  //     print("totalDuration ---->  $totalDuration");
  //   });
  //
  //   positionSubscription = audioPlayer.onPositionChanged.listen((p) {
  //     position = p;
  //     update();
  //     print("position ---->  $p");
  //   });
  //
  //   playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
  //     playerState = PlayerState.stopped;
  //     position = Duration.zero;
  //     update();
  //     print("completePosition ---->  $position");
  //     print("completeState ---->  $playerState");
  //   });
  //
  //   playerStateChangeSubscription = audioPlayer.onPlayerStateChanged.listen((state) {
  //     playerState = state;
  //     update();
  //     print("playerState ---->  $playerState");
  //   });
  // }

  playAudio(String url) async {
    audioPlayer.play(UrlSource(url));
    playerState = PlayerState.playing;
    update();
  }

  pauseAudio() async {
    audioPlayer.pause();
    playerState = PlayerState.paused;
    update();
  }

  stopAudio() async {
    audioPlayer.stop();
    playerState = PlayerState.stopped;
    // position = Duration.zero;
    update();
  }

  setSourceUrl(String url) {
    audioPlayer.setSourceUrl(url);
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }
}
