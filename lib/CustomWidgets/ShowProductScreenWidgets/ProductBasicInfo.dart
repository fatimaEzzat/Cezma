import 'package:flutter/material.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

ListTile productBasicInfo({required product, required context}) {
  double discountPercentage = 0;
  double totalAmount = 0;
  double vat = 0;
  final price = product["price"];
  final discountAmount = product["discount"];
  if (discountAmount != 0) {
    discountPercentage = ((discountAmount! / price) * 100).toDouble();
    if (product["vat"] != null) {
      vat = product["vat"];
    }
    totalAmount = price - discountAmount - vat;
  }
  return ListTile(
    title: Text(
      product["name"],
      style: TextStyle(fontSize: screenWidth(context) * 0.07),
    ),
    subtitle: new RichText(
      text: new TextSpan(
        children: <TextSpan>[
          new TextSpan(
            text: " جم " +
                (discountAmount == 0
                    ? price.toString()
                    : totalAmount.toString()),
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
          discountAmount != 0
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
        product["rate"] != null
            ? Container(
                width: screenWidth(context) * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(product["rate"].toString() + "/" + "5")
                  ],
                ))
            : SizedBox(),
        discountAmount != 0
            ? Container(
                padding: EdgeInsets.all(5),
                color: Colors.red,
                child: Text(
                  "خصم " + "%" + discountPercentage.toStringAsFixed(2),
                  style: TextStyle(color: Colors.white),
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}
