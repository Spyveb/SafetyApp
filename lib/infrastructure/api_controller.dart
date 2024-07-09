// Importing necessary packages and files

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:distress_app/imports.dart';
import 'package:flutter/foundation.dart';

// API Provider class for making API calls
class ApiProvider {
  late Dio dio;

  ApiProvider() {
    dio = Dio();
  }

  Future<dynamic> postAPICall(String url, FormData? formData,
      {bool passToken = true,
      Function(int, int)? onSendProgress,
      Map<String, String>? headers,
      bool passLanguage = true}) async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      String? accessToken = await StorageService().readSecureData(Constants.accessToken);

      Map<String, String> headersData = {
        "accept": 'application/json',
      };
      if (passLanguage) {
        headersData.addAll({
          "Accept-Language": AppLocalizations.of(navState.currentContext!)!.localeName,
        });
      }
      if (headers != null) {
        headersData.addAll(headers);
      }
      if (passToken) {
        if (accessToken != null) {
          headersData.addAll({
            "Authorization": "Bearer $accessToken",
          });
          debugPrint("token === $accessToken");
        }
      }

      // if (formData != null && formData.fields.isNotEmpty) {
      //   print(formData.fields);
      //   formData = encryptRequest(formData);
      // }

      var responseJson;
      try {
        final response = await dio
            .post(url,
                data: formData ?? {},
                options: Options(
                  headers: headersData,
                ),
                onSendProgress: onSendProgress)
            .timeout(
              const Duration(seconds: 50),
            );

        print("response -- ${response.statusCode}");
        responseJson = await _response(response);
        // if (responseJson != null) {
        //   responseJson = decryptResponse(responseJson);
        // }
        if (kDebugMode) {
          log("RESPONSE === $responseJson");
        }
      } on SocketException {
        throw FetchDataException(AppLocalizations.of(navState.currentContext!)!.noInternetConnection);
      } on TimeoutException {
        throw FetchDataException(AppLocalizations.of(navState.currentContext!)!.somethingWentWrong);
      } on DioException catch (e) {
        print(e);
        LoadingDialog.hideLoader();
        if (e.response != null && e.response!.statusCode == 401) {
          // Utils.showCustomDialog(
          //   context: navState.currentContext!,
          //   title: "Authorization Error",
          //   description: "You are not authorized to access this application, Please login again.",
          //   buttons: [
          //     TextButton(
          //       style: ButtonStyle(
          //         overlayColor: MaterialStateProperty.all(
          //           AppColors.primaryColor.withOpacity(.1),
          //         ),
          //       ),
          //       onPressed: () async {
          //         await StorageService().deleteAllSecureData();
          //
          //         Navigator.pushNamedAndRemoveUntil(navState.currentContext!, AppRoute.startUpRoute, (route) => false);
          //       },
          //       child: Text(
          //         "Ok",
          //         style: TextStyle(
          //             color: AppColors.primaryColor,
          //             fontSize: getProportionalFontSize(14),
          //             fontFamily: AppFonts.font400),
          //       ),
          //     ),
          //   ],
          // );
          // await StorageService().deleteAllSecureData();
          // Navigator.pushNamed(navState.currentContext!, AppRoute.dashBoardPageRoute);
          // Navigator.pushNamed(navState.currentContext!, AppRoute.startUpRoute);
        }
      }
      return responseJson;
    } else {
      Utils.showToast(AppLocalizations.of(navState.currentContext!)!.noInternetConnection);
      return;
    }
  }

  Future<dynamic> getAPICall(
    String url, {
    Map<String, dynamic>? queryParam,
    bool passLanguage = true,
    bool passToken = true,
    Map<String, String>? headers,
  }) async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      if (kDebugMode) {
        debugPrint("URL === $url");
        debugPrint("BODY === $queryParam");
      }

      String? accessToken = await StorageService().readSecureData(Constants.accessToken);

      Map<String, String> headersData = {
        "accept": 'application/json',
      };

      if (passLanguage) {
        headersData.addAll({"Accept-Language": AppLocalizations.of(navState.currentContext!)!.localeName});
      }
      if (headers != null) {
        headersData.addAll(headers);
      }
      if (passToken) {
        if (accessToken != null) {
          headersData.addAll({
            "Authorization": "Bearer $accessToken",
          });
          debugPrint("token === $accessToken");
        }
      }

      // Map<String, String>? headersData;
      // if (passLanguage) {
      //   headersData.addAll({"language": AppLocalizations.of(navState.currentContext!)!.localeName});
      // }
      // if (accessToken != null) {
      //   headersData = {
      //     "Authorization": "Bearer $accessToken",
      //     "accept": 'application/json',
      //     "language": AppLocalizations.of(navState.currentContext!)!.localeName,
      //   };
      //   debugPrint("token === $accessToken");
      // }

      var responseJson;
      try {
        final response = await dio
            .get(
              url,
              queryParameters: queryParam,
              // data: queryParam,
              options: Options(
                headers: headersData,
              ),
            )
            .timeout(Duration(seconds: 15));

        responseJson = await _response(response);
        // if (responseJson != null) {
        //   responseJson = decryptResponse(responseJson);
        // }

        if (kDebugMode) {
          print("RESPONSE === $responseJson");
        }
      } on SocketException {
        throw FetchDataException(AppLocalizations.of(navState.currentContext!)!.noInternetConnection);
      } on TimeoutException {
        throw FetchDataException(AppLocalizations.of(navState.currentContext!)!.somethingWentWrong);
      } on DioException catch (e) {
        LoadingDialog.hideLoader();
        if (e.response != null && e.response!.statusCode == 401) {
          // Utils.showCustomDialog(
          //   context: navState.currentContext!,
          //   title: "Authorization Error",
          //   description: "You are not authorized to access this application, Please login again.",
          //   buttons: [
          //     TextButton(
          //       style: ButtonStyle(
          //         overlayColor: MaterialStateProperty.all(
          //           AppColors.primaryColor.withOpacity(.1),
          //         ),
          //       ),
          //       onPressed: () async {
          //         await StorageService().deleteAllSecureData();
          //
          //         Navigator.pushNamedAndRemoveUntil(navState.currentContext!, AppRoute.startUpRoute, (route) => false);
          //       },
          //       child: Text(
          //         "Ok",
          //         style: TextStyle(
          //             color: AppColors.primaryColor,
          //             fontSize: getProportionalFontSize(14),
          //             fontFamily: AppFonts.font400),
          //       ),
          //     ),
          //   ],
          // );
          // await StorageService().deleteAllSecureData();
          // Navigator.pushNamed(navState.currentContext!, AppRoute.dashBoardPageRoute);
          // Navigator.pushNamed(navState.currentContext!, AppRoute.startUpRoute);
        }
      }
      return responseJson;
    } else {
      Utils.showToast(AppLocalizations.of(navState.currentContext!)!.noInternetConnection);
      return;
    }
  }

  Future<dynamic> putAPICall(String url, FormData? formData,
      {bool passToken = true,
      Function(int, int)? onSendProgress,
      Map<String, String>? headers,
      bool passLanguage = true}) async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      String? accessToken = await StorageService().readSecureData(Constants.accessToken);

      Map<String, String> headersData = {
        "accept": 'application/json',
      };

      if (passLanguage) {
        headersData.addAll({"Accept-Language": AppLocalizations.of(navState.currentContext!)!.localeName});
      }
      if (headers != null) {
        headersData.addAll(headers);
      }
      if (passToken) {
        if (accessToken != null) {
          headersData.addAll({
            "Authorization": "Bearer $accessToken",
          });
          debugPrint("token === $accessToken");
        }
      }
      // if (formData != null && formData.fields.isNotEmpty) {
      //   formData = encryptRequest(formData);
      // }
      var responseJson;
      try {
        final response = await dio
            .put(url,
                data: formData ?? {},
                options: Options(
                  headers: headersData,
                ),
                onSendProgress: onSendProgress)
            .timeout(
              Duration(seconds: 50),
            );

        print(response);
        responseJson = await _response(response);
        // if (responseJson != null) {
        //   responseJson = decryptResponse(responseJson);
        // }

        if (kDebugMode) {
          print("RESPONSE === $responseJson");
        }
      } on SocketException {
        throw FetchDataException(AppLocalizations.of(navState.currentContext!)!.noInternetConnection);
      } on TimeoutException {
        throw FetchDataException(AppLocalizations.of(navState.currentContext!)!.somethingWentWrong);
      } on DioException catch (e) {
        LoadingDialog.hideLoader();
        if (e.response != null && e.response!.statusCode == 401) {
          // Utils.showCustomDialog(
          //   context: navState.currentContext!,
          //   title: "Authorization Error",
          //   description: "You are not authorized to access this application, Please login again.",
          //   buttons: [
          //     TextButton(
          //       style: ButtonStyle(
          //         overlayColor: MaterialStateProperty.all(
          //           AppColors.primaryColor.withOpacity(.1),
          //         ),
          //       ),
          //       onPressed: () async {
          //         await StorageService().deleteAllSecureData();
          //
          //         Navigator.pushNamedAndRemoveUntil(navState.currentContext!, AppRoute.startUpRoute, (route) => false);
          //       },
          //       child: Text(
          //         "Ok",
          //         style: TextStyle(
          //             color: AppColors.primaryColor,
          //             fontSize: getProportionalFontSize(14),
          //             fontFamily: AppFonts.font400),
          //       ),
          //     ),
          //   ],
          // );

          // await StorageService().deleteAllSecureData();
          // Navigator.pushNamed(navState.currentContext!, AppRoute.dashBoardPageRoute);
          // Navigator.pushNamed(navState.currentContext!, AppRoute.startUpRoute);
        }
      }
      return responseJson;
    } else {
      Utils.showToast(AppLocalizations.of(navState.currentContext!)!.noInternetConnection);
      return;
    }
  }

  dynamic _response(Response response) async {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 400:
        LoadingDialog.hideLoader();
        throw BadRequestException(response.data.toString());
      case 401:
        var responseJson = response.data;
        LoadingDialog.hideLoader();
        // Utils.showCustomDialog(
        //   context: navState.currentContext!,
        //   title: "Authorization Error",
        //   description: "You are not authorized to access this application, Please login again.",
        //   buttons: [
        //     TextButton(
        //       style: ButtonStyle(
        //         overlayColor: MaterialStateProperty.all(
        //           AppColors.primaryColor.withOpacity(.1),
        //         ),
        //       ),
        //       onPressed: () async {
        //         await StorageService().deleteAllSecureData();
        //
        //         Navigator.pushNamedAndRemoveUntil(navState.currentContext!, AppRoute.loginRoute, (route) => false);
        //       },
        //       child: Text(
        //         "Ok",
        //         style: TextStyle(
        //             color: AppColors.primaryColor, fontSize: getProportionalFontSize(14), fontFamily: AppFonts.font400),
        //       ),
        //     ),
        //   ],
        // );
        // await StorageService().deleteAllSecureData();
        // Navigator.pushNamed(navState.currentContext!, AppRoute.dashBoardPageRoute);
        // Navigator.pushNamed(navState.currentContext!, AppRoute.startUpRoute);

        return responseJson;
      case 422:
        LoadingDialog.hideLoader();
        var responseJson = response.data;
        return responseJson;
      case 403:
        LoadingDialog.hideLoader();
        throw UnauthorisedException(response.data);
      case 500:
      default:
        LoadingDialog.hideLoader();
        throw FetchDataException(
            '${AppLocalizations.of(navState.currentContext!)!.errorOccurredWhileCommunicatingWithServer}: ${response.statusCode}');
    }
  }
}

Map<String, dynamic> convertFormDataFieldsToMap(FormData formData) {
  return formData.fields.fold<Map<String, dynamic>>({}, (map, field) {
    map[field.key] = field.value;

    return map;
  });
}

// Custom Exception classes for API error handling
class CustomException implements Exception {
  final message;
  final prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message]) : super(message, 'Error During Communication: ');
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, 'Invalid Input: ');
}
