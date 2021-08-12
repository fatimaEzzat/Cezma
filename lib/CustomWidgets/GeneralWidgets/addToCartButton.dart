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
  return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary:settings.theme!.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
      ));
}
