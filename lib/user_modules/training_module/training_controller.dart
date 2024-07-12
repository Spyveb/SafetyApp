import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:distress_app/infrastructure/models/article_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TrainingController extends GetxController {
  int tabIndex = 1;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  ///TODO
  List<String> educationList = [
    "Violence",
    "Drugs",
    "Mental Health",
    "Community",
  ];
  @override
  void onReady() {
    super.onReady();
  }

  List<CategoryModel> categoryList = [];
  List<ArticleModel> articleList = [];
  CategoryModel? categoryModel;

  void getCategoryList() async {
    // LoadingDialog.showLoader();
    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.categoryList,
        null,
        onSendProgress: (count, total) {},
      );

      // LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        categoryList.clear();
        if (response['data'] != null) {
          List list = response['data'];
          if (list.isNotEmpty) {
            for (var category in list) {
              categoryList.add(
                CategoryModel.fromJson(category),
              );
            }
          }
        }
      }
      update();
    } on Dio.DioException catch (e) {
      // LoadingDialog.hideLoader();
      Utils.showToast(e.message ?? "Something went wrong");
      update();
      debugPrint(e.toString());
    } catch (e) {
      // LoadingDialog.hideLoader();
      Utils.showToast("Something went wrong");
      update();
      debugPrint(e.toString());
    }
  }

  void goToArticleList(CategoryModel category, BuildContext context) {
    Get.toNamed(Routes.TRAINING_TOPIC);

    categoryModel = category;
    articleList.clear();
    update();
    if (category.id != null) {
      getCategoryDetails(categoryId: category.id!);
    }
  }

  void getCategoryDetails({required int categoryId, String? search, bool? showLoader = true}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "id": categoryId,
        "search": search ?? '',
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.categoryDetail,
        formData,
        onSendProgress: (count, total) {},
      );

      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }

      if (response['success'] != null && response['success'] == true) {
        articleList.clear();
        if (response['data'] != null) {
          List list = response['data']['articals'];
          if (list.isNotEmpty) {
            for (var article in list) {
              articleList.add(
                ArticleModel.fromJson(article),
              );
            }
          }
        }
      }
      update();
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      update();
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      update();
      debugPrint(e.toString());
    }
  }
}
