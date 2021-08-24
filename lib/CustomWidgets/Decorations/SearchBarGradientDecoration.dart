import 'package:flutter/material.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Container searchBarGradientDecoration(BuildContext context, Widget child) {
  return Container(
      padding: EdgeInsets.only(
          bottom: screenHeight(context) * 0.01,
          right: screenWidth(context) * 0.03,
          left: screenWidth(context) * 0.03),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.blue.shade900, Colors.purple.shade900]),
      ),
      child: child);
}
