import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/PaymentScreenWidgets/AddressSettingTile.dart';
import 'package:test_store/CustomWidgets/PaymentScreenWidgets/CitySettingTile.dart';
import 'package:test_store/CustomWidgets/PaymentScreenWidgets/GovSettingTile.dart';
import 'package:test_store/Logic/ApiRequests/OrdersRequests/NewOrder.dart';
import 'package:test_store/Logic/MISC/GetLocation.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late String userToken;
  late TextEditingController _controller;
  GetLocation _location = GetLocation();
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
              child: Column(
                children: [
                  Expanded(
                    child: SettingsList(
                      contentPadding: EdgeInsets.only(top: height * 0.02),
                      backgroundColor: Colors.white,
                      sections: [
                        SettingsSection(
                          title: "معلومات التوصيل ",
                          titleTextStyle:
                              TextStyle(color: settings.theme!.secondary),
                          tiles: [
                            // customAddressSettingTile(
                            //     width: width,
                            //     controller: _controller,
                            //     context: context,
                            //     height: height,
                            //     locationState: watch(locationStateManagment),
                            //     onTap: () async {
                            //       watch(locationStateManagment)
                            //           .setIsGettingLocation();
                            //       await _location.getLocationName().then(
                            //           (value) => _controller.text = value);
                            //       watch(locationStateManagment)
                            //           .setIsGettingLocation();
                            //     }),
                            addressSettingTile(
                                width: width,
                                controller: _controller,
                                context: context,
                                height: height),
                            govSettingTile(
                                width: width,
                                countriesState: countriesState,
                                formkey: _formKey,
                                context: context,
                                height: height),
                            citySettingTile(
                                width: width,
                                countriesState: countriesState,
                                context: context,
                                height: height),
                            SettingsTile(
                                leading: ImageIcon(
                                    AssetImage("Images/money-bag.png"),
                                    color: settings.theme!.secondary),
                                title: "تكلفة الطلب",
                                trailing: Text(
                                  cartState.cart.getTotalAmount().toString() +
                                      " جنيه مصري",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            SettingsTile(
                                leading: Icon(Icons.local_shipping,
                                    color: settings.theme!.secondary),
                                title: "تكلفة الشحن",
                                trailing: countriesState.selectedGov == null
                                    ? Text("...")
                                    : Text(
                                        countriesState.countries
                                                .where((element) =>
                                                    element["id"] ==
                                                    int.parse(countriesState
                                                        .selectedGov))
                                                .toList()[0]["price"]
                                                .toString() +
                                            " جنيه مصري",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                            SettingsTile(
                                leading: ImageIcon(
                                  AssetImage("Images/money.png"),
                                  color: settings.theme!.secondary,
                                ),
                                title: "الاجمالي",
                                trailing: countriesState.selectedGov == null
                                    ? Text("...")
                                    : Text(
                                        (countriesState.countries
                                                        .where((element) =>
                                                            element["id"] ==
                                                            int.parse(
                                                                countriesState
                                                                    .selectedGov))
                                                        .toList()[0]["price"] +
                                                    cartState.cart
                                                        .getTotalAmount())
                                                .toString() +
                                            " جنيه مصري",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))
                          ],
                        )
                      ],
                    ),
                  ),
                  customGeneralButton(
                      customOnPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          int shipping = countriesState.countries
                              .where((element) =>
                                  element["id"] ==
                                  int.parse(countriesState.selectedGov))
                              .toList()[0]["price"];
                          double total = countriesState.countries
                                  .where((element) =>
                                      element["id"] ==
                                      int.parse(countriesState.selectedGov))
                                  .toList()[0]["price"] +
                              cartState.cart.getTotalAmount();
                          _formKey.currentState!.validate();
                          _formKey.currentState!.save();

                          try {
                            Get.defaultDialog(
                                title: "جاري تحضير الطلب",
                                content: CircularProgressIndicator(
                                  color: settings.theme!.secondary,
                                ));
                            final response = await requestNewOrder(
                                userToken: userToken,
                                context: context,
                                total: total,
                                govCityInput: _formKey.currentState!.value,
                                shipped: shipping);
                            if (response.data.values
                                .toString()
                                .contains("false")) {
                              Get.back();
                              throw {
                                Get.defaultDialog(
                                    title: "خطأ",
                                    middleText:
                                        response.data["errors"].toString(),
                                    confirm: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("تم"),
                                      style: ElevatedButton.styleFrom(
                                          primary: settings.theme!.secondary),
                                    ))
                              };
                            }
                            Get.back();
                            Get.defaultDialog(
                                title: "تم وضع الطلب بنجاح",
                                content: Icon(Icons.done),
                                confirm: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("تم"),
                                  style: ElevatedButton.styleFrom(
                                      primary: settings.theme!.secondary),
                                ));
                          } on Exception {
                            Get.back();
                            Get.defaultDialog(
                                title: "خطء في العملية",
                                content: Icon(Icons.cancel));
                          }
                          cartState.cart.deleteAllCart();
                        }
                      },
                      context: context,
                      title: "تاكيد الطلب",
                      primarycolor: settings.theme!.secondary,
                      titlecolor: Colors.white,
                      newIcon: Icon(Icons.payment),
                      borderColor: Colors.transparent)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
