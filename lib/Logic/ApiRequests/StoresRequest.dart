import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/StoresState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestStores(
    {required BuildContext context,
    required pageNumber,
    required isRefresh,
    required category}) async {
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
  );
  if (isRefresh) {
    context.read(storesStateManagment).stores.clear();
  }
  try {
    var response = await dio.get(apiStoresListUrl,
        options: requestOptions, queryParameters: {"category": category});
    // context.read(storesStateManagment).setCurrentStoresPage(++pageNumber);
    // context
    //     .read(storesStateManagment)
    //     .setLastStoresPage(response.data["data"]["stores"]["last_page"]);
    context
        .read(storesStateManagment)
        .addToStoresList(response.data["data"]["stores"]["data"]);
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.error);
    }
  }
}
