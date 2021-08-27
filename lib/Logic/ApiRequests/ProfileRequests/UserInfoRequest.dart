import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Models/UserModel.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestUserInfo(String? userToken, BuildContext context) async {
  final _userToken = context.read(userStateManagment).userToken;
  Options requestOptions = Options(
    headers: {
      "Authorization": "Bearer " + _userToken!,
      "Content-Type": "application/json"
    },
  );
  try {
    Dio dio = Dio();
    var response = await dio.get(apiUserInfoUrl, options: requestOptions);
    var userInfo = UserModel.fromJson(response.data["data"]);
    context.read(userStateManagment).setUserInfo(userInfo);
    context.read(userStateManagment).userId = response.data["data"]["id"];
  } on Exception catch (e) {
    Get.defaultDialog(title: "خطأ", middleText: e.toString());
  }
}
