import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/HomeState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestHome({
  required BuildContext context,
}) async {
  // our connection with the statemanagment of categories
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
  );

  try {
    final response = await dio.get(
      apiHomeUrl,
      options: requestOptions,
    );
    context.read(homeStateManagment).getHomeData(response.data);
  } catch (e) {
    if (e is DioError) {
      Get.defaultDialog(
          title: "خطا", middleText: "حدث خطا في تحميل الصفحة الرئيسية");
    }
  }
}
