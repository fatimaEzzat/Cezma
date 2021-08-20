import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/OrdersState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Models/ProductModel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestUserOrders(
    int pageNumber, BuildContext context, bool isRefresh) async {
  final _userToken = context.read(userStateManagment).userToken;
  final _userId = context.read(userStateManagment).userId.toString();
  final _state = context.read(ordersStateManagment);
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
    // to be used later in refreshing the data if requested.
    _state.orders = [];
  }
  try {
    final response = await dio.get(
      apiOrdesrUrl + _userId,
      options: requestOptions,
      queryParameters: {"page": pageNumber},
    );
    if (response.statusCode == 200) {
      if (response.data.toString().contains("html")) {
        Get.snackbar("Error", "Invalid Token");
      } else {
        Map<String, dynamic> body = jsonDecode(response.data);
        var orders = ProductModel.fromJson(body);
        _state.addOrders(orders.data);
        _state.setCurrentOrderPage(++pageNumber);
        _state.setTotalOrderPages(orders.lastPage);
        return orders;
      }
    }
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.error);
    }
  }
}
