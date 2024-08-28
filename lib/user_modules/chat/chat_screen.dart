import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        // leadingWidth: getProportionateScreenWidth(56),
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     size: 32,
        //     color: AppColors.blackColor,
        //   ),
        // ),
        elevation: 0, surfaceTintColor: Colors.transparent,
        toolbarHeight: getProportionateScreenHeight(56),
        centerTitle: false,
        title: Text(
          AppLocalizations.of(context)!.counsellor,
          style: TextStyle(
            fontSize: getProportionalFontSize(32),
            color: themeProvider.textThemeColor,
            fontFamily: AppFonts.sansFont600,
          ),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<ChatController>(
          init: ChatController(),
          autoRemove: false,
          global: true,
          initState: (state) {
            WidgetsBinding.instance.addPostFrameCallback((timestamp) {
              controller.lastMessageId = null;
              controller.getChatList(showLoader: false);
              controller.startTimer();
            });
          },
          dispose: (state) {
            controller.closeTimer();
          },
          builder: (controller) {
            return Container(
              // color: AppColors.primaryColor.withOpacity(.44),
              // padding: EdgeInsets.symmetric(
              //   vertical: getProportionateScreenHeight(6),
              // ),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       child: Container(
              //         child: ListView.builder(
              //           shrinkWrap: true,
              //           itemCount: controller.messageList.length,
              //           itemBuilder: (context, index) {
              //             Widget dateTitle = const SizedBox();
              //             if (index < controller.messageList.length - 1) {
              //               DateTime dateAfter =
              //                   DateTime.fromMillisecondsSinceEpoch(controller.messageList[index + 1].timeStamp);
              //               DateTime date =
              //                   DateTime.fromMillisecondsSinceEpoch(controller.messageList[index].timeStamp);
              //
              //               if (dateAfter.day != date.day) {
              //                 dateTitle = Padding(
              //                   padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
              //                   child: Text(
              //                     DateFormat("dd/MM/yyyy").format(date),
              //                     style: TextStyle(
              //                       color: themeProvider.themeData == ThemeData.dark() ? Colors.white : Colors.black,
              //                       fontSize: getProportionalFontSize(12),
              //                     ),
              //                   ),
              //                 );
              //               }
              //             } else {
              //               dateTitle = Padding(
              //                 padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
              //                 child: Text(
              //                   DateFormat('dd/MM/yyyy').format(
              //                     DateTime.fromMillisecondsSinceEpoch(controller.messageList[index].timeStamp),
              //                   ),
              //                   style: TextStyle(
              //                     color: themeProvider.themeData == ThemeData.dark() ? Colors.white : Colors.black,
              //                     fontSize: getProportionalFontSize(12),
              //                   ),
              //                 ),
              //               );
              //             }
              //             return Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 // Center(child: dateTitle),
              //                 controller.messageList[index].userId == 0
              //                     ? Padding(
              //                         padding: EdgeInsets.only(
              //                           top: getProportionateScreenHeight(5),
              //                           bottom: getProportionateScreenHeight(5),
              //                           left: MediaQuery.of(context).size.width * .2,
              //                           right: getProportionateScreenWidth(8),
              //                         ),
              //                         child: Row(
              //                           mainAxisAlignment: MainAxisAlignment.end,
              //                           crossAxisAlignment: CrossAxisAlignment.end,
              //                           children: [
              //                             Container(
              //                               padding: EdgeInsets.symmetric(
              //                                 horizontal: getProportionateScreenWidth(16),
              //                                 vertical: getProportionateScreenHeight(10),
              //                               ),
              //                               decoration: BoxDecoration(
              //                                 color: AppColors.whiteColor,
              //                                 borderRadius: BorderRadius.only(
              //                                   topLeft: Radius.circular(16),
              //                                   topRight: Radius.circular(16),
              //                                   bottomLeft: Radius.circular(16),
              //                                   bottomRight: Radius.circular(16),
              //                                 ),
              //                               ),
              //                               child: Column(
              //                                 crossAxisAlignment: CrossAxisAlignment.end,
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 children: [
              //                                   Flexible(
              //                                     child: Text(
              //                                       "${controller.messageList[index].text}",
              //                                       style: TextStyle(
              //                                         color: themeProvider.textThemeColor,
              //                                         fontFamily: AppFonts.sansFont400,
              //                                         fontSize: getProportionalFontSize(12),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Align(
              //                                     alignment: Alignment.bottomRight,
              //                                     child: Text(
              //                                       "${DateFormat("HH:mm").format(DateTime.fromMillisecondsSinceEpoch(controller.messageList[index].timeStamp))}",
              //                                       style: TextStyle(
              //                                         fontFamily: AppFonts.sansFont700,
              //                                         fontSize: getProportionalFontSize(12),
              //                                         color: AppColors.blackColor,
              //                                       ),
              //                                     ),
              //                                   )
              //                                 ],
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                       )
              //                     : Padding(
              //                         padding: EdgeInsets.only(
              //                           top: getProportionateScreenHeight(5),
              //                           bottom: getProportionateScreenHeight(5),
              //                           right: MediaQuery.of(context).size.width * .2,
              //                           left: getProportionateScreenWidth(8),
              //                         ),
              //                         child: Container(
              //                           padding: EdgeInsets.symmetric(
              //                             horizontal: getProportionateScreenWidth(16),
              //                             vertical: getProportionateScreenHeight(10),
              //                           ),
              //                           decoration: BoxDecoration(
              //                             color: AppColors.whiteColor,
              //                             borderRadius: BorderRadius.only(
              //                               topLeft: Radius.circular(16),
              //                               topRight: Radius.circular(16),
              //                               bottomLeft: Radius.circular(16),
              //                               bottomRight: Radius.circular(16),
              //                             ),
              //                           ),
              //                           // child: Column(
              //                           //   crossAxisAlignment: CrossAxisAlignment.start,
              //                           //   mainAxisSize: MainAxisSize.min,
              //                           //   children: [
              //                           //     Flexible(
              //                           //       child: Text(
              //                           //         "${controller.messageList[index].text}",
              //                           //         style: TextStyle(
              //                           //           color: themeProvider.textThemeColor,
              //                           //           fontFamily: AppFonts.sansFont400,
              //                           //           fontSize: getProportionalFontSize(12),
              //                           //         ),
              //                           //       ),
              //                           //     ),
              //                           //     Align(
              //                           //       alignment: Alignment.bottomRight,
              //                           //       child: Text(
              //                           //         "9:00",
              //                           //         style: TextStyle(
              //                           //           fontFamily: AppFonts.sansFont700,
              //                           //           fontSize: getProportionalFontSize(12),
              //                           //           color: AppColors.blackColor,
              //                           //         ),
              //                           //       ),
              //                           //     ),
              //                           //   ],
              //                           // ),
              //
              //                           child: Column(
              //                             crossAxisAlignment: CrossAxisAlignment.start,
              //                             mainAxisSize: MainAxisSize.min,
              //                             children: [
              //                               Text(
              //                                 "${controller.messageList[index].text}",
              //                                 style: TextStyle(
              //                                   color: themeProvider.textThemeColor,
              //                                   fontFamily: AppFonts.sansFont400,
              //                                   fontSize: getProportionalFontSize(12),
              //                                 ),
              //                               ),
              //                               Align(
              //                                 alignment: Alignment.bottomRight,
              //                                 child: Text(
              //                                   "${DateFormat("HH:mm").format(DateTime.fromMillisecondsSinceEpoch(controller.messageList[index].timeStamp))}",
              //                                   style: TextStyle(
              //                                     fontFamily: AppFonts.sansFont700,
              //                                     fontSize: getProportionalFontSize(12),
              //                                     color: AppColors.blackColor,
              //                                   ),
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //               ],
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //     TextFormField(
              //       controller: controller.messageController,
              //       style: TextStyle(
              //         fontFamily: AppFonts.sansFont400,
              //         fontSize: getProportionalFontSize(16),
              //         color: AppColors.blackColor,
              //       ),
              //       decoration: InputDecoration(
              //         errorMaxLines: 2,
              //         isDense: true,
              //         suffixIcon: IconButton(
              //           onPressed: () {
              //             if (controller.messageController.text.trim().isNotEmpty) {
              //               bool addMessage = true;
              //               Utils.showCustomDialog(
              //                 context: context,
              //                 barrierDismissible: true,
              //                 child: Center(
              //                   child: Material(
              //                     color: Colors.white,
              //                     borderRadius: BorderRadius.circular(
              //                       getProportionateScreenWidth(32),
              //                     ),
              //                     child: BackdropFilter(
              //                       filter: ImageFilter.blur(
              //                         sigmaX: 1.5,
              //                         sigmaY: 1.5,
              //                       ),
              //                       child: Container(
              //                         width: SizeConfig.deviceWidth! * .85,
              //                         padding: EdgeInsets.symmetric(
              //                           horizontal: getProportionateScreenWidth(16),
              //                           vertical: getProportionateScreenHeight(60),
              //                         ),
              //                         decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(
              //                             getProportionateScreenWidth(32),
              //                           ),
              //                           color: Colors.white,
              //                         ),
              //                         child: Column(
              //                           mainAxisAlignment: MainAxisAlignment.center,
              //                           crossAxisAlignment: CrossAxisAlignment.center,
              //                           mainAxisSize: MainAxisSize.min,
              //                           children: [
              //                             Container(
              //                               height: getProportionateScreenHeight(141),
              //                               width: getProportionateScreenWidth(141),
              //                               decoration: BoxDecoration(
              //                                 image: DecorationImage(
              //                                   image: AssetImage(AppImages.messageSent),
              //                                 ),
              //                               ),
              //                             ),
              //                             Text(
              //                               "Message Sent!",
              //                               style: TextStyle(
              //                                 fontFamily: AppFonts.sansFont600,
              //                                 fontSize: getProportionalFontSize(20),
              //                               ),
              //                               textAlign: TextAlign.center,
              //                             ),
              //                             SizedBox(
              //                               height: getProportionateScreenHeight(10),
              //                             ),
              //                             Text(
              //                               "Our social worker will respond to you shortly",
              //                               style: TextStyle(
              //                                 fontFamily: AppFonts.sansFont400,
              //                                 fontSize: getProportionalFontSize(16),
              //                               ),
              //                               textAlign: TextAlign.center,
              //                             ),
              //                             SizedBox(
              //                               height: getProportionateScreenHeight(28),
              //                             ),
              //                             CommonButton(
              //                               width: getProportionateScreenWidth(196),
              //                               text: AppLocalizations.of(context)!.undo,
              //                               onPressed: () {
              //                                 addMessage = false;
              //                                 Get.back();
              //                               },
              //                               radius: 50,
              //                             )
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 onPop: () {
              //                   if (addMessage == true) {
              //                     controller.messageList.add(
              //                       MessageModel(
              //                           userId: 0,
              //                           text: controller.messageController.text,
              //                           timeStamp: DateTime.now().millisecondsSinceEpoch),
              //                     );
              //
              //                     controller.update();
              //                     controller.messageController.clear();
              //                   }
              //                 },
              //               );
              //             }
              //           },
              //           icon: Icon(
              //             Icons.send,
              //             color: AppColors.blackColor,
              //             size: 24,
              //           ),
              //         ),
              //         filled: true,
              //         fillColor: AppColors.whiteColor,
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(
              //             getProportionateScreenWidth(10),
              //           ),
              //           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(
              //             getProportionateScreenWidth(10),
              //           ),
              //           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(
              //             getProportionateScreenWidth(10),
              //           ),
              //           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              //         ),
              //         disabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(
              //             getProportionateScreenWidth(10),
              //           ),
              //           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              //         ),
              //         hintText: AppLocalizations.of(context)!.enterText,
              //         hintStyle: TextStyle(
              //           fontFamily: AppFonts.sansFont400,
              //           fontSize: getProportionalFontSize(16),
              //           color: AppColors.lightTextColor,
              //         ),
              //         errorStyle: TextStyle(
              //           fontSize: getProportionalFontSize(12),
              //           fontFamily: AppFonts.sansFont400,
              //           color: AppColors.redDefault,
              //         ),
              //         contentPadding: EdgeInsets.symmetric(
              //           horizontal: getProportionateScreenWidth(16),
              //           vertical: getProportionateScreenHeight(8),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    // child: ListView.builder(
                    //   padding: EdgeInsets.symmetric(
                    //     vertical: getProportionateScreenHeight(8),
                    //     horizontal: getProportionateScreenWidth(8),
                    //   ),
                    //   shrinkWrap: true,
                    //   itemCount: controller.chatList.length,
                    //   itemBuilder: (context, index) {
                    //     Widget dateTitle = const SizedBox();
                    //
                    //     // if (index < controller.chatList.length - 1) {
                    //     //   DateTime date = DateTime.fromMillisecondsSinceEpoch(controller.chatList[index].timestamp!);
                    //     //   DateTime dateAfter = DateTime.fromMillisecondsSinceEpoch(controller.chatList[index + 1].timestamp!);
                    //     //   if (date.day != dateAfter.day) {
                    //     //     dateTitle = Padding(
                    //     //       padding: EdgeInsets.symmetric(
                    //     //         vertical: getProportionateScreenHeight(10),
                    //     //       ),
                    //     //       child: Text(
                    //     //         DateFormat("dd/MM/yyyy").format(date),
                    //     //         style: TextStyle(
                    //     //           color: Colors.black,
                    //     //           fontSize: getProportionalFontSize(12),
                    //     //         ),
                    //     //       ),
                    //     //     );
                    //     //   }
                    //     // }
                    //
                    //     dynamic timeStamp;
                    //     dynamic time = controller.chatList[index].timestamp;
                    //     if (time is double) {
                    //       time = time.toInt();
                    //     }
                    //     if (index + 1 < controller.chatList.length - 1) {
                    //       timeStamp = controller.chatList[index + 1].timestamp;
                    //
                    //       if (timeStamp is double) {
                    //         timeStamp = timeStamp.toInt();
                    //       }
                    //
                    //       DateTime dateAfter = DateTime.fromMillisecondsSinceEpoch(timeStamp);
                    //       DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
                    //
                    //       if (dateAfter.day != date.day) {
                    //         dateTitle = Padding(
                    //           padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                    //           child: Text(
                    //             DateFormat("dd/MM/yyyy").format(date),
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //               fontSize: getProportionalFontSize(12),
                    //             ),
                    //           ),
                    //         );
                    //       }
                    //     } else {
                    //       dateTitle = Padding(
                    //         padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                    //         child: Text(
                    //           DateFormat('dd/MM/yyyy').format(
                    //             DateTime.fromMillisecondsSinceEpoch(time),
                    //           ),
                    //           style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: getProportionalFontSize(12),
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //
                    //     return Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Center(child: dateTitle),
                    //         controller.chatList[index].userId.toString() == controller.userId
                    //             ? Padding(
                    //                 padding: EdgeInsets.only(
                    //                   top: getProportionateScreenHeight(5),
                    //                   bottom: getProportionateScreenHeight(5),
                    //                   left: MediaQuery.of(context).size.width * .2,
                    //                   right: getProportionateScreenWidth(8),
                    //                 ),
                    //                 child: Container(
                    //                   padding: EdgeInsets.symmetric(
                    //                     horizontal: getProportionateScreenWidth(16),
                    //                     vertical: getProportionateScreenHeight(10),
                    //                   ),
                    //                   decoration: BoxDecoration(
                    //                     color: AppColors.primaryColor.withOpacity(.34),
                    //                     borderRadius: BorderRadius.only(
                    //                       topLeft: Radius.circular(16),
                    //                       topRight: Radius.circular(16),
                    //                       bottomLeft: Radius.circular(16),
                    //                       bottomRight: Radius.circular(16),
                    //                     ),
                    //                   ),
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.end,
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: [
                    //                       Flexible(
                    //                         child: Text(
                    //                           "${controller.chatList[index].message}",
                    //                           style: TextStyle(
                    //                             color: AppColors.blackColor,
                    //                             fontFamily: AppFonts.sansFont500,
                    //                             fontSize: getProportionalFontSize(14),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       Align(
                    //                         alignment: Alignment.bottomRight,
                    //                         child: Text(
                    //                           "${DateFormat("MMM dd, hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(controller.chatList[index].timestamp ?? DateTime.now().millisecondsSinceEpoch))}",
                    //                           style: TextStyle(
                    //                             fontFamily: AppFonts.sansFont400,
                    //                             fontSize: getProportionalFontSize(12),
                    //                             color: AppColors.blackColor.withOpacity(.7),
                    //                           ),
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //               )
                    //             : Padding(
                    //                 padding: EdgeInsets.only(
                    //                   top: getProportionateScreenHeight(5),
                    //                   bottom: getProportionateScreenHeight(5),
                    //                   right: MediaQuery.of(context).size.width * .2,
                    //                   left: getProportionateScreenWidth(8),
                    //                 ),
                    //                 child: Container(
                    //                   padding: EdgeInsets.symmetric(
                    //                     horizontal: getProportionateScreenWidth(16),
                    //                     vertical: getProportionateScreenHeight(10),
                    //                   ),
                    //                   decoration: BoxDecoration(
                    //                     color: Color(0xFFF4F4F4),
                    //                     borderRadius: BorderRadius.only(
                    //                       topLeft: Radius.circular(16),
                    //                       topRight: Radius.circular(16),
                    //                       bottomLeft: Radius.circular(16),
                    //                       bottomRight: Radius.circular(16),
                    //                     ),
                    //                   ),
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: [
                    //                       Flexible(
                    //                         child: Text(
                    //                           "${controller.chatList[index].message}",
                    //                           style: TextStyle(
                    //                             color: AppColors.blackColor,
                    //                             fontFamily: AppFonts.sansFont500,
                    //                             fontSize: getProportionalFontSize(14),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       Align(
                    //                         alignment: Alignment.bottomRight,
                    //                         child: Text(
                    //                           "${DateFormat("MMM dd, hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(controller.chatList[index].timestamp ?? DateTime.now().millisecondsSinceEpoch))}",
                    //                           style: TextStyle(
                    //                             fontFamily: AppFonts.sansFont400,
                    //                             fontSize: getProportionalFontSize(12),
                    //                             color: AppColors.blackColor.withOpacity(.7),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //       ],
                    //     );
                    //   },
                    // ),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(8),
                        horizontal: getProportionateScreenWidth(8),
                      ),
                      shrinkWrap: true,
                      itemCount: controller.chatList.length,
                      itemBuilder: (context, index) {
                        Widget dateTitle = const SizedBox();

                        DateTime currentMessageDate = DateTime.fromMillisecondsSinceEpoch(controller.chatList[index].timestamp!);

                        // If this is the first message or the date is different from the previous message, show the date
                        if (index == 0 || DateTime.fromMillisecondsSinceEpoch(controller.chatList[index - 1].timestamp!).day != currentMessageDate.day) {
                          dateTitle = Padding(
                            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                            child: Text(
                              DateFormat("dd/MM/yyyy").format(currentMessageDate),
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
                            controller.chatList[index].userId.toString() == controller.userId
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      top: getProportionateScreenHeight(5),
                                      bottom: getProportionateScreenHeight(5),
                                      left: MediaQuery.of(context).size.width * .2,
                                      right: getProportionateScreenWidth(8),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getProportionateScreenWidth(16),
                                        vertical: getProportionateScreenHeight(10),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor.withOpacity(.34),
                                        borderRadius: BorderRadius.circular(16),
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
                                              "${DateFormat("MMM dd, hh:mm a").format(currentMessageDate)}",
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
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                      top: getProportionateScreenHeight(5),
                                      bottom: getProportionateScreenHeight(5),
                                      right: MediaQuery.of(context).size.width * .2,
                                      left: getProportionateScreenWidth(8),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getProportionateScreenWidth(16),
                                        vertical: getProportionateScreenHeight(10),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF4F4F4),
                                        borderRadius: BorderRadius.circular(16),
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
                                              "${DateFormat("MMM dd, hh:mm a").format(currentMessageDate)}",
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
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                  controller.chatList.isEmpty || controller.sessionStatus == 'Open'
                      ? Padding(
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
                                    controller.sendMessage(showLoader: true, showDialog: controller.chatList.isEmpty);
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
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16),
                            vertical: getProportionateScreenHeight(12),
                          ),
                          child: Text(
                            "Our social worker will respond to you shortly",
                            style: TextStyle(
                              fontFamily: AppFonts.sansFont600,
                              fontSize: getProportionalFontSize(16),
                            ),
                            textAlign: TextAlign.center,
                          ),
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
