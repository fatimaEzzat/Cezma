import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestSubCategoryProducts(BuildContext context) async {
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {
      "Content-Type": "application/json",
      // "Authorization": _userToken,
      'Charset': 'utf-8'
    },
  );
  try {
    var response =
        await dio.post(apiSubCategoriesProductsUrl, options: requestOptions);
    context
        .read(categoriesStateManagment)
        .addSubCategoriesProducts(response.data["data"]);
  } catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "Error", middleText: e.error);
    }
  }
}
