import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Screens/SecondaryScreens/CartScreen.dart';
import 'package:test_store/Screens/SecondaryScreens/FavouritesScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:badges/badges.dart';

PreferredSizeWidget primaryAppBar({required BuildContext context, tabBar}) {
  return AppBar(
    elevation: 0,
    flexibleSpace: Container(
        decoration: new BoxDecoration(
      gradient: new LinearGradient(
          colors: [Colors.blue.shade900, Colors.purple.shade900]),
    )),
    leading: Padding(
      padding: EdgeInsets.only(
          left: screenWidth(context) * 0.04,
          right: screenWidth(context) * 0.04),
      child: SvgPicture.asset(
        "Assets/Logos/AppBarLogo.svg",
        fit: BoxFit.contain,
        color: Colors.white,
      ),
    ),
    leadingWidth: screenWidth(context) * 0.32,
    actions: [
      IconButton(
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (BuildContext context) {
            //   return FavoritesScreen();
            // }));
          },
          icon: Icon(Icons.favorite, color: Colors.white)),
      IconButton(onPressed: () {}, icon: Icon(Icons.chat, color: Colors.white)),
      Consumer(
        builder: (context, watch, child) => IconButton(
          icon: Badge(
            badgeContent:
                Text(watch(cartStateManagment).cart.length.toString()),
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return CartScreen();
            }));
          },
        ),
      ),
    ],
  );
}
