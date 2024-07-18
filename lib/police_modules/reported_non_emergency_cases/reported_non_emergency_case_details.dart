import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ReportedNonEmgCaseDetailsScreen extends GetView<ReportedNonEmgCasesController> {
  const ReportedNonEmgCaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<ReportedNonEmgCasesController>(
          initState: (state) {},
          builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: getProportionateScreenHeight(40),
                              width: getProportionateScreenWidth(40),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(bottom: getProportionateScreenHeight(8)),
                              child: Icon(
                                Icons.arrow_back,
                                size: 22,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "${AppLocalizations.of(context)!.caseNo} ${controller.reportCaseModel?.id}",
                              style: TextStyle(
                                fontSize: getProportionalFontSize(22),
                                fontFamily: AppFonts.sansFont600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                    ],
                  ),
                ),
                controller.reportCaseModel != null
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(14),
                                ),
                                child: CustomCasesList(
                                  caseNo: "${controller.reportCaseModel!.id}",
                                  status: "${controller.reportCaseModel!.status}",
                                  firstName: "${controller.reportCaseModel!.firstName ?? '-'}",
                                  lastName: "${controller.reportCaseModel!.lastName ?? '-'}",
                                  date: "${Utils.displayDateFormat(
                                    controller.reportCaseModel!.updatedAt ?? DateTime.now().toString(),
                                  )}",
                                  location: "${controller.reportCaseModel!.location ?? '-'}",
                                  city: "${controller.reportCaseModel!.city ?? '-'}",
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(15),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(8),
                                ),
                                child: Text(
                                  ///TODo : Text change
                                  "Evidence",
                                  style: TextStyle(
                                    fontSize: getProportionalFontSize(18),
                                    fontFamily: AppFonts.sansFont700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              controller.reportCaseModel!.nonEmergencyCaseContents != null &&
                                      controller.reportCaseModel!.nonEmergencyCaseContents!.isNotEmpty
                                  ? GridView.builder(
                                      padding: EdgeInsets.symmetric(
                                        vertical: getProportionateScreenHeight(12),
                                        horizontal: getProportionateScreenWidth(8),
                                      ),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.reportCaseModel!.nonEmergencyCaseContents!.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: getProportionateScreenHeight(3),
                                        crossAxisSpacing: getProportionateScreenWidth(3),
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        ReportCaseContent report =
                                            controller.reportCaseModel!.nonEmergencyCaseContents![index];
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () async {
                                            if (report.docType == 'video') {
                                              SystemChrome.setPreferredOrientations([
                                                DeviceOrientation.portraitDown,
                                                DeviceOrientation.portraitUp,
                                                DeviceOrientation.landscapeLeft,
                                                DeviceOrientation.landscapeRight
                                              ]);

                                              controller.update();

                                              controller.videoController = PodPlayerController(
                                                playVideoFrom: PlayVideoFrom.network(report.value ?? ""),
                                              )..initialise().then((value) async {
                                                  controller.videoController!.play();
                                                  controller.update();

                                                  await Get.toNamed(Routes.CONTENTS_DETAIL_VIEW,
                                                      arguments: {"initialContentIndex": index, "model": report});
                                                  SystemChrome.setPreferredOrientations(
                                                      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
                                                }).catchError((onError) {
                                                  if (onError is PlatformException) {
                                                    var e = onError;
                                                    Utils.showToast(e.message ?? 'Failed to load video');
                                                  } else {
                                                    Utils.showToast((onError ?? 'Failed to load video').toString());
                                                  }
                                                });
                                            } else if (report.docType == 'audio') {
                                              if (controller.audioPlayer.state == PlayerState.disposed) {
                                                controller.audioPlayer = AudioPlayer();
                                              }

                                              controller.setSourceUrl(report.value!);
                                              controller.initAudio().then((value) async {
                                                await Get.toNamed(Routes.CONTENTS_DETAIL_VIEW,
                                                    arguments: {"initialContentIndex": index, "model": report});

                                                controller.audioPlayer.stop();
                                                controller.durationSubscription?.cancel();
                                                controller.positionSubscription?.cancel();
                                                controller.playerCompleteSubscription?.cancel();
                                                controller.playerStateChangeSubscription?.cancel();
                                                controller.audioPlayer.dispose();
                                              }).catchError((onError) {
                                                Utils.showToast((onError ?? 'Failed to load audio').toString());
                                              });
                                            } else {
                                              Get.toNamed(Routes.CONTENTS_DETAIL_VIEW,
                                                  arguments: {"initialContentIndex": index, "model": report});
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.blackColor, width: .2),
                                            ),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                _buildView(report),
                                                report.docType == 'video' || report.docType == 'audio'
                                                    ? Align(
                                                        alignment: Alignment.bottomLeft,
                                                        child: Container(
                                                          // height: getProportionateScreenHeight(18),
                                                          // width: getProportionateScreenWidth(18),
                                                          margin: EdgeInsets.symmetric(
                                                            horizontal: getProportionateScreenWidth(6),
                                                            vertical: getProportionateScreenHeight(6),
                                                          ),
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal: getProportionateScreenWidth(2),
                                                            vertical: getProportionateScreenHeight(2),
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey.shade400,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons.play_arrow,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox()
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: getProportionateScreenHeight(100),
                                        ),
                                        child: Text(
                                          "No Evidence",
                                          style: TextStyle(
                                            fontSize: getProportionalFontSize(16),
                                            fontFamily: AppFonts.sansFont600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildView(ReportCaseContent report) {
    Widget widget = SizedBox();
    if (report.docType == 'image') {
      widget = Container(
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          // borderRadius: BorderRadius.circular(
          //   getProportionateScreenWidth(8),
          // ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              report.value ?? '',
            ),
          ),
        ),
        alignment: Alignment.center,
      );
    } else if (report.docType == 'video') {
      widget = FutureBuilder(
        future: extractThumbnail(report.value),
        builder: (context, snapshot) {
          return snapshot.data != null
              ? Container(
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    // borderRadius: BorderRadius.circular(
                    //   getProportionateScreenWidth(8),
                    // ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        snapshot.data!,
                      ),
                    ),
                  ),
                )
              : SizedBox();
        },
      );
    } else if (report.docType == 'audio') {
      widget = Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(12),
          horizontal: getProportionateScreenWidth(12),
        ),
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          // borderRadius: BorderRadius.circular(
          //   getProportionateScreenWidth(8),
          // ),
          image: DecorationImage(
            image: AssetImage(
              AppImages.audioIcon,
            ),
          ),
        ),
      );
    }

    return widget;
  }

  Future<File> extractThumbnail(String? url) async {
    final uint8list = await VideoThumbnail.thumbnailFile(
      video: url!,
      imageFormat: ImageFormat.PNG,
      // thumbnailPath: (await getTemporaryDirectory()).path,
      quality: 100,
    );
    final file = File(uint8list!);
    return file;
  }
}
