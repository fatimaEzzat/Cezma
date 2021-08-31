import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Logic/StateManagment/MyStoresState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestMyStore(
    BuildContext context, int currentPage, bool isRefreshed) async {
  final _userToken = context.read(userStateManagment).userToken;
  Options requestOptions = Options(
    headers: {
      "Authorization": "Bearer " + _userToken!,
      "Content-Type": "application/json"
    },
  );
  if (isRefreshed) {
    context.read(myStoresStateManagment).myStores.clear();
  }
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
