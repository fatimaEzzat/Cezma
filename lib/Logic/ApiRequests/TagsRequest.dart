import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/TagsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestTags(
    BuildContext context, bool isRefresh, int currentPage) async {
  Dio dio = Dio();
  final _userToken = context.read(userStateManagment).userToken;
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );
  if (isRefresh) {
    context.read(tagsStateManagment).tags.clear();
  }
  try {
    final response = await dio.get(apiTagUrl,
        options: requestOptions, queryParameters: {"page": currentPage});
    context
        .read(tagsStateManagment)
        .addTagsToList(response.data["data"]["tags"]["data"]);
    context.read(tagsStateManagment).tagsCurrentPage = ++currentPage;
    context.read(tagsStateManagment).tagsLastPage =
        response.data["data"]["tags"]["last_page"];
  } catch (e) {
    Get.defaultDialog(title: "خطأ", middleText: e.toString());
  }
}
