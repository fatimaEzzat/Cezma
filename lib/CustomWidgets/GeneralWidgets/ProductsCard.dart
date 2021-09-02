import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/addToCartButton.dart';
import 'package:test_store/Logic/ApiRequests/WishListRequests/AddToWishListRequest.dart';
import 'package:test_store/Logic/ApiRequests/WishListRequests/RemoveFromWishListRequest.dart';
import 'package:test_store/Logic/StateManagment/WishListState.dart';
import 'package:test_store/Screens/SecondaryScreens/ProductViewScreen.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

Widget productsCard({required BuildContext context, required currentItem}) {
  double discount = 0;
  if (currentItem["discount"] != 0) {
    discount = currentItem["discount"] / currentItem["price"];
    discount *= 100;
  }

  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ProductViewScreen(product: currentItem);
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
                      imageUrl: currentItem["image"].contains("placeholder")
                          ? apiBaseUrl + currentItem["image"]
                          : currentItem["image"],
                      placeholder: (context, url) => Image.asset(
                        settings.images!.placeHolderImage,
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        settings.images!.placeHolderImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                    currentItem["discount"] != 0
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
                    currentItem["name"],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.aspectRatio * 30),
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    currentItem["price"].toString() + " جم",
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
                        item: currentItem,
                      ),
                    ),
                    Consumer(
                      builder: (BuildContext context,
                          T Function<T>(ProviderBase<Object?, T>) watch,
                          Widget? child) {
                        final wishListState = watch(wishListtateManagment);
                        return Flexible(
                          child: IconButton(
                              color: wishListState
                                      .checkInWishList(currentItem["id"])
                                  ? Colors.red
                                  : Colors.grey,
                              onPressed: () {
                                wishListState.checkInWishList(currentItem["id"])
                                    ? requestRemoveFromWishList(
                                        context,
                                        wishListState.getIdFromWishList(
                                            currentItem["id"]))
                                    : requestAddToWishList(
                                        context, currentItem);
                              },
                              icon: Icon(Icons.favorite)),
                        );
                      },
                    ),
                  ]),
            )
          ],
        ),
      ),
    ),
  );
}
