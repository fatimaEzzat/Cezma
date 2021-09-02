import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/ProductsState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestRatings({required BuildContext context, required int id}) async {
  // our connection with the statemanagment of categories
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
  );

  try {
    final response = await dio.get(
      apiProductsUrl + "/" + id.toString() + "/rates",
      options: requestOptions,
    );
    context
        .read(productsStateManagment)
        .putRates(response.data["data"]["rates"]);
  } catch (e) {
    if (e is DioError) {
      Get.defaultDialog(
          title: "خطا", middleText: "حدث خطا في تحميل بينات المنتج");
    }
  }
}
