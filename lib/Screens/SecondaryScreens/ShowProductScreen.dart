import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomGeneralButton.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/ProductsState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class ShowProductScreen extends StatefulWidget {
  final int index;

  ShowProductScreen({Key? key, required this.index}) : super(key: key);

  @override
  _ShowProductScreenState createState() => _ShowProductScreenState();
}

class _ShowProductScreenState extends State<ShowProductScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List options = [];
  late List selected;
  @override
  void initState() {
    selected = List.filled(
        context
            .read(productsStateManagment)
            .products[widget.index]["vars"]
            .length,
        null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: settings.theme!.secondary),
          title: Text(
            context.read(productsStateManagment).products[widget.index]["name"],
            style: TextStyle(color: settings.theme!.secondary),
          ),
          centerTitle: true,
          // leading: Container(),
          elevation: 1,
        ),
        body: Consumer(builder: (context, watch, child) {
          final productState = watch(productsStateManagment).products;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    children: ListTile.divideTiles(context: context, tiles: [
                  CarouselSlider.builder(
                      options: CarouselOptions(
                        enlargeCenterPage: false,
                        viewportFraction: 1,
                      ),
                      itemCount: productState[widget.index]["images"].length,
                      itemBuilder: (context, imgindex, pageindex) => Container(
                            width: screenWidth(context),
                            color: Colors.transparent,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: apiBaseUrl +
                                  productState[widget.index]["images"]
                                      [imgindex],
                              placeholder: (context, url) => Image.asset(
                                  "settings.images!.placeHolderImage.jpeg"),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )),
                  ListTile(
                    title: Text(
                      productState[widget.index]["name"],
                      style: TextStyle(fontSize: screenWidth(context) * 0.07),
                    ),
                    subtitle: new RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                            text: " جنيه مصري " +
                                (productState[widget.index]["price"] -
                                        productState[widget.index]["discount"])
                                    .toString(),
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
                          new TextSpan(
                            text:
                                productState[widget.index]["price"].toString(),
                            style: new TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "الوصف",
                      style: TextStyle(),
                    ),
                    subtitle: Text(productState[widget.index]["description"]),
                  ),
                  ListTile(
                    title: Text(
                      "الكمية",
                      style: TextStyle(),
                    ),
                    subtitle: Text(1.toString()),
                    trailing: Text("كيلو"),
                  ),
                  productState[widget.index]["options"] == 1
                      ? FormBuilder(
                          key: _formKey,
                          child: Column(
                              children: ListTile.divideTiles(
                                      context: context,
                                      tiles: productState[widget.index]["vars"]
                                          .map<Widget>((e) {
                                        return ListTile(
                                          title: Text(e["name"]),
                                          subtitle: Container(
                                              height:
                                                  screenHeight(context) * 0.1,
                                              child:
                                                  ChipsChoice<dynamic>.single(
                                                value: selected[
                                                    productState[widget.index]
                                                            ["vars"]
                                                        .indexOf(e)],
                                                onChanged: (val) {
                                                  setState(() {
                                                    selected[productState[widget
                                                            .index]["vars"]
                                                        .indexOf(e)] = val;
                                                  });
                                                },
                                                choiceItems: C2Choice.listFrom<
                                                        dynamic, dynamic>(
                                                    source: e["value"],
                                                    value: (i, v) =>
                                                        e["value"][i]["label"],
                                                    label: (i, v) =>
                                                        e["value"][i]["label"],
                                                    style: (i, value) {
                                                      return C2ChoiceStyle(
                                                          color: e["value"][i][
                                                                      "color"] !=
                                                                  null
                                                              ? HexColor(
                                                                  e["value"][i]
                                                                      ["color"])
                                                              : settings
                                                                  .theme!
                                                                  .secondary);
                                                    }),
                                              )),
                                        );
                                      }).toList())
                                  .toList()),
                        )
                      : Container()
                ]).toList()),
                customGeneralButton(
                    context: context,
                    titlecolor: Colors.white,
                    title: watch(cartStateManagment).checkItemInCart(
                            productState[widget.index]['id'].toString())
                        ? "في العربة"
                        : "اضف الي العربة",
                    newIcon: watch(cartStateManagment).checkItemInCart(
                            productState[widget.index]['id'].toString())
                        ? Icon(Icons.check)
                        : Icon(Icons.add_shopping_cart),
                    customOnPressed: () {
                      if (selected.contains(null)) {
                        Get.defaultDialog(
                            title: "تنبيه",
                            middleText: "ألرجاء اختيار جميع المواصفات");
                      } else {
                        watch(cartStateManagment).addOrRemovefromCart(
                            productState[widget.index]['id'].toString(),
                            productState[widget.index]['price'],
                            productState[widget.index]['name'].toString(),
                            apiBaseUrl +
                                productState[widget.index]['images'][0]
                                    .toString(),
                            selected);
                      }
                    },
                    primarycolor: settings.theme!.secondary)
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
