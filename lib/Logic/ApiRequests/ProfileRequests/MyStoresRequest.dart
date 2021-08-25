import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Logic/StateManagment/MyStoresState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestMyStore(
    String? userToken, BuildContext context, int currentPage) async {

  Options requestOptions = Options(
    headers: {
      "Authorization": "Bearer " + userToken!,
      "Content-Type": "application/json"
    },
  );
  try {
    Dio dio = Dio();
    var response =
        await dio.get(apiUserInfoUrl + "/stores", options: requestOptions);
 
    context
        .read(myStoresStateManagment)
        .addToStores(response.data["data"]["stores"]["data"]);
    context.read(myStoresStateManagment).myStoresCurrentPage = ++currentPage;
    context.read(myStoresStateManagment).myStoresLastPage =
        response.data["data"]["stores"]["last_page"];
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.toString());
    }
  }
}
