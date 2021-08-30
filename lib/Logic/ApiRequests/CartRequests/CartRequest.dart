import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestCart(BuildContext context, isRefresh, int currentPage) async {
  final _userToken = context.read(userStateManagment).userToken;
  final _cartState = context.read(cartStateManagment);
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );

  try {
    var response = await dio.get(
      apiCartUrl,
      options: requestOptions,
    );
    if (isRefresh) {
      context.read(cartStateManagment).cleanCart();
    }
    if (response.data["data"].isEmpty) {
      context.read(cartStateManagment).cleanCart();
    } else {
      _cartState.addToCart(response.data["data"]["cart"]["data"]);
      _cartState.currentCartPage = ++currentPage;
      _cartState.lastCartPage = response.data["data"]["cart"]["last_page"];
      List temp = response.data["data"]["cart"]["data"];
      double totalAmount = 0;
      temp.forEach((element) {
        totalAmount += element["total"];
        _cartState.setCartTotalPayment(totalAmount);
      });
    }
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: "حدث خطأ");
    }
  }
}
