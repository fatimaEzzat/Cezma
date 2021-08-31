import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/OrdersState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestUserOrders(
    int pageNumber, BuildContext context, bool isRefresh) async {
  final _userToken = context.read(userStateManagment).userToken;
  final _state = context.read(ordersStateManagment);
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );

  if (isRefresh) {
    // to be used later in refreshing the data if requested.
    _state.orders.clear();
  }
  print(apiUserInfoUrl + "/" + "orders");
  try {
    final response = await dio.get(
      apiUserInfoUrl + "/" + "orders",
      options: requestOptions,
      queryParameters: {"page": pageNumber},
    );

    _state.addOrders(response.data["data"]["orders"]["data"]);
    _state.setCurrentOrderPage(++pageNumber);
    _state.setTotalOrderPages(response.data["data"]["orders"]["last_page"]);
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.error);
    }
  }
}
