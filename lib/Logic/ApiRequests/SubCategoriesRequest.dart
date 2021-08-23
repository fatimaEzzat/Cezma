import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestSubCategories(BuildContext context, int id) async {
  final _userToken = context.read(userStateManagment).userToken;
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {
      "Content-Type": "application/json",
      // "Authorization": _userToken,
      'Charset': 'utf-8'
    },
  );
  try {
    var response = await dio.post(apiSubCategoriesUrl,
        options: requestOptions, queryParameters: {"parent_id": id});
    return response;
    // context
    //     .read(categoriesStateManagment)
    //     .addSubCategories(response.data["data"]);
  } catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "Error", middleText: e.error);
    }
  }
}
