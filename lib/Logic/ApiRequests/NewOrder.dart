import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Logic/ApiRequests/Orders.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<Response> requestNewOrder(
    {required String userToken,
    required BuildContext context,
    required Map govCityInput,
    required double total,
    required int? shipped}) async {
  final state = context.read(userStateManagment).userInfo;
  Dio dio = Dio();
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {
      "Content-Type": "application/json",
      "Authorization": userToken,
      'Charset': 'utf-8'
    },
  );
  List items = [];
  context.read(cartStateManagment).cart.cartItem.forEach((element) {
    items.add({
      "product_id": element.productId,
      "qnt": element.quantity,
      "price": element.unitPrice,
      "discount": 0,
      "options": element.productDetails
    });
  });
  Map body = {
    "first_name": state!.firstName,
    "last_name": state.secondName,
    "phone": state.phone,
    "email": state.email,
    "address": govCityInput["address"],
    "gov_id": govCityInput["gov"],
    "city_id": govCityInput["city"],
    "cart": items,
    "payment": "cash",
    "shipped": shipped,
    "total": total,
  };

  var response =
      await dio.post(apiCreateOrderUrl, data: body, options: requestOptions);
  await requestUserOrders(1, context, true);
  return response;
}
