import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/StoresState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> requestCategoryStores(String categoryName, int currentPage,
    BuildContext context, bool isRefresh) async {
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
  );
  if (isRefresh) {
    context.read(storesStateManagment).stores.clear();
  }
  try {
    var response = await dio.get(
      apiCategoriesListUrl + "/" + categoryName,
      queryParameters: {"page": currentPage},
      options: requestOptions,
    );
    context
        .read(storesStateManagment)
        .addToStoresList(response.data["data"]["stores"]["data"]);
  } on Exception catch (e) {
    if (e is DioError) {
      Get.snackbar("خطأ", "حدث خطأ");
    }
  }
}
