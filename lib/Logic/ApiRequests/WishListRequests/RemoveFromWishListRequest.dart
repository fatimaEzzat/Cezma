import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/WishListRequests/WishListRequest.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Logic/StateManagment/WishListState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestRemoveFromWishList(BuildContext context, int itemId) async {
  final _userToken = context.read(userStateManagment).userToken;
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );
  context.read(wishListtateManagment).removeFromWishList(itemId);
  try {
    await dio.delete(
      apiWishListUrl + "/" + itemId.toString() + "/delete",
      options: requestOptions,
    );
    await requestWishList(context, true);
  } on Exception catch (e) {
    if (e is DioError) {}
  }
}
