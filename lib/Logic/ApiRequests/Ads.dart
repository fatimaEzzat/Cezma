// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:test_store/Logic/StateManagment/HomePageStateManagment/HomeSlidersState.dart';
// import 'package:test_store/Logic/StateManagment/UserState.dart';
// import 'package:test_store/Variables/EndPoints.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// Future requestAds(int pageNumber, BuildContext context, bool isRefresh) async {
//   final _userToken = context.read(userStateManagment).userToken;
//   final state = context.read(homeSlidersStateManagment);
//   Dio dio = Dio();
//   Options requestOptions = Options(
//     responseType: ResponseType.plain,
//     headers: {
//       "Content-Type": "application/json",
//       "Authorization": _userToken,
//       'Charset': 'utf-8'
//     },
//   );
//   if (isRefresh) {
//     state.ads.clear();
//   }
//   try {
//     var response = await dio.get(apiHomeSliders, options: requestOptions);
//     state.addSliders(response.data["data"]);
//   } on Exception catch (e) {
//     if (e is DioError) {
//       Get.defaultDialog(title: "Error", middleText: e.error);
//     }
//   }
// }
