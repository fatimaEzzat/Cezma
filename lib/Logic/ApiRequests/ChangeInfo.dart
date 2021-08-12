import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/ApiRequests/UserInfo.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestChangeInfo(
    String? userToken, Map changeInfoData, BuildContext context) async {
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json", "Authorization": userToken},
  );
  Dio dio = Dio();
  try {
    await dio.post(apiEditProfileUrl,
        data: changeInfoData, options: requestOptions);
    await requestUserInfo(userToken, context);
  } on Exception catch (e) {
    Get.snackbar("Error", e.toString());
  }
}
