import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/addToCartButton.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';
import 'package:test_store/Logic/StateManagment/FavoritesState.dart';
import 'package:test_store/Logic/StateManagment/ProductsState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

import 'ShowProductScreen.dart';

class FavoritesScreen extends StatelessWidget {
  final box = Hive.box('favorites');
  @override
  Widget build(BuildContext context) {
    var width = screenWidth(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                context.read(countriesStateManagment).setSelectedGov(null);
                Navigator.of(context).pop();
              },
              icon: ImageIcon(
                AssetImage("Images/arrow.png"),
                color: settings.theme!.secondary,
              ))
        ],
        title: Text(
          "المفضلات",
          style: TextStyle(color: settings.theme!.secondary),
        ),
        centerTitle: true,
      ),
      body: Consumer(
        // this should be consumer
        builder: (BuildContext context,
            T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
          final productsState = watch(productsStateManagment);
          final cartState = watch(cartStateManagment);
          return box.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "Images/broken-heart.png",
                      scale: screenWidth(context) * 0.01,
                    ),
                    Text(
                      "لا يوجد مفضلات",
                      style: TextStyle(fontSize: screenWidth(context) * 0.1),
                    )
                  ],
                ))
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.builder(
                      itemCount: box.keys.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final itemIndex = index;
                        final currentItem = productsState.products
                            .where((element) =>
                                element["id"] == box.keys.elementAt(index))
                            .toList()[0];
                        return Center(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ShowProductScreen(
                                product: currentItem,
                              );
                            }));
                          },
                          child: Card(
                            elevation: 0.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: width * 0.4,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl:
                                          apiBaseUrl + currentItem["images"][0],
                                      placeholder: (context, url) => Image.asset(
                                          "settings.images!.placeHolderImage.jpeg"),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  title: Text(
                                    currentItem["name"],
                                  ),
                                  subtitle: Text(
                                    currentItem["price"].toString() + "EGB",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: addToCartButton(
                                          itemIndex: itemIndex,
                                          context: context,
                                          itemId: currentItem['id'].toString(),
                                          customIcon: cartState.checkItemInCart(
                                                  currentItem['id'].toString())
                                              ? Icon(Icons.check)
                                              : Icon(Icons.add_shopping_cart),
                                          title: cartState.checkItemInCart(
                                                  currentItem['id'].toString())
                                              ? "في العربة"
                                              : "اضف الي العربة",
                                          price: currentItem["price"],
                                          productName: currentItem["name"],
                                          options: [],
                                          containsOptions:
                                              currentItem["options"] == 1,
                                          imageUrl: currentItem["image"]),
                                    ),
                                    Flexible(
                                      child: IconButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            watch(wishListtateManagment)
                                                .removeItemFromWishList(
                                                    box.keys.elementAt(index));
                                          },
                                          icon: Icon(Icons.favorite)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                      }),
                );
        },
      ),
    );
  }
}
