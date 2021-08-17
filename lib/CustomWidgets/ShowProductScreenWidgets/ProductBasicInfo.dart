import 'package:flutter/material.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

ListTile productBasicInfo(
    {required List<dynamic> productState,
    required BuildContext context,
    required int index,
    required totalPrice,
    required discountAmount,
    required price,
    required discountPercentage}) {
  return ListTile(
    title: Text(
      productState[index]["name"],
      style: TextStyle(fontSize: screenWidth(context) * 0.07),
    ),
    subtitle: new RichText(
      text: new TextSpan(
        children: <TextSpan>[
          new TextSpan(
            text: " جم " + totalPrice.toString(),
            style: new TextStyle(
                color: settings.theme!.secondary,
                fontSize: screenWidth(context) * 0.05),
          ),
          new TextSpan(
            text: "  ",
            style: new TextStyle(
              color: settings.theme!.secondary,
            ),
          ),
          discountAmount != null
              ? new TextSpan(
                  text: price.toString(),
                  style: new TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                )
              : new TextSpan(),
        ],
      ),
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: screenWidth(context) * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(productState[index]["rate"].toString() + "/" + "5"),
              ],
            )),
        discountAmount != null
            ? Container(
                padding: EdgeInsets.all(5),
                color: Colors.red,
                child: Text(
                  "خصم " + "%" + discountPercentage.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}
