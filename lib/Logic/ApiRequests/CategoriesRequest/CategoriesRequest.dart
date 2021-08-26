import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestCategoriesList(BuildContext context, bool isRefresh) async {
  final categoriesState = context.read(categoriesStateManagment);
  // our connection with the statemanagment of categories
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
  );
  if (isRefresh) {
    categoriesState.categories.clear();
  }
  try {
    var response = await dio.get(
      apiCategoriesListUrl,
      options: requestOptions,
    );
    categoriesState.categories.addAll(response.data["data"]["category"]);
    categoriesState.allCategories
        .addAll(context.read(categoriesStateManagment).categories);
    context.read(categoriesStateManagment).categories.forEach((element) {
      categoriesState.allCategories.addAll(element["sub"]);
    });
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "Error", middleText: e.error);
    }
  }
}
