import 'package:flutter/material.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Widget customGeneralButton(
    {required Function() customOnPressed,
    required BuildContext context,
    required String title,
    required Color primarycolor,
    required Color titlecolor,
    required Icon newIcon,
    required Color borderColor}) {
  return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      width: screenWidth(context) * 0.8,
      child: ElevatedButton.icon(
        icon: newIcon,
        onPressed: customOnPressed,
        label: Text(
          title,
          style: TextStyle(color: titlecolor, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
            primary: primarycolor,
            elevation: 0,
            shadowColor: Colors.transparent,
            side: BorderSide(width: 2, color: borderColor)),
      ));
}
