import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/CartRequests/AddToCart.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Widget addToCartButton({
  required BuildContext context,
  required int itemId,
}) {
  return Consumer(
    builder: (BuildContext context,
        T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
      final cartState = watch(cartStateManagment).cart;
      return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: screenHeight(context) * 0.04,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: new LinearGradient(
              colors: [Colors.blue.shade900, Colors.purple.shade900]),
        ),
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () {
              requestAddToCart(context, itemId);
            },
            icon: Icon(Icons.shopping_bag),
            label: Expanded(
              child: Text(
                watch(cartStateManagment).checkInCart(itemId)
                    ? "في العربة"
                    : "اضف للعربة",
                style: TextStyle(fontSize: screenWidth(context) * 0.024),
              ),
            )),
      );
    },
  );
}
