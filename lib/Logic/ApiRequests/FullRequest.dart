import 'package:flutter/material.dart';
import 'package:test_store/Logic/ApiRequests/CartRequests/CartRequest.dart';
import 'package:test_store/Logic/ApiRequests/HomeRequest.dart';
import 'package:test_store/Logic/ApiRequests/LogisticRequests/LocationsRequest.dart';
import 'package:test_store/Logic/ApiRequests/MessagingRequests/ChatsRequest.dart';
import 'package:test_store/Logic/ApiRequests/PlansRequest.dart';
import 'package:test_store/Logic/ApiRequests/ProfileRequests/MyStoresRequest.dart';
import 'package:test_store/Logic/ApiRequests/StoresRequest/StoresRequest.dart';
import 'package:test_store/Logic/ApiRequests/TagsRequest.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/WishListRequests/WishListRequest.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';
import 'RequestsExport.dart';

Future firstSuperRequest(
    {required String? userToken,
    required String? userId,
    required int pageNumber,
    required BuildContext context}) async {
  if (context.read(countriesStateManagment).countries.isEmpty) {
    requestLocation(context: context);
  }
  await requestHome(
    context: context,
  );
  // await requestPlans(context: context, isRefresh: false);
  await requestAllStores(
    context: context,
    isRefresh: true,
    pageNumber: 1,
  );
  await requestMyStore(context, 1, true);
  await requestCategoriesList(context, true);
  await requestPlans(isRefresh: false, context: context);
  await requestCart(context, true, 1);
  await requestTags(context, true, 1);
  await requestChats(context, 1, true);
  await requestWishList(context, true);
  await requestUserOrders(pageNumber, context, true);
  // await requestProducts(userToken, context, pageNumber, true);
  // await requestAds(pageNumber, context, true);
  // await requestShowCountry(userToken, context);
  await requestUserInfo(userToken, context);
  // await requestCategoryProducts("", 1, context, true);
}
