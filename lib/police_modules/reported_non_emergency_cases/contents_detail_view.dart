import 'package:cached_network_image/cached_network_image.dart';
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
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
            if (Get.arguments['model'] != null && Get.arguments['model'] is ReportCaseContent) {
              ReportCaseContent report = Get.arguments['model'];
              var videoUrl = report.value;
              // var videoUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4";
              controller.videoController = PodPlayerController(
                playVideoFrom: PlayVideoFrom.network(videoUrl ?? ""),
              )..initialise().then((_) {
                  controller.videoController.play();
                  controller.update();
                });
            }
          },
          dispose: (state) {
            controller.videoController.dispose();
            controller.videoController.removeListener(() {});
          },
          builder: (controller) {
            return controller.reportCaseModel!.nonEmergencyCaseContents != null &&
                    controller.reportCaseModel!.nonEmergencyCaseContents!.isNotEmpty
                ? PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.reportCaseModel!.nonEmergencyCaseContents!.length,
                    itemBuilder: (context, index) {
                      ReportCaseContent report = controller.reportCaseModel!.nonEmergencyCaseContents![index];
                      return report.docType == 'video'
                          ? PodVideoPlayer(
                              controller: controller.videoController,
                              videoAspectRatio: controller.videoController.videoPlayerValue!.aspectRatio,
                              frameAspectRatio: controller.videoController.videoPlayerValue!.aspectRatio,
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
                              });
                    },
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
