import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Screens/SecondaryScreens/ProductViewScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

import 'addToCartButton.dart';

Widget productsCard(
    {required BuildContext context,
    required currentList,
    required index,
    required cartState,
    box,
    wishListState}) {
  double discount = 0;
  if (currentList[index]["discount"] != null) {
    discount = currentList[index]["discount"] / currentList[index]["price"];
    discount *= 100;
  }

  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ProductViewScreen(product: currentList[index]);
      }));
    },
    child: Center(
      child: Card(
        elevation: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: screenWidth(context) * 0.45,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: currentList[index]["image"].replaceAll(
                          "https://cezma.test",
                          "https://7337-197-37-196-117.ngrok.io"),
                      placeholder: (context, url) =>
                          Image.asset(settings.images!.placeHolderImage),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    currentList[index]["discount"] != null
                        ? Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: FittedBox(
                              fit: BoxFit.none,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                color: Colors.red,
                                child: AutoSizeText(
                                  "خصم " + "%" + discount.toStringAsFixed(1),
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            Container(
                width: screenWidth(context) * 0.45,
                child: ListTile(
                  dense: true,
                  title: AutoSizeText(
                    currentList[index]["name"],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.aspectRatio * 30),
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    currentList[index]["price"].toString() + " جم",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                )),
            Container(
              width: screenWidth(context) * 0.45,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: addToCartButton(
                          itemIndex: index,
                          context: context,
                          itemId: currentList[index]['id'].toString(),
                          customIcon: cartState.checkItemInCart(
                                  currentList[index]['id'].toString())
                              ? Icon(Icons.check)
                              : Icon(
                                  Icons.add_shopping_cart,
                                  size: screenWidth(context) * 0.045,
                                ),
                          title: cartState.checkItemInCart(
                                  currentList[index]['id'].toString())
                              ? "في العربة"
                              : "اضف الي العربة",
                          price: currentList[index]["price"],
                          productName: currentList[index]["name"],
                          options: [],
                          containsOptions: currentList[index]["options"] == 1,
                          imageUrl: currentList[index]["image"]),
                    ),
                    Flexible(
                      child: IconButton(
                          color: Colors.red,
                          onPressed: () {
                            wishListState.addToWishList(
                                currentList[index], currentList[index]['id']);
                          },
                          icon: Icon(Icons.favorite)),
                    ),
                  ]),
            )
          ],
        ),
      ),
    ),
  );
}
