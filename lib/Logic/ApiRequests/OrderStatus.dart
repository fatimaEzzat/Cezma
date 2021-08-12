import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestOrderStatus(String userToken, String id) async {
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.plain,
    headers: {
      "Content-Type": "application/json",
      "Authorization": userToken,
      'Charset': 'utf-8'
    },
  );
  try {
    var response = await dio.get(
      apiOrderStatus + id + "/status",
      options: requestOptions,
    );

    if (response.statusCode == 200) {
      if (response.data.contains("html")) {
        Get.snackbar("Error", "Invalid Token");
      } else {
        var body = jsonDecode(response.data);
        return body;
      }
    }
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.error);
    }
  }
}
