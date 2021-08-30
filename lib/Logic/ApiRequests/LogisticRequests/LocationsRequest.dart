import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestLocation({
  required BuildContext context,
}) async {
  // our connection with the statemanagment of categories
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
  );
  try {
    final response = await dio.get(
      apiCountries,
      options: requestOptions,
    );
    context.read(countriesStateManagment).countries =
        response.data["data"]["locations"];
  } catch (e) {
    Get.snackbar("خطا", "فشل الاتصال");
  }
}
