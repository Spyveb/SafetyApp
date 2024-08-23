import 'package:flutter/material.dart';

import '../imports.dart';

class CustomCasesList extends StatelessWidget {
  final String? caseNo, date, status, firstName, lastName, location, city, requestStatus;
  final bool? showSOS;
  const CustomCasesList(
      {super.key, this.caseNo, this.date, this.status, this.firstName, this.lastName, this.location, this.city, this.requestStatus, this.showSOS});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(8),
        vertical: getProportionateScreenHeight(8),
      ),
      margin: EdgeInsets.only(
        bottom: getProportionateScreenHeight(16),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(16),
          ),
          border: Border.all(
            color: AppColors.blackColor,
          )
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.black54,
          //     spreadRadius: 0,
          //     blurRadius: 8,
          //     offset: Offset(0.0, 4.0),
          //   ),
          // ],
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(125),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.caseNo,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        caseNo ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(125),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.date,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Text(
                      date ?? "",
                      style: TextStyle(
                        fontSize: getProportionalFontSize(14),
                        fontFamily: AppFonts.sansFont400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(125),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.status,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Text(
                      status ?? "-",
                      style: TextStyle(
                        fontSize: getProportionalFontSize(14),
                        fontFamily: AppFonts.sansFont600,
                        color: _statusColor(status ?? 'Pending'),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(125),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.firstName,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        firstName ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(125),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.lastName,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        lastName ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(125),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.location,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        location ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(125),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.city,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        city ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
                requestStatus != null
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              minWidth: getProportionateScreenWidth(125),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.requestStatus,
                              style: TextStyle(
                                fontSize: getProportionalFontSize(14),
                                fontFamily: AppFonts.sansFont600,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              requestStatus ?? "",
                              style: TextStyle(
                                fontSize: getProportionalFontSize(14),
                                fontFamily: AppFonts.sansFont600,
                                color: _reqStatusColor(requestStatus ?? 'Pending'),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: showSOS == true
                ? Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    preferBelow: false,
                    showDuration: Duration(seconds: 4),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(8),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(8),
                    ),
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: getProportionalFontSize(12),
                      fontFamily: AppFonts.sansFont400,
                    ),
                    // exitDuration: Duration(seconds: 3),
                    message: "You have a SOS emergency case",
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                        vertical: getProportionateScreenHeight(8),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.redDefault,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        'SOS',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: AppFonts.sansFont500,
                          fontSize: getProportionalFontSize(10),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          )
          // CommonButton(
          //   width: getProportionateScreenWidth(125),
          //   padding: EdgeInsets.symmetric(
          //     horizontal: getProportionateScreenWidth(4),
          //     vertical: getProportionateScreenHeight(4),
          //   ),
          //   radius: 50,
          //   textStyle: TextStyle(
          //     color: Colors.white,
          //     fontSize: getProportionalFontSize(13),
          //     fontFamily: AppFonts.sansFont600,
          //   ),
          //   onPressed: () {},
          //   text: "View case",
          // )
        ],
      ),
    );
  }

  _statusColor(String s) {
    Color color = AppColors.blackColor;
    if (s == 'Open') {
      color = Colors.green;
    } else if (s == 'Close') {
      color = AppColors.redDefault;
    } else if (s == 'Pending') {
      color = AppColors.primaryColor;
    }
    return color;
  }

  _reqStatusColor(String s) {
    Color color = AppColors.primaryColor;
    if (s == 'Accept') {
      color = Colors.green;
    } else if (s == 'Decline') {
      color = AppColors.redDefault;
    } else if (s == 'Pending') {
      color = AppColors.primaryColor;
    } else {
      color = AppColors.blackColor;
    }
    return color;
  }
}
