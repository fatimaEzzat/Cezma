import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/WishListRequests/WishListRequest.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Logic/StateManagment/WishListState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future requestAddToWishList(BuildContext context, Map product) async {
  final _userToken = context.read(userStateManagment).userToken;
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );
  context.read(wishListtateManagment).addRealTimeItemToWishList(product);
  Map info = {"product_id": product["id"]};
  try {
    await dio.post(
      apiWishListUrl,
      data: info,
      options: requestOptions,
    );
    await requestWishList(context, true);
  } on Exception catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: e.message);
    }
  }
}
