import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/ProfileRequests/MyStoresRequest.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestAddStoreProduct({
  required productInfo,
  required BuildContext context,
  required String storeName,
}) async {
  final _userToken = context.read(userStateManagment).userToken;
  // our connection with the statemanagment of categories
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );
  try {
    final response = await dio.post(apiStoresListUrl,
        options: requestOptions, data: productInfo);
    print(response.data);
    await requestMyStore(context, 1, true);

    Get.defaultDialog(
        title: "تم",
        middleText: "تم اضافة المنتج بنجاح",
        textConfirm: "تاكيد",
        buttonColor: violet,
        barrierDismissible: false,
        onConfirm: () {
          Get.back();
          Get.back();
        },
        confirmTextColor: Colors.white);
  } catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطا", middleText: e.response!.data.toString());
    }
  }
}
