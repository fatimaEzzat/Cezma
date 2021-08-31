import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/CategoryProductsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> requestCategoryProducts(String categoryName, int currentPage,
    BuildContext context, bool isRefresh) async {
  final _state = context.read(categoryProductsStateManagment);
  final _userToken = context.read(userStateManagment).userToken;
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": _userToken,
      'Charset': 'utf-8'
    },
  );
  if (isRefresh) {
    context.read(categoryProductsStateManagment).categoryProducts = [];
  }
  try {
    var response = await dio.get(
      apiCategoriesListUrl + "/" + categoryName,
      queryParameters: {"page": currentPage},
      options: requestOptions,
    );

    _state.addCategoryProducts(response.data["data"]["products"]["data"]);
    _state.totalCategoryProductsPages =
        response.data["data"]["products"]["last_page"];
    _state.currentCategoryProductsPage = ++currentPage;
  } on Exception catch (e) {
    if (e is DioError) {
      Get.snackbar("خطأ", "حدث خطأ");
    }
  }
}
