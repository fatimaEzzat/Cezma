import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/CartRequests/CartRequest.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestAddToCart(BuildContext context, int productId) async {
  final _userToken = context.read(userStateManagment).userToken;
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );
  Map info = {"product_id": productId, "qnt": 1};
  try {
    var response = await dio.post(
      apiCartUrl,
      data: info,
      options: requestOptions,
    );
    await requestCart(context, true, 1);
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.message);
    }
  }
}
