import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSosRequestDetailScreen extends GetView<HomeController> {
  const UserSosRequestDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<HomeController>(
          init: HomeController(),
          initState: (state) {
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //   controller.getNonEmergencyReportsList(search: '');
            // });
          },
          global: true,
          autoRemove: false,
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                              AppLocalizations.of(context)!.sosEmergency,
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
                        height: getProportionateScreenHeight(30),
                      ),
                    ],
                  ),
                  Expanded(
                    child: controller.userSosEmergencyCaseList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.userSosEmergencyCaseList.length,
                            itemBuilder: (context, index) {
                              ReportCaseModel report = controller.userSosEmergencyCaseList[index];
                              return GestureDetector(
                                onTap: () async {
                                  // controller.audioPlayer.play(AssetSource("notification_siren.mp3"));
                                  // try {
                                  //   Dio dio = Dio();
                                  //   var dir = await getTemporaryDirectory();
                                  //   var path = "${dir.path}/${DateTime.timestamp()}.m4a";
                                  //   var response = await dio.download(
                                  //     'https://royalblue-mandrill-559334.hostingersite.com/public/audios/78791721292158.mp3',
                                  //     path,
                                  //   );
                                  //   if (response.statusCode == 200) {
                                  //     final player = AudioPlayer(); // Create a player
                                  //     print(path);
                                  //     await player.setSourceDeviceFile(path);
                                  //     await player.play(
                                  //       DeviceFileSource(path, mimeType: 'audio/mpeg'),
                                  //     );
                                  //   }
                                  //   // final player = AudioPlayer(); // Create a player
                                  //   // final duration = await player.setAudioSource(
                                  //   //     // Load a URL
                                  //   //     AudioSource.uri(
                                  //   //       Uri.parse(
                                  //   //           'https://royalblue-mandrill-559334.hostingersite.com/public/audios/78791721292158.mp3'),
                                  //   //     ),
                                  //   //     preload: true); // Schemes: (https: | file: | asset: )
                                  //   // await player.play(); // Play without waiting for completion
                                  //
                                  //   // controller.goToDetails(report);
                                  //   // await Get.toNamed(Routes.POLICE_REPORTEDNONEMGCASE_DETAILS);
                                  //   // controller.reportCaseModel=null;
                                  // } catch (e) {
                                  //   print(e);
                                  // }

                                  // controller.goToDetails(report);
                                  // await Get.toNamed(Routes.POLICE_REPORTEDNONEMGCASE_DETAILS);
                                  // controller.reportCaseModel = null;
                                },
                                behavior: HitTestBehavior.opaque,
                                child: CustomCasesList(
                                  caseNo: "${report.id}",
                                  status: "${report.status}",
                                  firstName: "${report.firstName ?? '-'}",
                                  lastName: "${report.lastName ?? '-'}",
                                  date: "${Utils.displayDateFormat(
                                    report.updatedAt ?? DateTime.now().toString(),
                                  )}",
                                  location: "${report.location ?? '-'}",
                                  city: "${report.city ?? '-'}",
                                ),
                              );
                            },
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
