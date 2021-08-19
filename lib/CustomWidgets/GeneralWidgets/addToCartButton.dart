import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Screens/SecondaryScreens/ShowProductScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Widget addToCartButton({
  required BuildContext context,
  required bool containsOptions,
  required String itemId,
  required Icon customIcon,
  required int price,
  required String title,
  required String productName,

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
        onPressed: () {},
        icon: customIcon,
        label: Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: screenWidth(context) * 0.024),
          ),
        )),
  );
}
