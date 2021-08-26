import 'package:flutter/material.dart';
import 'package:test_store/Logic/ApiRequests/CartRequests/CartRequest.dart';
import 'package:test_store/Logic/ApiRequests/HomeRequest.dart';
import 'package:test_store/Logic/ApiRequests/PlansRequest.dart';
import 'package:test_store/Logic/ApiRequests/ProfileRequests/MyStoresRequest.dart';
import 'package:test_store/Logic/ApiRequests/StoresRequest/StoresRequest.dart';
import 'RequestsExport.dart';

Future firstSuperRequest(
    {required String? userToken,
    required String? userId,
    required int pageNumber,
    required BuildContext context}) async {
  await requestHome(context: context, isRefresh: true, pageNumber: pageNumber);
  // await requestPlans(context: context, isRefresh: false);
  await requestStores(
    category: null,
    context: context,
    isRefresh: true,
    pageNumber: 1,
  );
  await requestMyStore(context, 1, true);
  await requestCategoriesList(context, true);
  await requestPlans(isRefresh: false, context: context);
  await requestCart(context, true, 1);
  // await requestUserOrders(pageNumber, context, true);
  // await requestProducts(userToken, context, pageNumber, true);
  // await requestAds(pageNumber, context, true);
  // await requestShowCountry(userToken, context);
  await requestUserInfo(userToken, context);
  // await requestCategoryProducts("", 1, context, true);
}
