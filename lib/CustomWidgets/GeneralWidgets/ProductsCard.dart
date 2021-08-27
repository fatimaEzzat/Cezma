import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/addToCartButton.dart';
import 'package:test_store/Screens/SecondaryScreens/ProductViewScreen.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

Widget productsCard(
    {required BuildContext context,
    required currentList,
    required index,
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
                      imageUrl:
                          currentList[index]["image"].contains("placeholder")
                              ? apiBaseUrl + currentList[index]["image"]
                              : currentList[index]["image"],
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
                        context: context,
                        itemId: currentList[index]['id'],
                      ),
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
