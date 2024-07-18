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
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          controller.showOverlay = !controller.showOverlay;
          controller.update();
        },
        child: GetBuilder<ReportedNonEmgCasesController>(
          initState: (state) async {
            controller.pageController = PageController(initialPage: Get.arguments['initialContentIndex']);

            if (controller.reportCaseModel!.nonEmergencyCaseContents![Get.arguments['initialContentIndex']].docType ==
                'audio') {
              if (controller.reportCaseModel!.nonEmergencyCaseContents![Get.arguments['initialContentIndex']].value !=
                  null) {
                controller.setSourceUrl(
                    controller.reportCaseModel!.nonEmergencyCaseContents![Get.arguments['initialContentIndex']].value!);
                controller.initAudio();
              }
            }
            // if (Get.arguments['model'] != null && Get.arguments['model'] is ReportCaseContent) {
            //   ReportCaseContent report = Get.arguments['model'];
            //   var videoUrl = report.value;
            //   // var videoUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4";
            //   controller.videoController = PodPlayerController(
            //     playVideoFrom: PlayVideoFrom.network(videoUrl ?? ""),
            //   )..initialise().then((_) {
            //       controller.videoController.play();
            //       controller.update();
            //     });
            // }
          },
          dispose: (state) {
            controller.audioPlayer.stop();
            // controller.durationSubscription?.cancel();
            // controller.positionSubscription?.cancel();
            // controller.playerCompleteSubscription?.cancel();
            // controller.playerStateChangeSubscription?.cancel();
            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

            // controller.videoController.dispose();
            // controller.videoController.removeListener(() {});
          },
          builder: (controller) {
            return controller.reportCaseModel!.nonEmergencyCaseContents != null &&
                    controller.reportCaseModel!.nonEmergencyCaseContents!.isNotEmpty
                ? Stack(
                    children: [
                      PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.reportCaseModel!.nonEmergencyCaseContents!.length,
                        onPageChanged: (value) async {
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
                              await controller
                                  .setSourceUrl(controller.reportCaseModel!.nonEmergencyCaseContents![value].value!);

                              controller.initAudio();
                            }
                          }
                        },
                        itemBuilder: (context, index) {
                          ReportCaseContent report = controller.reportCaseModel!.nonEmergencyCaseContents![index];
                          return report.docType == 'video'
                              ? controller.videoController != null && controller.videoController!.isInitialised
                                  ? PodVideoPlayer(
                                      podProgressBarConfig: PodProgressBarConfig(
                                        padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(8),
                                          right: getProportionateScreenWidth(8),
                                        ),
                                      ),
                                      // overlayBuilder: (options) {
                                      //   return Container(
                                      //     color: Colors.transparent,
                                      //     child: Column(
                                      //       children: [
                                      //         Container(
                                      //           color: Colors.red,
                                      //           height: 50,
                                      //           width: 50,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   );
                                      // },
                                      onVideoError: () {
                                        return Center(
                                          child: Text("Video play error"),
                                        );
                                      },
                                      controller: controller.videoController!,
                                      videoAspectRatio: controller.videoController!.videoPlayerValue != null
                                          ? controller.videoController!.videoPlayerValue!.aspectRatio
                                          : 16 / 9,
                                      // frameAspectRatio: controller.videoController!.videoPlayerValue != null
                                      //     ? controller.videoController!.videoPlayerValue!.aspectRatio
                                      //     : 16 / 9,
                                    )
                                  : SizedBox()
                              : report.docType == 'audio'
                                  ? GetBuilder<ReportedNonEmgCasesController>(
                                      id: "audio_controller",
                                      builder: (audioController) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: getProportionateScreenHeight(5),
                                                horizontal: getProportionateScreenWidth(5),
                                              ),
                                              child: Image.asset(
                                                AppImages.musicLogo,
                                                height: getProportionateScreenHeight(150),
                                                width: getProportionateScreenHeight(150),
                                              ),
                                            ),
                                            Text(
                                              audioController.totalDuration.toString(),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              audioController.position.toString(),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              audioController.audioState,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Slider(
                                              value: 0.2,
                                              allowedInteraction: SliderInteraction.slideThumb,
                                              onChanged: (value) {},
                                            ),
                                            FloatingActionButton(
                                              shape: CircleBorder(),
                                              onPressed: () {},
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: getProportionateScreenWidth(10),
                                                  vertical: getProportionateScreenHeight(10),
                                                ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.red,
                                                    width: 3,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.play_arrow,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                audioController.playAudio(report.value!);
                                              },
                                              child: Text(
                                                "Play",
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                audioController.pauseAudio();
                                              },
                                              child: Text(
                                                "pause",
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                audioController.stopAudio();
                                              },
                                              child: Text(
                                                "Stop",
                                              ),
                                            ),
                                          ],
                                        );
                                      })
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
                      ),
                      controller.showOverlay
                          ? Positioned(
                              // alignment: Alignment.topLeft,
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: SizeConfig.deviceWidth,
                                alignment: Alignment.centerLeft,
                                // height: getProportionateScreenHeight(100),

                                padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(14),
                                  right: getProportionateScreenWidth(14),
                                  top: getProportionateScreenHeight(56),
                                  bottom: getProportionateScreenHeight(12),
                                ),
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.75)),
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  )
                : SizedBox();
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
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }
}
