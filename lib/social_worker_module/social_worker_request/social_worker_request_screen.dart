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
          controller.getRequestList(search: '');
        });
      },
      global: true,
      autoRemove: false,
      builder: (controller) {
        return Scaffold(
          // backgroundColor: Color(0xFFD8D8D8),
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
                                  getProportionateScreenWidth(8),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(12),
                                vertical: getProportionateScreenHeight(4),
                              ),
                              child: ListTile(
                                tileColor: AppColors.whiteColor,
                                onTap: () {
                                  controller.receiverName = request.user?.firstName;
                                  Get.toNamed(Routes.SOCIAL_WORKER_CHAT);
                                },
                                dense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenHeight(6),
                                  horizontal: getProportionateScreenWidth(12),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(8),
                                  ),
                                ),
                                title: Text(
                                  "${request.user?.firstName} ${request.user?.lastName}",
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontFamily: AppFonts.sansFont500,
                                    fontSize: getProportionalFontSize(18),
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
                                                controller.updateRequestStatus(id: request.id!, status: 'Accept');
                                              }
                                            },
                                            child: Text(
                                              "Accept",
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
                                                controller.updateRequestStatus(id: request.id!, status: 'Decline');
                                              }
                                            },
                                            child: Text(
                                              "Decline",
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
                              ),
                            );
                          },
                        )
                      : SizedBox(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
