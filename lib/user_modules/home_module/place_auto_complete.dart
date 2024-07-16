import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:distress_app/user_modules/home_module/place_auto_complete_response.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../packages/location_geocoder/location_geocoder.dart';

class PlaceAutoCompleteScreen extends StatefulWidget {
  const PlaceAutoCompleteScreen({super.key});

  @override
  State<PlaceAutoCompleteScreen> createState() => _PlaceAutoCompleteScreenState();
}

class _PlaceAutoCompleteScreenState extends State<PlaceAutoCompleteScreen> {
  List<GoogleMapPlaceModel> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: AppBarPlacesAutoCompleteTextField(
          onChanged: (value) {
            placeAutoComplete(value);
          },
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(26),
          ),
          onTap: () async {
            LoadingDialog.showLoader();
            FocusManager.instance.primaryFocus?.unfocus();
            Position currentPosition = await determineCurrentPosition();

            print("${currentPosition.latitude} ${currentPosition.longitude}");
            var address = await LocatitonGeocoder(Constants.kGoogleApiKey, lang: 'en').findAddressesFromCoordinates(
              Coordinates(currentPosition.latitude, currentPosition.longitude),
            );
            LoadingDialog.hideLoader();

            Navigator.pop(context, address.first);
          },
          title: Text(
            AppLocalizations.of(context)!.useCurrentLocation,
            style: TextStyle(
              fontFamily: AppFonts.sansFont400,
              fontSize: getProportionalFontSize(16),
              color: AppColors.blackColor,
            ),
          ),
          leading: Icon(
            Icons.my_location,
            size: 24,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(8),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: result.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              GoogleMapPlaceModel prediction = result[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(26),
                ),
                leading: Icon(
                  Icons.location_on,
                  size: 24,
                ),
                title: Text(
                  prediction.description!,
                  style: TextStyle(
                    fontFamily: AppFonts.sansFont400,
                    fontSize: getProportionalFontSize(16),
                    color: AppColors.blackColor,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, prediction);
                },
              );
            },
          ),
        )
      ]),
    );
  }

  Dio.Dio dio = Dio.Dio();

  Future<void> placeAutoComplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com", 'maps/api/place/autocomplete/json', {"input": query, "key": Constants.kGoogleApiKey});

    Dio.Response response = await dio.getUri(uri);

    if (response.statusCode == 200) {
      result.clear();
      if (response.data['status'] == 'OK' && response.data['predictions'] != null) {
        List data = response.data['predictions'];
        if (data.isNotEmpty) {
          for (var place in data) {
            result.add(GoogleMapPlaceModel.fromJson(place));
          }
        }
      }
    }
    setState(() {});
  }

  Future<Position> determineCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Utils.showAlertDialog(
        context: navState.currentContext!,
        bar: true,
        title: AppLocalizations.of(context)!.permissionRequired,
        description: AppLocalizations.of(context)!.locationPermissionRequiredSOS,
        buttons: [
          TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: Text(
              AppLocalizations.of(context)!.openSetting,
            ),
          ),
        ],
      );
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}

class AppBarPlacesAutoCompleteTextField extends StatefulWidget {
  final InputDecoration? textDecoration;
  final TextStyle? textStyle;
  final Function(String)? onChanged;

  const AppBarPlacesAutoCompleteTextField({Key? key, this.textDecoration, this.textStyle, this.onChanged})
      : super(key: key);

  @override
  _AppBarPlacesAutoCompleteTextFieldState createState() => _AppBarPlacesAutoCompleteTextFieldState();
}

class _AppBarPlacesAutoCompleteTextFieldState extends State<AppBarPlacesAutoCompleteTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(top: 4.0),
        child: TextField(
          onChanged: widget.onChanged,
          autofocus: true,
          style: widget.textStyle ?? _defaultStyle(),
          decoration: widget.textDecoration ?? _defaultDecoration(AppLocalizations.of(context)!.search),
        ));
  }

  InputDecoration _defaultDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Theme.of(context).brightness == Brightness.light ? Colors.white30 : Colors.black38,
      hintStyle: TextStyle(
        color: Theme.of(context).brightness == Brightness.light ? Colors.black38 : Colors.white30,
        fontSize: 16.0,
      ),
      border: InputBorder.none,
    );
  }

  TextStyle _defaultStyle() {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black.withOpacity(0.9)
          : Colors.white.withOpacity(0.9),
      fontSize: 16.0,
    );
  }
}
