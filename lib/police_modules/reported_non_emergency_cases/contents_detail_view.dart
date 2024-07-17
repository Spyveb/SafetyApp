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
            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
            // controller.videoController.dispose();
            // controller.videoController.removeListener(() {});
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
                                podPlayerConfig: PodPlayerConfig(
                                  wakelockEnabled: true,
                                  forcedVideoFocus: true,
                                ),
                                playVideoFrom: PlayVideoFrom.network(
                                  controller.reportCaseModel!.nonEmergencyCaseContents![value].value ?? "",
                                ),
                              )..initialise().then((_) {
                                  controller.videoController!.play();
                                });
                            } else {
                              controller.videoController!.play();
                            }
                          } else {
                            playNew(value);
                          }
                        } else {
                          playNew(value);
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
                                  // videoTitle: Padding(
                                  //   padding: EdgeInsets.only(
                                  //     left: getProportionateScreenWidth(12),
                                  //   ),
                                  //   child: Text(
                                  //     "EKANKNFKL",
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: getProportionalFontSize(15),
                                  //       fontWeight: FontWeight.w600,
                                  //     ),
                                  //   ),
                                  // ),
                                )
                              : SizedBox()
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
                              });
                    },
                  )
                : Container();
          },
        ),
      ),
    );
  }

  void playNew(int value) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    controller.videoController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(controller.reportCaseModel!.nonEmergencyCaseContents![value].value ?? ""),
    )..initialise().then((_) {
        controller.videoController!.play();
        controller.update();
      });
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }
}
