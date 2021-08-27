import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/CartRequests/RemoveFromCart.dart';
import 'package:test_store/Logic/ApiRequests/CartRequests/UpdateCartQuantity.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(context: context, title: "عربة التسوق"),
        body: Consumer(builder: (BuildContext context,
            T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
          final cartState = watch(cartStateManagment);
          return cartState.cart.length == 0
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "Assets/Images/EmptyCartIcon.png",
                      scale: screenWidth(context) * 0.01,
                    ),
                    Text(
                      "العربة فارغة",
                      style: TextStyle(fontSize: screenWidth(context) * 0.1),
                    )
                  ],
                ))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: cartState.cart.length,
                          itemBuilder: (context, index) {
                            final cartItem =
                                cartState.cart[index]["products"][0];
                            return Card(
                              child: ListTile(
                                trailing: IconButton(
                                    onPressed: () {
                                      requestRemoveFromCart(
                                          context, cartState.cart[index]["id"]);
                                    },
                                    icon: Icon(Icons.cancel_outlined)),
                                title: Text(
                                  cartItem["name"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth(context) * 0.045),
                                ),
                                leading: Container(
                                  width: screenWidth(context) * 0.25,
                                  child: CachedNetworkImage(
                                    imageUrl: apiMockImage,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Image.asset(
                                        settings.images!.placeHolderImage),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartState.cart[index]["total"]
                                            .toString() +
                                        " جم"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              requestUpdateCartQNT(
                                                  context,
                                                  cartState.cart[index]["id"],
                                                  cartState.cart[index]["qnt"] +
                                                      1);
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.deepPurple,
                                            )),
                                        Text(
                                          cartState.cart[index]["qnt"]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  screenWidth(context) * 0.04),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              requestUpdateCartQNT(
                                                  context,
                                                  cartState.cart[index]["id"],
                                                  cartState.cart[index]["qnt"] -
                                                      1);
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              color: Colors.deepPurple,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                isThreeLine: true,
                              ),
                            );
                          }),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(right: screenWidth(context) * 0.045),
                      alignment: AlignmentDirectional.bottomStart,
                      child: Text(
                        "العنوان",
                        style:
                            TextStyle(fontSize: screenWidth(context) * 0.045),
                      ),
                    ),
                    Divider(
                      color: settings.theme!.secondary,
                      endIndent: screenWidth(context) * 0.08,
                      indent: screenWidth(context) * 0.08,
                    ),
                    ListTile(
                      title: Text("اجمالي المبلغ"),
                      trailing: Text(
                        watch(cartStateManagment).cartTotalPayment.toString() +
                            " جنيه مصري",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth(context) * 0.05),
                      ),
                    ),
                    customGeneralButton(
                        context: context,
                        customOnPressed: () {
                          // Navigator.push(context, MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //   return PaymentScreen();
                          // }));
                        },
                        newIcon: Icon(Icons.shopping_bag),
                        primarycolor: violet,
                        title: 'تاكيد الطلب',
                        titlecolor: Colors.white,
                        borderColor: Colors.transparent)
                  ],
                );
        }),
      ),
    );
  }
}
