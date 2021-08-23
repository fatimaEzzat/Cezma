import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Models/UserModel.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestUserInfo(String? userToken, BuildContext context) async {
  Options requestOptions = Options(
    headers: {
      "Authorization": "Bearer 19|9fy2fRn8fAFFIk1rZtfyY9ytrI528NXbKQRzE9r0",
      "Content-Type": "application/json"
    },
  );
  try {
    Dio dio = Dio();
    var response = await dio.get(apiUserInfoUrl, options: requestOptions);
    var userInfo = UserModel.fromJson(response.data["data"]);
    context.read(userStateManagment).setUserInfo(userInfo);
  } on Exception catch (e) {
    Get.defaultDialog(title: "خطأ", middleText: e.toString());
  }
}
