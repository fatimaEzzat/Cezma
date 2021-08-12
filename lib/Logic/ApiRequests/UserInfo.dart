import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Models/UserModel.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestUserInfo(String? userToken, BuildContext context) async {
  Options requestOptions = Options(
    responseType: ResponseType.plain,
    headers: {"Authorization": userToken, "Content-Type": "application/json"},
  );
  Dio dio = Dio();

  var response = await dio.get(apiUserInfo, options: requestOptions);
  if (response.statusCode == 200) {
    if (response.data.toString().contains("html")) {
      Get.snackbar("Error", "Invalid Token");
    } else {
      Map<String, dynamic> body = jsonDecode(response.data);
      var userInfo = UserModel.fromJson(body["user"]);
      context.read(userStateManagment).setUserInfo(userInfo);
      return userInfo;
    }
  }
}
