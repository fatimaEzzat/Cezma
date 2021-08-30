import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Logic/ApiRequests/CartRequests/AddToCart.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Row productViewMainButtons(BuildContext context, ScopedReader watch, product) {
  return Row(
    children: [
      SizedBox(width: screenWidth(context) * 0.04),
      Expanded(
        child: Container(
          height: screenHeight(context) * 0.043,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: new LinearGradient(
                colors: [Colors.blue.shade900, Colors.purple.shade900]),
          ),
          child: customGeneralButton(
              context: context,
              titlecolor: Colors.white,
              title: watch(cartStateManagment).checkInCart(product["id"])
                  ? "في العربة"
                  : "اضف الي العربة",
              newIcon: watch(cartStateManagment).checkInCart(product['id'])
                  ? Icon(Icons.check)
                  : Icon(Icons.add_shopping_cart),
              customOnPressed: () {
                requestAddToCart(context, product['id']);
              },
              primarycolor: Colors.transparent,
              borderColor: Colors.transparent),
        ),
      ),
      SizedBox(width: screenWidth(context) * 0.04),
      Expanded(
        child: customGeneralButton(
            context: context,
            titlecolor: violet,
            title: "محادثة المتجر",
            newIcon: Icon(Icons.message, color: violet),
            customOnPressed: () {},
            primarycolor: Colors.transparent,
            borderColor: violet),
      ),
      SizedBox(width: screenWidth(context) * 0.04),
    ],
  );
}
