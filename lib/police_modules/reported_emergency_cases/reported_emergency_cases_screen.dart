import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportedEmgCasesScreen extends GetView<ReportedEmgCasesController> {
  const ReportedEmgCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<ReportedEmgCasesController>(
          init: ReportedEmgCasesController(),
          initState: (state) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              controller.getSOSEmergencyList(search: '');
              // controller.showSOSDialog(context, ReportCaseModel());
            });
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
                              AppLocalizations.of(context)!.reportedEmergencyCases,
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
                      TextFormField(
                        onChanged: (value) {
                          controller.getSOSEmergencyList(search: value, showLoader: false);
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenWidth(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(getProportionateScreenWidth(30)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16),
                            vertical: getProportionateScreenHeight(8),
                          ),
                          suffixIcon: const Icon(
                            Icons.search,
                          ),
                          hintText: AppLocalizations.of(context)!.searchCases,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                    ],
                  ),
                  Expanded(
                    child: controller.sosReportsList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.sosReportsList.length,
                            itemBuilder: (context, index) {
                              ReportCaseModel report = controller.sosReportsList[index];
                              return CustomCasesList(
                                caseNo: "${report.id}",
                                status: "${report.status == 0 ? 'Open' : 'Closed'}",
                                firstName: "${report.firstName ?? '-'}",
                                lastName: "${report.lastName ?? '-'}",
                                date: "${Utils.displayDateFormat(
                                  report.updatedAt ?? DateTime.now().toString(),
                                )}",
                                location: "${report.location ?? '-'}",
                                city: "${report.city ?? '-'}",
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
