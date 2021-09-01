import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/SearchedProductsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestSearchItem(String searchedItem, BuildContext context,
    int currentPage, bool isRefresh) async {
  final userToken = context.read(userStateManagment).userToken;
  final _state = context.read(searchedItemsStateManagement);
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": userToken,
      'Charset': 'utf-8'
    },
  );
  try {
    _state.setIsSearching();
    var response = await dio.get(
      apiSearchUrl,
      queryParameters: {
        "search": searchedItem,
      },
      options: requestOptions,
    );
    if (isRefresh) {
      _state.clearSearchedItems();
    }
    _state.addToSearchedItems(response.data["data"]);
    print(_state.searchedItems);
    // _state.currentSearchedItemTotalPages = orders.lastPage;
    // _state.currentSearchedItemPage = ++currentPage;
    _state.setIsSearching();
  } on Exception catch (e) {
    if (e is DioError) {
      _state.setIsSearching();
      Get.defaultDialog(title: "خطأ", middleText: "لا يوجد نتاثج");
    }
  }
}
