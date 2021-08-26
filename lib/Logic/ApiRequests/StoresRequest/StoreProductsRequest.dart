import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/StoresState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestStoreProducts(
    {required bool isRefresh,
    required BuildContext context,
    required String userName,
    required currentPage}) async {
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
  );
  if (isRefresh) {
    context.read(storesStateManagment).storeProducts.clear();
  }
  try {
    var response = await dio.get(
        apiStoresListUrl + "/" + userName + "/products",
        options: requestOptions,
        queryParameters: {"page": currentPage});
    context.read(storesStateManagment).currentStoreProductsPage = currentPage;
    context.read(storesStateManagment).lastStoreProductsPage =
        (response.data["data"]["products"]["last_page"]);
    context
        .read(storesStateManagment)
        .addStoreProducts(response.data["data"]["products"]["data"]);
    return response;
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.error);
    }
  }
}
