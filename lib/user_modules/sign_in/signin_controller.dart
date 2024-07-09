import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../imports.dart';

class SignInController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    if (kDebugMode) {
      userNameController.text = "test";
      passwordController.text = "Test@123";
    }
    super.onInit();
  }

  loginMethod() async {
    LoadingDialog.showLoader();
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "username": userNameController.text,
        "password": passwordController.text,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.signIn,
        formData,
        passToken: false,
        onSendProgress: (count, total) {},
      );

      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null) {
          if (response['data']['user'] != null) {
            UserModel userModel = UserModel.fromJson(response['data']['user']);
            await saveUserData(userModel);
            LoadingDialog.hideLoader();
            Get.offAllNamed(Routes.DASHBOARD);
          }
        }
      } else {
        LoadingDialog.hideLoader();
        Utils.showToast(response['message'] ?? "Login Failed");
      }
    } on Dio.DioException catch (e) {
      LoadingDialog.hideLoader();
      Utils.showToast(e.message ?? "Something went wrong");
      update();
      debugPrint(e.toString());
    } catch (e) {
      LoadingDialog.hideLoader();
      Utils.showToast("Something went wrong");
      update();
      debugPrint(e.toString());
    }
  }

  Future<void> saveUserData(UserModel userModel) async {
    await StorageService().writeSecureData(Constants.userId, userModel.id.toString());
    await StorageService().writeSecureData(Constants.userName, userModel.username ?? "");
    await StorageService().writeSecureData(Constants.firstName, userModel.firstName ?? "");
    await StorageService().writeSecureData(Constants.lastName, userModel.lastName ?? "");
    await StorageService().writeSecureData(Constants.profileImage, userModel.profileImage ?? "");
    await StorageService().writeSecureData(Constants.email, userModel.email ?? "");
    await StorageService().writeSecureData(Constants.accessToken, userModel.token ?? "");
  }

  // d.Dio dio = d.Dio();
  // List<List<dynamic>> _data = [];
  // void loadCSV() async {
  //   final rawData = await rootBundle.loadString("assets/svgs/test.csv");
  //   List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
  //
  //   _data = listData;
  //   print(_data);
  //
  //   Map<String, dynamic> req = {};
  //   for (var item in _data) {
  //     String governorate_id = '', name_en, name_ar;
  //
  //     name_en = item[0];
  //     name_ar = item[2];
  //     if (item[1].toString().contains('Ahmadi Governorate')) {
  //       governorate_id = "484a8900-393c-11ef-9a67-29c0f0cc894d";
  //     } else if (item[1].toString().contains('Al Asimah Governorate')) {
  //       governorate_id = "56d59560-3a99-11ef-8e41-b9ed8cbf2979";
  //     } else if (item[1].toString().contains('Capital Governorate')) {
  //       governorate_id = "5deb6550-3a99-11ef-8e41-b9ed8cbf2979";
  //     } else if (item[1].toString().contains('Farwaniya Governorate')) {
  //       governorate_id = "65fab070-3a99-11ef-8e41-b9ed8cbf2979";
  //     } else if (item[1].toString().contains('Hawalli Governorate')) {
  //       governorate_id = "6afe9050-3a99-11ef-8e41-b9ed8cbf2979";
  //     } else if (item[1].toString().contains('Jahra Governorate')) {
  //       governorate_id = "710b2da0-3a99-11ef-8e41-b9ed8cbf2979";
  //     } else if (item[1].toString().contains('Mubarak Al-Kabeer Governorate')) {
  //       governorate_id = "76246a40-3a99-11ef-8e41-b9ed8cbf2979";
  //     }
  //
  //     print("name_en----${name_en} , name_ar----${name_ar} , governorate_id----${governorate_id}");
  //
  //     d.FormData formData = d.FormData.fromMap({
  //       'name_en': name_en,
  //       'name_ar': name_ar,
  //       'governorate_id': governorate_id,
  //     });
  //     Map<String, String> headersData = {
  //       "accept": 'application/json',
  //       "language": 'en',
  //       "Authorization":
  //           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc4MTI1ODAwLWYzNTItMTFlZS05ZGM3LTk5NWE5MzFiNGY3MCIsImVtYWlsIjoiIiwiaWF0IjoxNzIwMTYzMjg4LCJleHAiOjE3MjAyNDk2ODh9.pJ_rl0I9DcTT9a-zrxynl-FIxuIASc6yB4qgCwbvODc',
  //     };
  //
  //     print(formData);
  //     print(headersData);
  //     await dio.post('http://51.112.65.231:3002/area/add',
  //         data: encryptRequest(formData), options: d.Options(headers: headersData));
  //   }
  //
  //   // d.FormData formData = d.FormData.fromMap({
  //   //   'name_en': 'Shamiya',
  //   //   'name_ar': 'الشامية',
  //   //   'governorate_id': '5deb6550-3a99-11ef-8e41-b9ed8cbf2979',
  //   // });
  //   // Map<String, String> headersData = {
  //   //   "accept": 'application/json',
  //   //   "language": 'en',
  //   //   "Authorization":
  //   //       'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc4MTI1ODAwLWYzNTItMTFlZS05ZGM3LTk5NWE5MzFiNGY3MCIsImVtYWlsIjoiIiwiaWF0IjoxNzIwMTYzMjg4LCJleHAiOjE3MjAyNDk2ODh9.pJ_rl0I9DcTT9a-zrxynl-FIxuIASc6yB4qgCwbvODc',
  //   // };
  //   // await dio.post('http://51.112.65.231:3002/area/add',
  //   //     data: encryptRequest(formData), options: d.Options(headers: headersData));
  // }
  //
  // d.FormData encryptRequest(d.FormData formData) {
  //   d.FormData returnFormData = formData;
  //
  //   Map<String, dynamic> data = convertFormDataFieldsToMap(formData);
  //
  //   String plainText = jsonEncode(data);
  //   final key = encrypt.Key.fromBase64('Ot89kQekeGKYFWNGSTB/sGxW694+st5Oe+g206bNttk=');
  //   final iv = encrypt.IV.fromBase64(
  //     '+lurlFM3+uNyuW/qoJ+ZVg==',
  //   );
  //   final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  //
  //   final encrypted = encrypter.encrypt(plainText, iv: iv);
  //   returnFormData.fields.clear();
  //   returnFormData.fields.add(MapEntry('data', encrypted.base64));
  //
  //   return returnFormData;
  // }
  //
  // Map<String, dynamic> convertFormDataFieldsToMap(d.FormData formData) {
  //   return formData.fields.fold<Map<String, dynamic>>({}, (map, field) {
  //     map[field.key] = field.value;
  //
  //     return map;
  //   });
  // }
}
