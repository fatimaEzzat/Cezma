import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Screens/SecondaryScreens/ShowProductScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

Widget addToCartButton({
  required BuildContext context,
  required bool containsOptions,
  required String itemId,
  required Icon customIcon,
  required int price,
  required String title,
  required String productName,
  required String imageUrl,
  required List options,
  required int itemIndex,
}) {
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: () {
          if (containsOptions) {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return ShowProductScreen(
                index: itemIndex,
              );
            }));
          } else {
            context.read(cartStateManagment).addOrRemovefromCart(
                itemId, price, productName, imageUrl, options);
          }
        },
        icon: customIcon,
        label: Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: screenWidth(context) * 0.024),
          ),
        )),
  );
}
