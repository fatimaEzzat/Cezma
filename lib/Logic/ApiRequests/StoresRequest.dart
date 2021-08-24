import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/StoresState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestStores(
    {required userToken,
    required BuildContext context,
    required pageNumber,
    required isRefresh,
    required category}) async {
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
    context.read(storesStateManagment).stores.clear();
  }
  try {
    var response = await dio.get(
      apiStoresListUrl,
      options: requestOptions,
    );
    context.read(storesStateManagment).setCurrentStoresPage(++pageNumber);
    context
        .read(storesStateManagment)
        .setLastStoresPage(response.data["data"]["last_page"]);
    context
        .read(storesStateManagment)
        .addToStoresList(response.data["data"]["data"]);
  } on Exception catch (e) {
    if (e is DioError) {
      print("object");
      Get.defaultDialog(title: "خطأ", middleText: e.error);
    }
  }
}
