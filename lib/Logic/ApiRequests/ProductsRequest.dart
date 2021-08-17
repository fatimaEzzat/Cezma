import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/ProductsState.dart';
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

    var products = response.data["data"]["data"];
    print(
      products[0]["images"][0]
          .replaceAll("https://cezma.test", "http://fc23e3d0e899.ngrok.io"),
    );
    productsState.addproducts(products);
    productsState.setcurrentpages(++pagenumber);
    productsState.setTotalProductsPages(response.data["data"]["last_page"]);
    return products;
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.error);
    }
  }
}
