import 'dart:io';
import 'dart:ui';

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
          initState: (state) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (controller.reportCaseModel != null) {
                if (
                    // ((controller.reportCaseModel!.status == 'Pending' || controller.reportCaseModel!.status == 'All') &&
                    //         controller.reportCaseModel!.requestStatus == 'Pending') ||
                    (controller.reportCaseModel!.status == 'Pending' && controller.reportCaseModel!.requestStatus == 'Pending') ||
                        (controller.reportCaseModel!.status == 'All' && controller.reportCaseModel!.requestStatus == 'Pending')) {
                  controller.showReportRequestDialog(context, controller.reportCaseModel!);
                }
                controller.update();
              }
            });
          },
          builder: (controller) {
            return BackgroundWidget(
              child: Column(
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
                            Expanded(
                              child: Text(
                                "${AppLocalizations.of(context)!.caseNo} ${controller.reportCaseModel?.id}",
                                style: TextStyle(
                                  fontSize: getProportionalFontSize(22),
                                  fontFamily: AppFonts.sansFont600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            controller.reportCaseModel != null &&
                                    (controller.reportCaseModel!.status == 'Open' && controller.reportCaseModel!.requestStatus == 'Accept')
                                ? GestureDetector(
                                    onTap: () {
                                      // controller.showEndSosDialog(context);

                                      Utils.showCustomDialog(
                                        context: context,
                                        child: Center(
                                          child: Material(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              getProportionateScreenWidth(32),
                                            ),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 1.5,
                                                sigmaY: 1.5,
                                              ),
                                              child: GetBuilder<ReportedNonEmgCasesController>(
                                                builder: (controller) {
                                                  return Container(
                                                    width: SizeConfig.deviceWidth! * .85,
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: getProportionateScreenWidth(16),
                                                      vertical: getProportionateScreenHeight(16),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(
                                                        getProportionateScreenWidth(32),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(context)!.confirmationMessage,
                                                          style: TextStyle(
                                                              fontFamily: AppFonts.sansFont700,
                                                              fontSize: getProportionalFontSize(22),
                                                              color: AppColors.primaryColor),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          height: getProportionateScreenHeight(10),
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(context)!.areYouSureYouWantToCloseTheCase,
                                                          style: TextStyle(
                                                              fontFamily: AppFonts.sansFont500,
                                                              fontSize: getProportionalFontSize(16),
                                                              color: AppColors.blackColor),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          height: getProportionateScreenHeight(24),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: CommonButton(
                                                                padding: EdgeInsets.symmetric(
                                                                  horizontal: getProportionateScreenWidth(24),
                                                                  vertical: getProportionateScreenHeight(18),
                                                                ),
                                                                text: AppLocalizations.of(context)!.yes,
                                                                onPressed: () async {
                                                                  Get.back();
                                                                  if (controller.reportCaseModel!.id != null) {
                                                                    controller.showEndReportDialog(context, caseId: controller.reportCaseModel!.id!);
                                                                  }
                                                                },
                                                                radius: 50,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: getProportionateScreenWidth(18),
                                                            ),
                                                            Expanded(
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                behavior: HitTestBehavior.opaque,
                                                                child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal: getProportionateScreenWidth(24),
                                                                    vertical: getProportionateScreenHeight(17),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(
                                                                      getProportionateScreenWidth(50),
                                                                    ),
                                                                    border: Border.all(color: AppColors.blackColor, width: 1),
                                                                  ),
                                                                  child: Text(
                                                                    AppLocalizations.of(context)!.no,
                                                                    textAlign: TextAlign.center,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                      fontSize: getProportionalFontSize(16),
                                                                      fontFamily: AppFonts.sansFont600,
                                                                      color: AppColors.primaryColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.redDefault,
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenWidth(
                                            getProportionateScreenWidth(50),
                                          ),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getProportionateScreenWidth(14),
                                        vertical: getProportionateScreenHeight(6),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.closeCase,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getProportionalFontSize(12),
                                          fontFamily: AppFonts.sansFont600,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                      ],
                    ),
                  ),
                  controller.reportCaseModel != null &&
                              (controller.reportCaseModel?.status == 'Open' && controller.reportCaseModel?.requestStatus == 'Accept') ||
                          controller.reportCaseModel?.status == 'Close'
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
                                    requestStatus: "${controller.reportCaseModel!.requestStatus}",
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(8),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getProportionateScreenWidth(8),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.information,
                                        style: TextStyle(
                                          fontSize: getProportionalFontSize(18),
                                          fontFamily: AppFonts.sansFont700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(8),
                                        right: getProportionateScreenWidth(8),
                                      ),
                                      child: Text(
                                        "${controller.reportCaseModel!.information ?? '-'}",
                                        style: TextStyle(
                                          fontSize: getProportionalFontSize(14),
                                          fontFamily: AppFonts.sansFont400,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(8),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(8),
                                  ),
                                  child: Text(
                                    ///TODo : Text change
                                    AppLocalizations.of(context)!.evidence,
                                    style: TextStyle(
                                      fontSize: getProportionalFontSize(18),
                                      fontFamily: AppFonts.sansFont700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                controller.reportCaseModel!.nonEmergencyCaseContents != null && controller.reportCaseModel!.nonEmergencyCaseContents!.isNotEmpty
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
                                          ReportCaseContent report = controller.reportCaseModel!.nonEmergencyCaseContents![index];
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

                                                    await Get.toNamed(Routes.CONTENTS_DETAIL_VIEW, arguments: {"initialContentIndex": index, "model": report});
                                                    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
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
                                                  await Get.toNamed(Routes.CONTENTS_DETAIL_VIEW, arguments: {"initialContentIndex": index, "model": report});

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
                                                Get.toNamed(Routes.CONTENTS_DETAIL_VIEW, arguments: {"initialContentIndex": index, "model": report});
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
                                            AppLocalizations.of(context)!.noEvidence,
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
                      : ((controller.reportCaseModel?.status == 'Pending' && controller.reportCaseModel?.requestStatus == 'Pending') == false &&
                              (controller.reportCaseModel?.status == 'All' && controller.reportCaseModel?.requestStatus == 'Pending') == false)
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!.youAreNotAuthorizedToViewTheReportDetails,
                                style: TextStyle(
                                  fontSize: getProportionalFontSize(14),
                                  fontFamily: AppFonts.sansFont400,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : SizedBox(),
                ],
              ),
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
