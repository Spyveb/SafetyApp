import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';

import '../../imports.dart';

class VideoScreen extends GetView<TrainingController> {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GetBuilder<TrainingController>(
      initState: (state) {
        controller.videoController = PodPlayerController(
          playVideoFrom: Get.arguments["videoUrl"].contains("youtube.com")
              ? PlayVideoFrom.youtube(
                  Get.arguments["videoUrl"],
                )
              : PlayVideoFrom.network(Get.arguments["videoUrl"]),
        )..initialise().then((_) {
            controller.videoController.play();
            controller.update();
          });
      },
      dispose: (state) {
        controller.videoController.dispose();
        controller.videoController.removeListener(() {});
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: themeProvider.themeData == ThemeData.dark() ? Colors.black : Colors.white,
          appBar: AppBar(
            backgroundColor: themeProvider.themeData == ThemeData.dark() ? Colors.black : Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: themeProvider.themeData == ThemeData.dark() ? Colors.white : Colors.black,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: SafeArea(
            child: PodVideoPlayer(
              controller: controller.videoController,
            ),
          ),
        );
      },
    );
  }
}
