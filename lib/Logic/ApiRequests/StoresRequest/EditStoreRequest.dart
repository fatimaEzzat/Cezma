import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/ProfileRequests/MyStoresRequest.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestEditStore(
    {required storeInfo,
    required BuildContext context,
    required storeName}) async {
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
     await dio.post(apiStoresListUrl + "/" + storeName,
        options: requestOptions, data: storeInfo);
    await requestMyStore(context, 1, true);
    Get.defaultDialog(
        title: "تم",
        middleText: "تم تعديل المتجر بنجاح",
        textConfirm: "تاكيد",
        buttonColor: violet,
        barrierDismissible: false,
        onConfirm: () {
          Get.back();
          Get.back();
          Get.back();
        },
        confirmTextColor: Colors.white);
  } catch (e) {
    if (e is DioError) {
      if (e.response!.statusCode == 500) {
        Get.defaultDialog(title: "خطا", middleText: "خطأ, حاول اسم مستخدم اخر");
      } else {
        Get.defaultDialog(
            title: "خطا", middleText: e.response!.data.toString());
      }
    }
  }
}
