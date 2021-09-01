import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/MessagingRequests/ChatsRequest.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestNewMessage(BuildContext context, int id, String message) async {
  print(id);
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
    var response = await dio.post(
      apiMessagesUrl,
      data: {"store_id": id, "message": message},
      options: requestOptions,
    );
    await requestChats(context, 1, true);
  } catch (e) {
    if (e is DioError) {
      if (e.response!.statusCode == 422) {
      } else {
        Get.back();
        Get.defaultDialog(title: "خطأ", middleText: "حدث خطأ");
      }
    }
  }
}
