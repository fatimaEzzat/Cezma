import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralCarouselSlider.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/CustomWidgets/ShowProductScreenWidgets/AddReviewButton.dart';
import 'package:test_store/CustomWidgets/ShowProductScreenWidgets/ProductBasicInfo.dart';
import 'package:test_store/CustomWidgets/ShowProductScreenWidgets/ProductViewMainButtons.dart';
import 'package:test_store/CustomWidgets/ShowProductScreenWidgets/RatingBar.dart';
import 'package:test_store/Logic/StateManagment/ProductsState.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class ShowProductScreen extends StatefulWidget {
  final int index;

  ShowProductScreen({Key? key, required this.index}) : super(key: key);

  @override
  _ShowProductScreenState createState() => _ShowProductScreenState();
}

class _ShowProductScreenState extends State<ShowProductScreen> {
  int price = 0;
  int? discountAmount = 0;
  int totalPrice = 0;
  int discountPercentage = 0;
  @override
  void initState() {
    price =
        context.read(productsStateManagment).products[widget.index]["price"];
    totalPrice = context.read(productsStateManagment).products[widget.index]
        ["totalPrice"];
    discountAmount =
        context.read(productsStateManagment).products[widget.index]["discount"];
    if (discountAmount != null) {
      discountPercentage = ((discountAmount! / price) * 100).toInt();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(
          context: context,
          title: context.read(productsStateManagment).products[widget.index]
              ["name"],
        ),
        body: Consumer(builder: (context, watch, child) {
          final productState = watch(productsStateManagment).products;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                generalCarouselSlider(
                    index: widget.index,
                    images: productState[widget.index]["images"]),
                Column(
                    children: ListTile.divideTiles(context: context, tiles: [
                  productBasicInfo(
                      productState: productState,
                      context: context,
                      index: widget.index,
                      totalPrice: totalPrice,
                      discountAmount: discountAmount,
                      price: price,
                      discountPercentage: discountPercentage),
                  ListTile(
                    title: Text(
                      "الوصف",
                      style: TextStyle(),
                    ),
                    subtitle: Text(productState[widget.index]["description"]),
                  ),
                  productViewMainButtons(
                      context,
                      watch,
                      productState,
                      widget
                          .index), //contains two buttons, talk to the store and add to car functionallity.
                ]).toList()),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Divider(
                  thickness: 13,
                  endIndent: screenWidth(context) * 0.04,
                  indent: screenWidth(context) * 0.04,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Container(
                  width: screenWidth(context) * 0.92,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        // review textfield to write down your opinion.
                        name: 'comment',
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          contentPadding: EdgeInsets.only(
                              bottom: screenHeight(context) * 0.07,
                              top: screenHeight(context) * 0.01,
                              right: screenWidth(context) * 0.04),
                          hintText: "اكتب تققيمك للمنتج..",
                        ),
                      ),
                      ratingBar(
                          productState,
                          context,
                          widget
                              .index), // the stars bar that specifies the rating score based on how many stars out of 5
                      SizedBox(
                        height: screenHeight(context) * 0.015,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey)),
                ),
                addReviewButton(
                    context) // adds the written review above, to the reviews in the backend.
              ],
            ),
          );
        }),
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
