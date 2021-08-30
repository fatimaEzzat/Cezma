import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';

import 'package:test_store/Logic/MISC/GetLocation.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late String userToken;
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read(userStateManagment).userInfo!.address);
    userToken = context.read(userStateManagment).userToken!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
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
          "الدفع",
          style: TextStyle(color: settings.theme!.secondary),
        ),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (BuildContext context,
            T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
          final cartState = watch(cartStateManagment);
          final countriesState = watch(countriesStateManagment);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: FormBuilder(
              key: _formKey,
              child: Column(children: []),
            ),
          );
        },
      ),
    );
  }
}
