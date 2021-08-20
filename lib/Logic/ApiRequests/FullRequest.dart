import 'package:flutter/material.dart';
import 'package:test_store/Logic/ApiRequests/HomeRequests/HomeAdsRequest.dart';
import 'package:test_store/Logic/ApiRequests/HomeRequests/HomeProductsRequest.dart';
import 'package:test_store/Logic/ApiRequests/HomeRequests/HomeSliderRequest.dart';
import 'package:test_store/Logic/ApiRequests/HomeRequests/HomeStoresRequest.dart';
import 'package:test_store/Logic/ApiRequests/StoresRequest.dart';
import 'RequestsExport.dart';

Future firstSuperRequest(
    {required String? userToken,
    required String? userId,
    required int pageNumber,
    required BuildContext context}) async {
  await requestHomeProducts(
      context: context, isRefresh: false, pageNumber: pageNumber);
  await requestHomeSliders(
      context: context, isRefresh: false, pageNumber: pageNumber);
  await requestHomeAds(context: context, isRefresh: false, pageNumber: pageNumber);
  await requestHomeStores(context: context, isRefresh: false, pageNumber: pageNumber);
  // await requestUserOrders(pageNumber, context, true);
  // await requestProducts(userToken, context, pageNumber, true);
  // await requestAds(pageNumber, context, true);
  // await requestShowCountry(userToken, context);
  await requestUserInfo(userToken, context);
  await requestCategoriesList(context, true);
  // await requestCategoryProducts("", 1, context, true);
  // await requestStores(
  //     context: context, isRefresh: true, pageNumber: 1, userToken: userToken);
}
