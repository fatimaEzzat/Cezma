import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/LogisticRequests/CitiesRequest.dart';
import 'package:test_store/Logic/ApiRequests/OrdersRequests/CheckOutRequest.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Models/UserModel.dart';
import 'package:test_store/Screens/NavBarScreens/NavigationBar.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late UserModel userInfo;
  double totalPayment = 0;
  final _formkey = GlobalKey<FormBuilderState>();
  List areas = [];
  bool isLoading = false;
  @override
  void initState() {
    userInfo = context.read(userStateManagment).userInfo!;
    context.read(cartStateManagment).cart!.forEach((element) {
      totalPayment += element["total"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(context: context, title: "الدفع"),
        body: Consumer(
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            return FutureBuilder(
              future: requestCities(
                countryName: context
                    .read(countriesStateManagment)
                    .countries
                    .firstWhere((element) =>
                        element["id"] ==
                        userInfo.locations["country_id"])["name"],
              ),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  final city = snapshot.data.firstWhere((element) =>
                      element["id"] == userInfo.locations["city_id"]);
                  return ModalProgressHUD(
                    inAsyncCall: isLoading,
                    progressIndicator: CircularProgressIndicator(
                      color: violet,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 16,
                          child: FormBuilder(
                            key: _formkey,
                            child: SettingsList(
                              shrinkWrap: true,
                              sections: [
                                SettingsSection(
                                  title: "معلومات المكان",
                                  tiles: [
                                    SettingsTile(
                                      title: "الاسم",
                                      subtitle: userInfo.fullName,
                                    ),
                                    SettingsTile(
                                      title: "الهاتف",
                                      subtitle: userInfo.phone,
                                    ),
                                    SettingsTile(
                                      title: "العلامة المميزة للمكان",
                                      subtitle: userInfo.locations["mark"],
                                    ),
                                    SettingsTile(
                                      title: "الشارع ",
                                      trailing: SizedBox(
                                          width: screenWidth(context) * 0.5,
                                          child: FormBuilderTextField(
                                            initialValue:
                                                userInfo.locations["street"],
                                            validator:
                                                FormBuilderValidators.required(
                                                    context,
                                                    errorText: ""),
                                            name: "street",
                                            decoration:
                                                customformfielddecoration(
                                                    hasErrorText: false,
                                                    context: context,
                                                    border:
                                                        Colors.grey.shade100,
                                                    color: Colors.transparent),
                                          )),
                                    ),
                                    SettingsTile(
                                      title: "البلد",
                                      trailing: SizedBox(
                                        width: screenWidth(context) * 0.5,
                                        child: FormBuilderTextField(
                                          enabled: false,
                                          name: "country_id",
                                          decoration: customformfielddecoration(
                                              hasErrorText: false,
                                              border: Colors.grey.shade100,
                                              context: context,
                                              color: Colors.grey.shade100),
                                          initialValue: context
                                              .read(countriesStateManagment)
                                              .countries
                                              .firstWhere((element) =>
                                                  element["id"] ==
                                                  userInfo.locations[
                                                      "country_id"])["name"]
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                    SettingsTile(
                                        title: "المدينة",
                                        trailing: SizedBox(
                                          width: screenWidth(context) * 0.5,
                                          child: FormBuilderDropdown(
                                              onChanged: (value) {
                                                setState(() {
                                                  areas = snapshot.data
                                                      .firstWhere((e) =>
                                                          e["id"] ==
                                                          value)["areas"];
                                                  _formkey.currentState!
                                                      .fields["area_id"]!
                                                      .reset();
                                                });
                                              },
                                              initialValue: city["id"],
                                              decoration:
                                                  customformfielddecoration(
                                                      hasErrorText: false,
                                                      context: context,
                                                      border:
                                                          Colors.grey.shade100,
                                                      color:
                                                          Colors.transparent),
                                              name: "city_id",
                                              items: snapshot.data
                                                  .map<DropdownMenuItem<Object>>((e) =>
                                                      DropdownMenuItem(
                                                        child: Text(e["name"]),
                                                        value: e["id"],
                                                      ))
                                                  .toList()),
                                        )),
                                    SettingsTile(
                                      title: "المنطقة",
                                      trailing: SizedBox(
                                        width: screenWidth(context) * 0.5,
                                        child: Builder(
                                          builder: (BuildContext context) {
                                            areas = snapshot.data.firstWhere(
                                                (e) =>
                                                    e["id"] ==
                                                    _formkey
                                                        .currentState!
                                                        .fields["city_id"]!
                                                        .value)["areas"];
                                            return FormBuilderDropdown(
                                              validator: FormBuilderValidators
                                                  .required(context,
                                                      errorText: ""),
                                              decoration:
                                                  customformfielddecoration(
                                                      hasErrorText: false,
                                                      context: context,
                                                      border:
                                                          Colors.grey.shade100,
                                                      color:
                                                          Colors.transparent),
                                              name: "area_id",
                                              items: areas
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text(e['name']),
                                                        value: e["id"],
                                                      ))
                                                  .toList(),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SettingsSection(
                                  title: "المنتجات",
                                  tiles: context
                                      .read(cartStateManagment)
                                      .cart!
                                      .map((e) => SettingsTile(
                                            leading: Text(
                                              "(" "x" +
                                                  e["qnt"].toString() +
                                                  ")",
                                            ),
                                            title: e["products"]["name"],
                                            subtitle:
                                                e["total"].toString() + " جم.",
                                          ))
                                      .toList(),
                                ),
                                SettingsSection(
                                  title: "معلومات الدفع",
                                  tiles: [
                                    SettingsTile(
                                      title: "طريقة الدفع",
                                      subtitle: "كاش",
                                    ),
                                    SettingsTile(
                                      title: "المبلغ الكلي",
                                      titleTextStyle: TextStyle(
                                        fontSize: screenHeight(context) * 0.03,
                                      ),
                                      subtitleTextStyle: TextStyle(
                                          fontSize:
                                              screenHeight(context) * 0.03,
                                          color: Colors.grey),
                                      subtitle:
                                          totalPayment.toString() + " جم.",
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: customGeneralButton(
                                customOnPressed: () async {
                                  await checkout();
                                },
                                context: context,
                                title: "تأكيد الدفع و الطلب",
                                primarycolor: violet,
                                titlecolor: Colors.white,
                                newIcon: Icon(Icons.shopping_basket),
                                borderColor: Colors.transparent),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: violet,
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> checkout() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      Map checkout = {};
      checkout.addAll(_formkey.currentState!.value);
      checkout.putIfAbsent("payment_method", () => "cash");
      checkout.update("country_id", (value) => 65);
      setState(() {
        isLoading = !isLoading;
      });
      try {
        await requestCheckout(checkout, context);
        Get.defaultDialog(
            barrierDismissible: false,
            title: "تم",
            middleText: "تم وضع طلبك بنجاح",
            confirmTextColor: Colors.white,
            buttonColor: violet,
            textConfirm: "اكمل التسوق   ",
            onConfirm: () {
              Get.offAll(() => CustomNavigationBar());
            });
      } catch (e) {
        if (e is DioError) {
          Get.defaultDialog(title: "خطا", middleText: e.message);
        }
      }
      setState(() {
        isLoading = !isLoading;
      });
    }
  }
}
