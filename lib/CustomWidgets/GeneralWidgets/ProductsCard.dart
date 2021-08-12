import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Screens/SecondaryScreens/ShowProductScreen.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

import 'addToCartButton.dart';

Widget productsCard(
        {required context,
        required currentList,
        required index,
        required cartState,
        required box,
      required  wishListState}) =>
    InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ShowProductScreen(
            index: index,
          );
        }));
      },
      child: Card(
        elevation: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: screenWidth(context) * 0.6,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      apiBaseUrl + currentList[index]["images"][0],
                  placeholder: (context, url) =>
                      Image.asset(settings.images!.placeHolderImage),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            AutoSizeText(
              currentList[index]["name"],
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.aspectRatio * 30),
              maxLines: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                currentList[index]["price"].toString() + "EGB",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          imageUrl: apiBaseUrl +
                              currentList[index]["images"][0],
                          options: [],
                          containsOptions:
                              currentList[index]["options"] == 1),
                    ),
                    Flexible(
                      child: IconButton(
                          color: box.containsKey(
                                  currentList[index]['id'])
                              ? Colors.red
                              : Colors.grey,
                          onPressed: () {
                            wishListState.addToWishList(
                                currentList[index],
                                currentList[index]['id']);
                          },
                          icon: Icon(Icons.favorite)),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
