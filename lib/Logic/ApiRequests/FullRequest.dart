import 'package:flutter/material.dart';
import 'package:test_store/Logic/ApiRequests/StoresRequest.dart';
import 'RequestsExport.dart';

Future firstSuperRequest(
    {required String? userToken,
    required String? userId,
    required int pageNumber,
    required BuildContext context}) async {
  // await requestUserOrders(pageNumber, context, true);
  await requestProducts(userToken, context, pageNumber, true);
  // await requestAds(pageNumber, context, true);
  // await requestShowCountry(userToken, context);
  // await requestUserInfo(userToken, context);
  // await requestCategoriesList(context, pageNumber, true);
  // await requestCategoryProducts("", 1, context, true);
  // await requestStores(
  //     context: context, isRefresh: true, pageNumber: 1, userToken: userToken);
}
