import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/SearchedProductsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Models/ProductModel.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestSearchProduct(String searchedItem, BuildContext context,
    int currentPage, bool isRefresh) async {
  final userToken = context.read(userStateManagment).userToken;
  final _state = context.read(searchedProductsStateManagement);
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.plain,
    headers: {
      "Content-Type": "application/json",
      "Authorization": userToken,
      'Charset': 'utf-8'
    },
  );
  try {
    _state.setIsSearching();
    var response = await dio.get(
      apiProductsUrl,
      queryParameters: {
        "search": searchedItem,
      },
      options: requestOptions,
    );
    if (response.statusCode == 200) {
      if (response.data.contains("html")) {
        Get.snackbar("Error", "Invalid Token");
      } else {
        var body = jsonDecode(response.data);
        var orders = ProductModel.fromJson(body[0]);
        if (isRefresh) {
          _state.clearSearchedProducts();
        }
        _state.addToSearchedProducts(orders.data);
        _state.currentSearchedProductTotalPages = orders.lastPage;
        _state.currentSearchedProductPage = ++currentPage;
        _state.setIsSearching();
        return orders;
      }
    }
  } on Exception catch (e) {
    if (e is DioError) {
      _state.setIsSearching();
      Get.defaultDialog(title: "خطأ", middleText: "لا يوجد نتاثج");
    }
  }
}
