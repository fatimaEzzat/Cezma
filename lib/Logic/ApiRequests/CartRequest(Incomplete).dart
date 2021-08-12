// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:test_store/Logic/StateManagment/UserState.dart';
// import 'package:test_store/Models/CartModel.dart';
// import 'package:test_store/Variables/EndPoints.dart';

// Future requestCart(BuildContext context, isRefresh) async {
//   final _userToken = context.read(userStateManagment).userToken;
//   Dio dio = Dio();
//   Options requestOptions = Options(
//     responseType: ResponseType.plain,
//     headers: {
//       "Content-Type": "application/json",
//       "Authorization": _userToken,
//       'Charset': 'utf-8'
//     },
//   );
//   if (isRefresh) {}
//   try {
//     var response = await dio.get(
//       apiCart,
//       options: requestOptions,
//     );
//     var test = CartModel.fromJson(response.data);
//   } on Exception catch (e) {
//     if (e is DioError) {
//       Get.defaultDialog(title: "خطأ", middleText: "حدث خطأ");
//     } else {
//       print(e);
//     }
//   }
// }
