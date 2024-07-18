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
    if (playerState == PlayerState.paused) {
      audioPlayer.resume();
      playerState = PlayerState.playing;
    } else if (playerState == PlayerState.completed || playerState == PlayerState.stopped) {
      audioPlayer.play(
        UrlSource(url),
      );
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

  setSourceUrl(String url) {
    audioPlayer.setSourceUrl(url);
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }
}
