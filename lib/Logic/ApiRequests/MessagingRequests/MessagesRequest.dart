import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/MessagesState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestMessages(
    BuildContext context, int currentPage, int id, bool refresh) async {
  final _userToken = context.read(userStateManagment).userToken;
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );
  if (refresh) {
    context.read(messagesStateManagment).messages.clear();
  }
  try {
    var response = await dio.get(
      apiMessagesUrl + "/" + id.toString(),
      options: requestOptions,
    );
    context
        .read(messagesStateManagment)
        .addToMessages(response.data["data"]["chats"]["messages"]["data"]);

    context.read(messagesStateManagment).currentMessagesPage = ++currentPage;
    context.read(messagesStateManagment).lastMessagesPage =
        response.data["data"]["chats"]["messages"]["last_page"];
    return response.data;
  } catch (e) {
    if (e is DioError) {
      if (e.response!.statusCode == 422) {
      } else {
        Get.defaultDialog(title: "خطأ", middleText: "محاثة" + "حدث خطأ");
      }
    }
  }
}
