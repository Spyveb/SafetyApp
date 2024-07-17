import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pod_player/pod_player.dart';

class ContentsDetailViewScreen extends GetView<ReportedNonEmgCasesController> {
  const ContentsDetailViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<ReportedNonEmgCasesController>(
          initState: (state) {
            controller.pageController = PageController(initialPage: Get.arguments['initialContentIndex']);
          },
          dispose: (state) {
            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
          },
          builder: (controller) {
            return controller.reportCaseModel!.nonEmergencyCaseContents != null &&
                    controller.reportCaseModel!.nonEmergencyCaseContents!.isNotEmpty
                ? PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.reportCaseModel!.nonEmergencyCaseContents!.length,
                    onPageChanged: (value) {
                      if (controller.reportCaseModel!.nonEmergencyCaseContents![value].docType == 'video') {
                        if (controller.videoController != null) {
                          if (controller.videoController!.isInitialised == true) {
                            if (controller.videoController!.videoUrl !=
                                controller.reportCaseModel!.nonEmergencyCaseContents![value].value) {
                              controller.videoController = PodPlayerController(
                                podPlayerConfig: const PodPlayerConfig(
                                  wakelockEnabled: true,
                                  forcedVideoFocus: true,
                                ),
                                playVideoFrom: PlayVideoFrom.network(
                                  controller.reportCaseModel!.nonEmergencyCaseContents![value].value ?? "",
                                  // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny3.mp4",
                                ),
                              )..initialise().then((_) {
                                  controller.videoController!.play();
                                }).catchError((onError) {
                                  if (onError is PlatformException) {
                                    var e = onError;
                                    Utils.showToast(e.message ?? 'Failed to load video');
                                  } else {
                                    Utils.showToast((onError ?? 'Failed to load video').toString());
                                  }
                                });
                            } else {
                              controller.videoController!.play();
                            }
                          } else {
                            playNewVideo(value);
                          }
                        } else {
                          playNewVideo(value);
                        }
                      } else if (controller.reportCaseModel!.nonEmergencyCaseContents![value].docType == 'audio') {
                        if (controller.reportCaseModel!.nonEmergencyCaseContents![value].value != null) {
                          controller.audioPlayer
                              .setSourceUrl(controller.reportCaseModel!.nonEmergencyCaseContents![value].value!);
                        }
                      }
                    },
                    itemBuilder: (context, index) {
                      ReportCaseContent report = controller.reportCaseModel!.nonEmergencyCaseContents![index];
                      return report.docType == 'video'
                          ? controller.videoController != null && controller.videoController!.isInitialised
                              ? PodVideoPlayer(
                                  onVideoError: () {
                                    return Center(
                                      child: Text("Video play error"),
                                    );
                                  },
                                  controller: controller.videoController!,
                                  videoAspectRatio: controller.videoController!.videoPlayerValue != null
                                      ? controller.videoController!.videoPlayerValue!.aspectRatio
                                      : 16 / 9,
                                  frameAspectRatio: controller.videoController!.videoPlayerValue != null
                                      ? controller.videoController!.videoPlayerValue!.aspectRatio
                                      : 16 / 9,
                                )
                              : SizedBox()
                          : report.docType == 'audio'
                              ? Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.audioPlayer.play(
                                          UrlSource(report.value!, mimeType: "audio/mpeg"),
                                        );
                                      },
                                      child: Text(
                                        "Play",
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.audioPlayer.stop();
                                      },
                                      child: Text(
                                        "Stop",
                                      ),
                                    ),
                                  ],
                                )
                              : PhotoView(
                                  imageProvider: CachedNetworkImageProvider(
                                    report.value ?? '',
                                  ),
                                  minScale: PhotoViewComputedScale.contained,
                                  maxScale: PhotoViewComputedScale.contained * 3,
                                  filterQuality: FilterQuality.high,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AppImages.appLogo,
                                      fit: BoxFit.fill,
                                    );
                                  },
                                );
                    },
                  )
                : Container();
          },
        ),
      ),
    );
  }

  void playNewVideo(int value) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    controller.videoController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(controller.reportCaseModel!.nonEmergencyCaseContents![value].value ?? ""),
    )..initialise().then((value) {
        controller.videoController!.play();
        controller.update();
      }).catchError((onError) {
        if (onError is PlatformException) {
          var e = onError;
          Utils.showToast(e.message ?? 'Failed to load video');
        } else {
          Utils.showToast((onError ?? 'Failed to load video').toString());
        }
      });
  }
}
