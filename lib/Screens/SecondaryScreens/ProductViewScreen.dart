import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralCarouselSlider.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/NewMessagePopUp.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/CustomWidgets/ShowProductScreenWidgets/AddReviewButton.dart';
import 'package:test_store/CustomWidgets/ShowProductScreenWidgets/ProductBasicInfo.dart';
import 'package:test_store/CustomWidgets/ShowProductScreenWidgets/ProductViewMainButtons.dart';
import 'package:test_store/CustomWidgets/ShowProductScreenWidgets/RatingBar.dart';
import 'package:test_store/Logic/ApiRequests/AddRatingRequest.dart';
import 'package:test_store/Logic/ApiRequests/ProductRatingsRequest.dart';
import 'package:test_store/Logic/StateManagment/ProductsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class ProductViewScreen extends StatefulWidget {
  final product;
  ProductViewScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  int price = 0;
  int? discountAmount = 0;
  int totalPrice = 0;
  int discountPercentage = 0;
  double rating = 0;
  String comment = "";
  List ratings = [];
  bool loading = false;
  @override
  void initState() {
    price = widget.product["price"];
    discountAmount = widget.product["discount"];
    if (discountAmount != 0) {
      discountPercentage = ((discountAmount! / price) * 100).toInt();
    }
    setState(() {
      loading = !loading;
    });
    requestRatings(context: context, id: widget.product["id"])
        .then((value) => setState(() {
              loading = !loading;
            }));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(
          context: context,
          title: widget.product["name"],
        ),
        body: Consumer(builder: (context, watch, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                generalCarouselSlider(images: widget.product["image"]),
                Column(
                    children: ListTile.divideTiles(context: context, tiles: [
                  productBasicInfo(context: context, product: widget.product),
                  ListTile(
                    title: Text(
                      "الوصف",
                      style: TextStyle(),
                    ),
                    subtitle: Text(widget.product["description"] == null
                        ? "لا يوجد وصف"
                        : widget.product["description"]),
                  ),

                  productViewMainButtons(context, watch, widget.product, () {
                    newMessagePopUp(context, widget.product["store_id"]);
                  }), //contains two buttons, talk to the store and add to car functionallity.
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
                Consumer(
                  builder: (BuildContext context,
                      T Function<T>(ProviderBase<Object?, T>) watch,
                      Widget? child) {
                    ratings = watch(productsStateManagment).productRates;
                    if (loading) {
                      return CircularProgressIndicator(color: violet);
                    } else if (ratings.isEmpty) {
                      return Column(
                        children: [
                          Container(
                            width: screenWidth(context) * 0.92,
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  // review textfield to write down your opinion.
                                  name: 'comment',
                                  onChanged: (value) {
                                    comment = value.toString();
                                  },
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    contentPadding: EdgeInsets.only(
                                        bottom: screenHeight(context) * 0.07,
                                        top: screenHeight(context) * 0.01,
                                        right: screenWidth(context) * 0.04),
                                    hintText: "اكتب تققيمك للمنتج..",
                                  ),
                                ),
                                ratingBar(widget.product, context, (value) {
                                  rating = value;
                                }), // the stars bar that specifies the rating score based on how many stars out of 5
                                SizedBox(
                                  height: screenHeight(context) * 0.015,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)),
                          ),
                          addReviewButton(context, () async {
                            Map info = {
                              "type": "product",
                              "rate": rating,
                              "item_id": widget.product["id"],
                              "comment": comment
                            };
                            await requestNewRating(context, info);
                            Get.defaultDialog(
                                title: "تم",
                                middleText: "تم وضع التقييم بنجاح");
                          }),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          ratings
                                  .where((element) =>
                                      element["customer_id"]["id"] ==
                                      context.read(userStateManagment).userId)
                                  .isNotEmpty
                              ? Container()
                              : Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      width: screenWidth(context) * 0.92,
                                      child: Column(
                                        children: [
                                          FormBuilderTextField(
                                            // review textfield to write down your opinion.
                                            name: 'comment',
                                            onChanged: (value) {
                                              comment = value.toString();
                                            },
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent)),
                                              contentPadding: EdgeInsets.only(
                                                  bottom:
                                                      screenHeight(context) *
                                                          0.07,
                                                  top: screenHeight(context) *
                                                      0.01,
                                                  right: screenWidth(context) *
                                                      0.04),
                                              hintText: "اكتب تققيمك للمنتج..",
                                            ),
                                          ),
                                          ratingBar(widget.product, context,
                                              (value) {
                                            rating = value;
                                          }), // the stars bar that specifies the rating score based on how many stars out of 5
                                          SizedBox(
                                            height:
                                                screenHeight(context) * 0.015,
                                          ),
                                          addReviewButton(context, () async {
                                            Map info = {
                                              "type": "product",
                                              "rate": rating,
                                              "item_id": widget.product["id"],
                                              "comment": comment
                                            };
                                            await requestNewRating(
                                                context, info);
                                            Get.defaultDialog(
                                                title: "تم",
                                                middleText:
                                                    "تم وضع التقييم بنجاح");
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: ratings
                                .map<ListTile>((e) => ListTile(
                                      subtitle: Text(e["comment"] == null
                                          ? ""
                                          : e["comment"]),
                                      title: Text(e["customer_id"]["first_name"]
                                          .toString()
                                          .toString()),
                                      trailing: RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating: e["rate"] == null
                                            ? 0
                                            : double.parse(
                                                e["rate"].toString()),
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        itemSize: screenWidth(context) * 0.045,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (value) {},
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
