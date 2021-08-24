import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/FilteredProductsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Models/ProductModel.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> requestCategoryProducts(String categoryName, int currentPage,
    BuildContext context, bool isRefresh) async {
  final _state = context.read(filteredProductsStateManagment);
  final _userToken = context.read(userStateManagment).userToken;
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.plain,
    headers: {
      "Content-Type": "application/json",
      "Authorization": _userToken,
      'Charset': 'utf-8'
    },
  );
  if (isRefresh) {
    context.read(filteredProductsStateManagment).filteredProducts = [];
  }
  try {
    var response = await dio.get(
      apiProductsUrl,
      queryParameters: {"page": currentPage, "category": categoryName},
      options: requestOptions,
    );
    var body = jsonDecode(response.data);
    var filtered = ProductModel.fromJson(body[0]);
    _state.addToFilteredProducts(filtered.data);
    _state.totalFilteredCategoriesPages = filtered.lastPage;
    _state.currentFilteredCategoryPage = ++currentPage;
  } on Exception catch (e) {
    if (e is DioError) {
      Get.snackbar("خطأ", "حدث خطأ");
    }
  }
}
