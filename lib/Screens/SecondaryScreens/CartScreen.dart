import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomGeneralButton.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Screens/SecondaryScreens/PaymentScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "عربة التسوق",
            style: TextStyle(color: settings.theme!.secondary),
          ),
          centerTitle: true,
          leading: BackButton(color: settings.theme!.secondary),
          elevation: 1,
        ),
        body: Consumer(builder: (BuildContext context,
            T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
          final cartState = watch(cartStateManagment);
          return cartState.cart.getCartItemCount() == 0
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      settings.images!.emptyCartIcon,
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
                          itemCount: cartState.cart.cartItem.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                trailing: IconButton(
                                    onPressed: () {
                                      cartState.deleteFromCart(index);
                                    },
                                    icon: Icon(Icons.cancel_outlined)),
                                title: Text(
                                  cartState.cart.cartItem[index].productName
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth(context) * 0.045),
                                ),
                                leading: Container(
                                  width: screenWidth(context) * 0.25,
                                  child: CachedNetworkImage(
                                    imageUrl: cartState
                                        .cart.cartItem[index].uniqueCheck,
                                    placeholder: (context, url) => Image.asset(
                                        settings.images!.placeHolderImage),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartState
                                            .cart.cartItem[index].unitPrice
                                            .toString() +
                                        "EGB" +
                                        "\n كيلو"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              cartState.incrementProduct(index);
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.deepPurple,
                                            )),
                                        Text(
                                          cartState
                                              .cart.cartItem[index].quantity
                                              .toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  screenWidth(context) * 0.04),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              cartState.decrementProduct(index);
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
                        "هل لديك كود خصم ؟",
                        style:
                            TextStyle(fontSize: screenWidth(context) * 0.045),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomStart,
                      padding: EdgeInsets.only(
                          left: screenWidth(context) * 0.03,
                          right: screenWidth(context) * 0.03),
                      child: FormBuilder(
                          key: _formkey,
                          child: FormBuilderTextField(
                            name: 'discount',
                            decoration: InputDecoration(
                                isDense: true,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: settings.theme!.secondary)),
                                fillColor: offwhite,
                                filled: true,
                                hintText: "كود خصم"),
                          )),
                    ),
                    Divider(
                      color: settings.theme!.secondary,
                      endIndent: screenWidth(context) * 0.08,
                      indent: screenWidth(context) * 0.08,
                    ),
                    ListTile(
                      title: Text("اجمالي المبلغ"),
                      trailing: Text(
                        cartState.cart.getTotalAmount().toString() +
                            " جنيه مصري",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth(context) * 0.05),
                      ),
                    ),
                    customGeneralButton(
                        context: context,
                        customOnPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return PaymentScreen();
                          }));
                        },
                        newIcon: Icon(Icons.shopping_bag),
                        primarycolor: settings.theme!.secondary,
                        title: 'تاكيد الطلب',
                        titlecolor: Colors.white, borderColor: Colors.transparent)
                  ],
                );
        }),
      ),
    );
  }
}
