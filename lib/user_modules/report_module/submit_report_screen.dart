import 'dart:io';
import 'dart:ui';

import 'package:distress_app/imports.dart';
import 'package:distress_app/user_modules/home_module/place_auto_complete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../packages/location_geocoder/location_geocoder.dart';
import '../home_module/place_auto_complete_response.dart';

class SubmitReportScreen extends GetView<ReportController> {
  const SubmitReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GetBuilder<ReportController>(
          dispose: (state) {
            controller.timer?.cancel();

            controller.record.cancel();
          },
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(4),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: AppColors.blackColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(26),
                          left: getProportionateScreenWidth(8),
                          top: getProportionateScreenHeight(4),
                          bottom: getProportionateScreenHeight(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.report,
                              style: TextStyle(
                                fontSize: getProportionalFontSize(32),
                                color: themeProvider.textThemeColor,
                                fontFamily: AppFonts.sansFont600,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.submitYourInfo,
                              style: TextStyle(
                                fontSize: getProportionalFontSize(16),
                                color: themeProvider.lightTextThemeColor,
                                fontFamily: AppFonts.sansFont400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24),
                      vertical: getProportionateScreenHeight(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField<String>(
                            value: controller.reportTypeValue,
                            iconSize: 28,
                            iconEnabledColor: AppColors.blackColor,
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              // suffixIcon: IconButton(
                              //   onPressed: () {},
                              //   icon: Icon(
                              //     Icons.arrow_drop_down_outlined,
                              //     size: 36,
                              //     color: AppColors.blackColor,
                              //   ),
                              // ),
                              errorMaxLines: 2,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(10),
                                ),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(10),
                                ),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(10),
                                ),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(10),
                                ),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              ),
                              hintText: "",
                              hintStyle: TextStyle(
                                fontFamily: AppFonts.sansFont400,
                                fontSize: getProportionalFontSize(14),
                                color: AppColors.textFieldGreyColor,
                              ),
                              errorStyle: TextStyle(
                                fontSize: getProportionalFontSize(12),
                                fontFamily: AppFonts.sansFont400,
                                color: AppColors.redDefault,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(4),
                                vertical: getProportionateScreenHeight(8),
                              ),
                            ),
                            items: controller.reportType.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontFamily: AppFonts.sansFont400,
                                    fontSize: getProportionalFontSize(16),
                                    color: AppColors.lightTextColor,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.reportTypeValue = value ?? controller.reportType.first;
                              controller.update();
                            },
                          ),
                        ),
                        Container(
                          width: SizeConfig.deviceWidth,
                          margin: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(14),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(8),
                            horizontal: getProportionateScreenWidth(14),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(10),
                            ),
                            border: Border.all(color: AppColors.primaryColor, width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.filesAndInformation,
                                style: TextStyle(
                                  fontFamily: AppFonts.sansFont400,
                                  fontSize: getProportionalFontSize(13),
                                  color: AppColors.lightTextColor,
                                ),
                              ),
                              controller.informationText.trim().isNotEmpty
                                  ? Container(
                                      width: SizeConfig.deviceWidth,
                                      padding: EdgeInsets.symmetric(
                                        vertical: getProportionateScreenHeight(8),
                                        horizontal: getProportionateScreenWidth(14),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: getProportionateScreenHeight(14),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor.withOpacity(.6),
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenWidth(10),
                                        ),
                                      ),
                                      // child: Column(
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //     Text(
                                      //       Constants.LoremIpsum,
                                      //       style: TextStyle(
                                      //         fontFamily: AppFonts.interFont500,
                                      //         fontSize: getProportionalFontSize(12),
                                      //         color: AppColors.blackColor,
                                      //       ),
                                      //     ),
                                      //     Align(
                                      //       alignment: Alignment.bottomRight,
                                      //       child: Text(
                                      //         "9:00",
                                      //         style: TextStyle(
                                      //           fontFamily: AppFonts.interFont500,
                                      //           fontSize: getProportionalFontSize(12),
                                      //           color: AppColors.blackColor,
                                      //         ),
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      child: Text(
                                        controller.informationText,
                                        style: TextStyle(
                                          fontFamily: AppFonts.interFont500,
                                          fontSize: getProportionalFontSize(12),
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              ListView.builder(
                                itemCount: controller.pickedFiles.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  File file = controller.pickedFiles[index];
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: getProportionateScreenHeight(8),
                                      horizontal: getProportionateScreenWidth(14),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      vertical: getProportionateScreenHeight(4),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        getProportionateScreenWidth(10),
                                      ),
                                      border: Border.all(color: AppColors.primaryColor, width: 2),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _fileName(file.path),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: AppFonts.sansFont700,
                                              fontSize: getProportionalFontSize(16),
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          AppImages.registrationSuccess,
                                          height: getProportionateScreenHeight(36),
                                          width: getProportionateScreenWidth(36),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: controller.submitSearchLocationController,
                          readOnly: true,
                          onTap: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PlaceAutoCompleteScreen(),
                                ));

                            if (result is GoogleMapPlaceModel) {
                              controller.submitSearchLocationController.text = result.description ?? '';

                              if (controller.submitSearchLocationController.text.isNotEmpty) {
                                var address =
                                    await LocatitonGeocoder(Constants.kGoogleApiKey, lang: 'en').findAddressesFromQuery(
                                  controller.submitSearchLocationController.text,
                                );
                                // var initialLatLong = LatLng(
                                //     address.first.coordinates.latitude ?? 0, address.first.coordinates.longitude ?? 0);
                                controller.submitCity = address.first.locality;
                                controller.submitLatitude = address.first.coordinates.latitude;
                                controller.submitLongitude = address.first.coordinates.longitude;
                              }
                            } else if (result is Address) {
                              var address = result as Address;
                              controller.submitSearchLocationController.text = address.addressLine ?? '';
                              controller.submitCity = address.locality;
                              controller.submitLatitude = address.coordinates.latitude;
                              controller.submitLongitude = address.coordinates.longitude;
                            }
                            controller.update();
                          },
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(14),
                            color: AppColors.blackColor,
                          ),
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            isDense: true,
                            suffixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(4),
                                vertical: getProportionateScreenHeight(4),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(10),
                                vertical: getProportionateScreenHeight(4),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFD9D9D9).withOpacity(.6),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.location_on_rounded,
                                size: 24,
                                color: AppColors.blackColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10),
                              ),
                              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10),
                              ),
                              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10),
                              ),
                              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10),
                              ),
                              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                            ),
                            hintText: AppLocalizations.of(context)!.searchLocation,
                            hintStyle: TextStyle(
                              fontFamily: AppFonts.sansFont400,
                              fontSize: getProportionalFontSize(14),
                              color: AppColors.lightTextColor,
                            ),
                            errorStyle: TextStyle(
                              fontSize: getProportionalFontSize(12),
                              fontFamily: AppFonts.sansFont400,
                              color: AppColors.redDefault,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(16),
                              vertical: getProportionateScreenHeight(8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(14),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(16),
                            right: getProportionateScreenWidth(8),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(10),
                            ),
                            border: Border.all(color: AppColors.primaryColor, width: 2),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.alertFriends,
                                  style: TextStyle(
                                    fontFamily: AppFonts.sansFont400,
                                    fontSize: getProportionalFontSize(16),
                                    color: AppColors.lightTextColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(38),
                                width: getProportionateScreenWidth(50),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CommonSwitch(
                                    value: controller.alertFriendsValue,
                                    onChanged: (value) {
                                      controller.switchAddFriendsValue(value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(8),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(16),
                            right: getProportionateScreenWidth(8),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(10),
                            ),
                            border: Border.all(color: AppColors.primaryColor, width: 2),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.reportAnonymously,
                                  style: TextStyle(
                                    fontFamily: AppFonts.sansFont400,
                                    fontSize: getProportionalFontSize(16),
                                    color: AppColors.lightTextColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(38),
                                width: getProportionateScreenWidth(50),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CommonSwitch(
                                    value: controller.reportAnonymouslyValue,
                                    onChanged: (value) {
                                      controller.switchReportAnonymouslyValue(value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: getProportionateScreenWidth(4),
                        //     vertical: getProportionateScreenHeight(4),
                        //   ),
                        //   margin: EdgeInsets.symmetric(
                        //     horizontal: getProportionateScreenWidth(4),
                        //     vertical: getProportionateScreenHeight(4),
                        //   ),
                        //   child: Icon(
                        //     Icons.add,
                        //     size: 24,
                        //     color: AppColors.blackColor,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFFD9D9D9).withOpacity(.6),
                        //     shape: BoxShape.circle,
                        //   ),
                        // ),

                        SizedBox(
                          width: getProportionateScreenWidth(24),
                        ),
                        Expanded(
                          child: TextFormField(
                            readOnly: controller.isRecording,
                            controller: controller.informationController,
                            style: TextStyle(
                              fontFamily: AppFonts.sansFont400,
                              fontSize: getProportionalFontSize(16),
                              color: AppColors.blackColor,
                            ),
                            maxLines: 4,
                            // expands: true,
                            minLines: 1,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              isDense: true,
                              prefixIcon: controller.isRecording == true
                                  ? const Icon(
                                      Icons.mic_none_outlined,
                                      size: 23,
                                      color: AppColors.blackColor,
                                    )
                                  : GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        controller.pickFiles();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: getProportionateScreenWidth(4),
                                          vertical: getProportionateScreenHeight(4),
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          horizontal: getProportionateScreenWidth(10),
                                          vertical: getProportionateScreenHeight(4),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFD9D9D9).withOpacity(.6),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: 24,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ),
                              suffixIcon: controller.isRecording == true
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.stopRecording();
                                      },
                                      child: const Icon(
                                        Icons.stop_circle_outlined,
                                        size: 24,
                                        color: AppColors.blackColor,
                                      ),
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            if (controller.isRecording == false) {
                                              controller.startRecording();
                                            } else {
                                              controller.stopRecording();
                                            }
                                          },
                                          child: Icon(
                                            Icons.mic_none_outlined,
                                            size: 24,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(6),
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () async {
                                            ImagePicker imagePicker = ImagePicker();
                                            XFile? xFile = await imagePicker.pickImage(
                                                source: ImageSource.camera, imageQuality: 50);
                                            if (xFile != null) {
                                              controller.pickedFiles.add(File(xFile.path));
                                              controller.update();
                                            }
                                          },
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 24,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(16),
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            controller.informationText = controller.informationController.text;
                                            controller.update();
                                            controller.informationController.clear();
                                          },
                                          child: const Icon(
                                            Icons.send,
                                            size: 24,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(8),
                                        ),
                                      ],
                                    ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(10),
                                ),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(10),
                                ),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(10),
                                ),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(10),
                                ),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              ),
                              hintText: controller.isRecording == true
                                  ? controller.getFormattedTime(controller.recordTime)
                                  : AppLocalizations.of(context)!.enterText,
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
                                vertical: getProportionateScreenHeight(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(24),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(18),
                        vertical: getProportionateScreenHeight(14),
                      ),
                      child: CommonButton(
                        width: SizeConfig.deviceWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(18),
                          vertical: getProportionateScreenHeight(18),
                        ),
                        onPressed: () {
                          if (controller.informationText.trim().isEmpty) {
                            Utils.showToast('Please enter information');
                          } else if (controller.reportTypeValue.isEmpty) {
                            Utils.showToast('Please select report type');
                          } else if (controller.submitLatitude == null || controller.submitLongitude == null) {
                            Utils.showToast('Please select location');
                          } else {
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
                                    child: GetBuilder<ReportController>(
                                      builder: (controller) {
                                        return Container(
                                          width: SizeConfig.deviceWidth! * .85,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: getProportionateScreenWidth(16),
                                            vertical: getProportionateScreenHeight(60),
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
                                                AppLocalizations.of(context)!.sendReportAlert,
                                                style: TextStyle(
                                                    fontFamily: AppFonts.sansFont500,
                                                    fontSize: getProportionalFontSize(16),
                                                    color: AppColors.blackColor),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: getProportionateScreenHeight(24),
                                              ),
                                              CheckboxListTile(
                                                controlAffinity: ListTileControlAffinity.leading,
                                                contentPadding: EdgeInsets.zero,
                                                dense: true,
                                                title: Text(
                                                  AppLocalizations.of(context)!.wouldYouLikeToSpeakAProfessional,
                                                  style: TextStyle(
                                                      fontFamily: AppFonts.sansFont400,
                                                      fontSize: getProportionalFontSize(12),
                                                      color: AppColors.lightTextColor),
                                                ),
                                                value: controller.speakToProfessional,
                                                onChanged: (value) {
                                                  controller.checkSpeakToProfessional(value ?? false);
                                                },
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
                                                      onPressed: () {
                                                        Get.back();
                                                        // if (controller.informationText.trim().isEmpty) {
                                                        //   Utils.showToast('Please enter information');
                                                        // } else if (controller.reportTypeValue.isEmpty) {
                                                        //   Utils.showToast('Please select report type');
                                                        // } else {
                                                        //   controller.submitReport();
                                                        // }
                                                        controller.submitReport();
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
                          }
                        },
                        text: AppLocalizations.of(context)!.submit,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  String _fileName(String path) {
    return path.split('/').last;
  }
}

class AudioVisualizer extends StatelessWidget {
  AudioVisualizer({required this.amplitude}) {
    ///limit amplitude to [decibleLimit]
    double db = amplitude ?? -30;
    if (db == double.infinity || db < -30) {
      db = -30;
    }
    if (db > 0) {
      db = 0;
    }

    ///this expression converts [db] to [0 to 1] double
    range = 1 - (db * (1 / -30));
    print(range);
  }
  final double? amplitude;
  final double maxHeight = 200;

  late final double range;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildBar(0.15),
        buildBar(0.5),
        buildBar(0.25),
        buildBar(0.75),
        buildBar(0.5),
        buildBar(1),
        buildBar(0.75),
        buildBar(0.5),
        buildBar(0.25),
        buildBar(0.5),
        buildBar(0.15),
      ],
    );
  }

  buildBar(double intensity) {
    double barHeight = range * maxHeight * intensity;
    if (barHeight < 5) {
      barHeight = 5;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 100,
        ),
        height: 150,
        width: 5,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppColors.policeDarkBlueColor,
              spreadRadius: 1,
              offset: Offset(1, 1),
            ),
            BoxShadow(
              color: AppColors.redDefault,
              spreadRadius: 1,
              offset: Offset(-1, -1),
            ),
          ],
        ),
      ),
    );
  }
}
