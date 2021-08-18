import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Logic/StateManagment/HomePageStateManagment/AdsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Models/ProductModel.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestAds(int pageNumber, BuildContext context, bool isRefresh) async {
  final _userToken = context.read(userStateManagment).userToken;
  final state = context.read(adsStateManagment);
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.plain,
    headers: {
      "Content-Type": "application/json",
      "Authorization": _userToken,
      'Charset': 'utf-8'
    },
  );
  if (isRefresh) {
    state.ads.clear();
  }
  try {
    var response = await dio.get(apiAdsUrl,
        options: requestOptions, queryParameters: {"page": pageNumber});
    if (response.statusCode == 200) {
      if (response.data.contains("html")) {
        Get.snackbar("Error", "Invalid Token");
      } else {
        var body = jsonDecode(response.data);
        var ads = ProductModel.fromJson(body[0]);
        state.addAds(ads.data);
        state.setCurrentAdsPage(++pageNumber);
        state.setTotalAdsPages(ads.lastPage);
        return ads;
      }
    }
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "Error", middleText: e.error);
    }
  }
}
