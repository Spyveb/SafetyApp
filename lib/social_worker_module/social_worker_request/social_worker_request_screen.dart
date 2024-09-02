import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialWorkerRequestScreen extends GetView<SocialWorkerRequestController> {
  const SocialWorkerRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialWorkerRequestController>(
      init: SocialWorkerRequestController(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          controller.getRequestList(search: '', showLoader: false);
        });
      },
      global: true,
      autoRemove: false,
      builder: (controller) {
        return Scaffold(
          // backgroundColor: Color(0xFFD8D8D8),
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.requests,
              style: TextStyle(
                fontSize: getProportionalFontSize(22),
                fontFamily: AppFonts.sansFont600,
                color: Colors.black,
              ),
            ),
            centerTitle: false,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: controller.requestList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.requestList.length,
                          itemBuilder: (context, index) {
                            SocialWorkerRequestModel request = controller.requestList[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                border: Border.all(color: AppColors.blackColor.withOpacity(.5), width: .5),
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(4),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(4),
                              ),
                              child: ListTile(
                                tileColor: AppColors.whiteColor,
                                // onTap: () async {
                                //   controller.receiverName = request.user?.firstName;
                                //   controller.sessionId = request.id;
                                //   await Get.toNamed(Routes.SOCIAL_WORKER_CHAT);
                                //   controller.receiverName = null;
                                //   controller.sessionId = null;
                                // },
                                dense: true,
                                contentPadding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(2),
                                  bottom: getProportionateScreenHeight(2),
                                  left: getProportionateScreenWidth(12),
                                  right: getProportionateScreenWidth(2),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(4),
                                  ),
                                ),
                                title: Text(
                                  "${request.user?.firstName} ${request.user?.lastName}",
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontFamily: AppFonts.sansFont500,
                                    fontSize: getProportionalFontSize(16),
                                  ),
                                ),
                                subtitle: request.status == 'Pending'
                                    ? Row(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              visualDensity: VisualDensity(
                                                vertical: -1,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                  getProportionateScreenWidth(4),
                                                ),
                                              ),
                                              backgroundColor: Colors.green,
                                            ),
                                            onPressed: () {
                                              if (request.id != null) {
                                                controller.updateRequestStatus(
                                                    id: request.id!, status: AppLocalizations.of(context)!.accept, userName: request.user?.firstName);
                                              }
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!.accept,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: AppFonts.sansFont600,
                                                fontSize: getProportionalFontSize(12),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: getProportionateScreenWidth(8),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              visualDensity: VisualDensity(
                                                vertical: -1,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                  getProportionateScreenWidth(4),
                                                ),
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () {
                                              if (request.id != null) {
                                                controller.updateRequestStatus(
                                                    id: request.id!, status: AppLocalizations.of(context)!.decline, userName: request.user?.firstName);
                                              }
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!.decline,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: AppFonts.sansFont600,
                                                fontSize: getProportionalFontSize(12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : null,
                                trailing: request.status == 'Open'
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          // visualDensity: VisualDensity(vertical: -3, horizontal: -3),
                                          onPressed: () async {
                                            controller.receiverName = request.user?.firstName;
                                            controller.sessionId = request.id;
                                            await Get.toNamed(Routes.SOCIAL_WORKER_CHAT);
                                            controller.receiverName = null;
                                            controller.sessionId = null;
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF2B2829),
                                            size: 18,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            AppLocalizations.of(context)!.noRequest,
                            maxLines: 2,
                            style: TextStyle(
                              color: AppColors.blackColor.withOpacity(.7),
                              fontFamily: AppFonts.sansFont400,
                              fontSize: getProportionalFontSize(14),
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
