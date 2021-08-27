import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/ChatsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestChats(BuildContext context, int currentPage, bool refresh) async {
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
    context.read(chatsStateManagment).chats.clear();
  }
  try {
    var response = await dio.get(
      apiMessagesUrl,
      queryParameters: {"page": currentPage},
      options: requestOptions,
    );
    context
        .read(chatsStateManagment)
        .addToChats(response.data["data"]["chats"]["data"]);
    context.read(chatsStateManagment).currentChatsPage = ++currentPage;
    print(context.read(chatsStateManagment).lastChatsPage =
        response.data["data"]["chats"]["last_page"]);
    context.read(chatsStateManagment).lastChatsPage =
        response.data["data"]["chats"]["last_page"];
  } catch (e) {
    if (e is DioError) {
      if (e.response!.statusCode == 422) {
      } else {
        Get.defaultDialog(title: "خطأ", middleText: "محاثة" + "حدث خطأ");
      }
    }
  }
}
