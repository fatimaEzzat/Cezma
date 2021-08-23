import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/HomePageStateManagment/HomeStoresState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestHomeStores(
    {required BuildContext context,
    required bool isRefresh,
    required int pageNumber}) async {
  // our connection with the statemanagment of categories
  Dio dio = Dio();
  Options requestOptions = Options(
    headers: {
      "Content-Type": "application/json",
      // "Authorization": _userToken,
      'Charset': 'utf-8'
    },
  );
  if (isRefresh) {
    context.read(homeStoresStateManagment).homeStores.clear();
  }
  try {
    final response = await dio.get(
      apiHomeStoresUrl,
      options: requestOptions,
    );

    context
        .read(homeStoresStateManagment)
        .homeStores
        .addAll(response.data["data"]);
  } catch (e) {
    print(e);
  }
}
