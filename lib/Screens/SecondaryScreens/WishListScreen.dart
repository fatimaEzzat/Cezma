import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/StateManagment/WishListState.dart';
import 'package:test_store/Variables/ScreenSize.dart';

import 'ProductViewScreen.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(context: context, title: "المفضلات"),
        body: Consumer(
          // this should be consumer
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final wishListState = watch(wishListtateManagment).wishList;
            return wishListState.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "Assets/Images/broken-heart.png",
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
                        itemCount: wishListState.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.40 / 0.6,
                        ),
                        itemBuilder: (context, index) {
                          final currentItem =
                              wishListState[index]["products"][0];

                          return Center(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return ProductViewScreen(
                                        product: currentItem,
                                      );
                                    }));
                                  },
                                  child: productsCard(
                                    context: context,
                                    currentItem: currentItem,
                                  )));
                        }),
                  );
          },
        ),
      ),
    );
  }
}
