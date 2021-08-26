// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:test_store/Logic/StateManagment/CartState.dart';
// import 'package:test_store/Logic/StateManagment/UserState.dart';
// import 'package:test_store/Variables/EndPoints.dart';

// Future requestWishList(BuildContext context, isRefresh, int currentPage) async {
//   final _userToken = context.read(userStateManagment).userToken;
  
//   Dio dio = Dio();
//   Options requestOptions = Options(
//     headers: {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer " + _userToken!,
//       'Charset': 'utf-8'
//     },
//   );
//   if (isRefresh) {
//     context.read(cartStateManagment).cart.clear();
//   }
//   try {
//     var response = await dio.get(
//       apiCartUrl,
//       options: requestOptions,
//     );
//     _cartState.addToCart(response.data["data"]["cart"]["data"]);
//     _cartState.currentCartPage = ++currentPage;
//     _cartState.lastCartPage = response.data["data"]["cart"]["last_page"];
//   } on Exception catch (e) {
//     if (e is DioError) {
//       Get.defaultDialog(title: "خطأ", middleText: "حدث خطأ");
//     } else {
//       print(e);
//     }
//   }
// }
