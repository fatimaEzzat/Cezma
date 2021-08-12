import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Models/ProductModel.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestCategoriesList(
    BuildContext context, int currentPage, bool isRefresh) async {
  final _userToken = context.read(userStateManagment).userToken;
  final categoriesState = context.read(categoriesStateManagment);
  // our connection with the statemanagment of categories
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {
      "Content-Type": "application/json",
      "Authorization": _userToken,
      'Charset': 'utf-8'
    },
  );
  if (isRefresh) {
    categoriesState.categories = [
      {"name": "الجميع", "slug": ""}
    ];
  }
  try {
    var response = await dio.get(
      apiCategoriesListUrl,
      queryParameters: {
        "page":currentPage
      },
      options: requestOptions,
    );
    var categories = ProductModel.fromJson(response.data[0]);
    categoriesState.addcategories(categories.data);
    categoriesState.setCurrentCategoryPage(++currentPage);
    categoriesState.setTotalCategoryPages(categories.lastPage);
    return categories;
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "Error", middleText: e.error);
    }
  }
}
