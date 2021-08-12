import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/ProductsState.dart';
import 'package:test_store/Models/ProductModel.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestProducts(String? userToken, BuildContext contextm, int pagenumber,
    bool isRefresh) async {
  final productsState = contextm.read(productsStateManagment);
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {
      "Content-Type": "application/json",
      "Authorization": userToken,
      'Charset': 'utf-8'
    },
  );
  if (isRefresh) {
    productsState.products = [];
  }
  try {
    var response = await dio.get(
      apiProductsUrl,
      queryParameters: {"page": pagenumber},
      options: requestOptions,
    );
    if (response.statusCode == 200) {
      if (response.data.contains("html")) {
        Get.snackbar("Error", "Invalid Token");
      } else {
        var products =
            response.data.map((e) => ProductModel.fromJson(e)).toList();
        productsState.addproducts(products[0].data);
        productsState.setcurrentpages(++pagenumber);
        productsState.setTotalProductsPages(products[0].lastPage);
        return products;
      }
    }
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.error);
      print("ss");
    }
  }
}
