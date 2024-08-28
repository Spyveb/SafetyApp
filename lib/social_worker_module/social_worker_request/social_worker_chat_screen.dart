import 'dart:ui';

import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SocialWorkerChatScreen extends GetView<SocialWorkerRequestController> {
  const SocialWorkerChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialWorkerRequestController>(
      init: SocialWorkerRequestController(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((timestamp) {
          controller.lastMessageId = null;
          controller.getChatList();
          controller.startTimer();
        });
      },
      dispose: (state) {
        controller.closeTimer();
      },
      builder: (controller) {
        return Scaffold(
          // backgroundColor: Color(0xFFD8D8D8),

          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Text(
              controller.receiverName ?? '-',
              maxLines: 2,
              style: TextStyle(
                color: AppColors.blackColor,
                fontFamily: AppFonts.sansFont500,
                fontSize: getProportionalFontSize(18),
              ),
            ),
            actions: [
              controller.fromHistory == true
                  ? SizedBox()
                  : GestureDetector(
                      onTap: () {
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
                                child: GetBuilder<SocialWorkerRequestController>(
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
                                                fontFamily: AppFonts.sansFont700, fontSize: getProportionalFontSize(22), color: AppColors.primaryColor),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: getProportionateScreenHeight(10),
                                          ),
                                          Text(
                                            "Are you sure you want to end the session?",
                                            style:
                                                TextStyle(fontFamily: AppFonts.sansFont500, fontSize: getProportionalFontSize(16), color: AppColors.blackColor),
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
                                                    if (controller.sessionId != null) {
                                                      controller.endSession(id: controller.sessionId!);
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
                          horizontal: getProportionateScreenWidth(12),
                          vertical: getProportionateScreenHeight(6),
                        ),
                        margin: EdgeInsets.only(
                          right: getProportionateScreenWidth(8),
                        ),
                        child: Text(
                          "End session",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionalFontSize(12),
                            fontFamily: AppFonts.sansFont500,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(8),
                      horizontal: getProportionateScreenWidth(8),
                    ),
                    shrinkWrap: true,
                    itemCount: controller.chatList.length,
                    itemBuilder: (context, index) {
                      Widget dateTitle = const SizedBox();

                      // if (index < controller.chatList.length - 1) {
                      //   DateTime date = DateTime.fromMillisecondsSinceEpoch(controller.chatList[index].timestamp!);
                      //   DateTime dateAfter = DateTime.fromMillisecondsSinceEpoch(controller.chatList[index + 1].timestamp!);
                      //   if (date.day != dateAfter.day) {
                      //     dateTitle = Padding(
                      //       padding: EdgeInsets.symmetric(
                      //         vertical: getProportionateScreenHeight(10),
                      //       ),
                      //       child: Text(
                      //         DateFormat("dd/MM/yyyy").format(date),
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: getProportionalFontSize(12),
                      //         ),
                      //       ),
                      //     );
                      //   }
                      // }

                      dynamic timeStamp;
                      dynamic time = controller.chatList[index].timestamp;
                      if (time is double) {
                        time = time.toInt();
                      }
                      if (index + 1 < controller.chatList.length - 1) {
                        timeStamp = controller.chatList[index + 1].timestamp;

                        if (timeStamp is double) {
                          timeStamp = timeStamp.toInt();
                        }

                        DateTime dateAfter = DateTime.fromMillisecondsSinceEpoch(timeStamp);
                        DateTime date = DateTime.fromMillisecondsSinceEpoch(time);

                        if (dateAfter.day != date.day) {
                          dateTitle = Padding(
                            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                            child: Text(
                              DateFormat("dd/MM/yyyy").format(date),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionalFontSize(12),
                              ),
                            ),
                          );
                        }
                      } else {
                        dateTitle = Padding(
                          padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(
                              DateTime.fromMillisecondsSinceEpoch(time),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionalFontSize(12),
                            ),
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: dateTitle),
                          controller.chatList[index].socialWorkerId.toString() == controller.userId
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(5),
                                    bottom: getProportionateScreenHeight(5),
                                    left: MediaQuery.of(context).size.width * .2,
                                    right: getProportionateScreenWidth(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: getProportionateScreenWidth(16),
                                          vertical: getProportionateScreenHeight(10),
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor.withOpacity(.34),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                            bottomLeft: Radius.circular(16),
                                            bottomRight: Radius.circular(16),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "${controller.chatList[index].message}",
                                                style: TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontFamily: AppFonts.sansFont500,
                                                  fontSize: getProportionalFontSize(14),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "${DateFormat("MMM dd, hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(controller.chatList[index].timestamp ?? DateTime.now().millisecondsSinceEpoch))}",
                                                style: TextStyle(
                                                  fontFamily: AppFonts.sansFont400,
                                                  fontSize: getProportionalFontSize(12),
                                                  color: AppColors.blackColor.withOpacity(.7),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(5),
                                    bottom: getProportionateScreenHeight(5),
                                    right: MediaQuery.of(context).size.width * .2,
                                    left: getProportionateScreenWidth(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: getProportionateScreenWidth(16),
                                          vertical: getProportionateScreenHeight(10),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF4F4F4),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                            bottomLeft: Radius.circular(16),
                                            bottomRight: Radius.circular(16),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "${controller.chatList[index].message}",
                                                style: TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontFamily: AppFonts.sansFont500,
                                                  fontSize: getProportionalFontSize(14),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "${DateFormat("MMM dd, hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(controller.chatList[index].timestamp ?? DateTime.now().millisecondsSinceEpoch))}",
                                                style: TextStyle(
                                                  fontFamily: AppFonts.sansFont400,
                                                  fontSize: getProportionalFontSize(12),
                                                  color: AppColors.blackColor.withOpacity(.7),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                ),
                controller.fromHistory == true
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(8),
                          vertical: getProportionateScreenHeight(4),
                        ),
                        child: TextFormField(
                          controller: controller.messageController,
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                            color: AppColors.blackColor,
                          ),
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (controller.messageController.text.isNotEmpty) {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  controller.sendMessage(showLoader: true);
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: AppColors.blackColor,
                                size: 24,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.whiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10),
                              ),
                              borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(.8), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10),
                              ),
                              borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(.8), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10),
                              ),
                              borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(.8), width: 1),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10),
                              ),
                              borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(.5), width: 1),
                            ),
                            hintText: AppLocalizations.of(context)!.enterText,
                            hintStyle: TextStyle(
                              fontFamily: AppFonts.sansFont400,
                              fontSize: getProportionalFontSize(16),
                              color: AppColors.lightTextColor,
                            ),
                            errorStyle: TextStyle(
                              fontSize: getProportionalFontSize(12),
                              fontFamily: AppFonts.sansFont400,
                              color: AppColors.redDefault,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(16),
                              vertical: getProportionateScreenHeight(14),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}