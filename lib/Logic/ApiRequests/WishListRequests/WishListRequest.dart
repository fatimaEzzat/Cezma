import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Logic/StateManagment/WishListState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestWishList(BuildContext context, isRefresh) async {
  final _userToken = context.read(userStateManagment).userToken;
  final wishListState = context.read(wishListtateManagment);
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );

  try {
    var response = await dio.get(
      apiWishListUrl,
      options: requestOptions,
    );
    if (isRefresh) {
      wishListState.cleanWishList();
    }
    wishListState.addToWishList(response.data["data"]["wishlist"]);
  } catch (e) {
    if (e is DioError) {
      Get.defaultDialog(title: "خطأ", middleText: "حدث خطأ");
    } else {
      print(e);
    }
  }
}
