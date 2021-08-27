import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestNewMessage(BuildContext context, int id, String message) async {
  final _userToken = context.read(userStateManagment).userToken;
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );

  try {
    var response = await dio.get(
      apiMessagesUrl,
      options: requestOptions,
    );
    print(response.data);
  } catch (e) {
    if (e is DioError) {
      if (e.response!.statusCode == 422) {
      } else {
        Get.defaultDialog(title: "خطأ", middleText: "حدث خطأ");
      }
    }
  }
}
