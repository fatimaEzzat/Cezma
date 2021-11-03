// ignore: import_of_legacy_library_into_null_safe

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Logic/ApiRequests/AuthRequests/SignUpRequest.dart';
import 'package:test_store/Logic/ApiRequests/LogisticRequests/CitiesRequest.dart';
import 'package:test_store/Logic/ApiRequests/LogisticRequests/LocationsRequest.dart';
import 'package:test_store/Logic/MISC/CheckInternetConnection.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/AuthScreens/ActivationScreen.dart';
import 'package:test_store/Screens/AuthScreens/LoginScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormBuilderState>();
  bool isLogging = false;
  int countryId = 0;
  int cityId = 0;
  int areaId = 0;
  List areas = [];
  List cities = [];
  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none ) {
        requestLocation(
          context: context,
        ).then((value) => setState(() {}));
      }
    });
    if (InternetConnectionChecker().hasConnection != null) {
      requestLocation(context: context).then((value) => setState(() {}));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Those two variables contain screen's size (width and height).
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLogging,
        progressIndicator: CircularProgressIndicator(
          color: violet,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: FormBuilder(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.08,
                    ),
                    SvgPicture.asset("Assets/Logos/LogoWithoutText.svg"),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Wrap(
                      runSpacing: height * 0.02,
                      children: [
                        Container(
                          width: width * 0.8,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: FormBuilderTextField(
                              keyboardType: TextInputType.number,
                              name: 'phone',
                              decoration: customformfielddecoration(
                                  labelText: "رقم الهاتف",
                                  context: context,
                                  obsecure: null,
                                  color: offwhite),
                              validator: FormBuilderValidators.required(context,
                                  errorText: "بالرجاء ادخال رقم الهاتف"),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.8,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: FormBuilderTextField(
                                obscureText: true,
                                name: 'password',
                                decoration: customformfielddecoration(
                                    labelText: "كلمة السر",
                                    context: context,
                                    obsecure: null,
                                    color: offwhite),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context,
                                      errorText: "بالرجاء ادخال كلمة السر"),
                                  FormBuilderValidators.minLength(context, 8)
                                ])),
                          ),
                        ),
                        Container(
                          width: width * 0.8,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: FormBuilderTextField(
                              obscureText: true,
                              name: 'password_confirmation',
                              decoration: customformfielddecoration(
                                  labelText: "تأكيد كلمة السر",
                                  context: context,
                                  obsecure: null,
                                  color: offwhite),
                              validator: FormBuilderValidators.required(context,
                                  errorText: " بالرجاء ادخال كلمة السر مجددا"),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.8,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: FormBuilderTextField(
                              name: 'street',
                              decoration: customformfielddecoration(
                                  labelText: "الشارع",
                                  context: context,
                                  obsecure: null,
                                  color: offwhite),
                              validator: FormBuilderValidators.required(context,
                                  errorText: "بالرجاء ادخال الشارع"),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.8,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: FormBuilderTextField(
                              name: 'mark',
                              decoration: customformfielddecoration(
                                  labelText: "علامة مميزة",
                                  context: context,
                                  obsecure: null,
                                  color: offwhite),
                              validator: FormBuilderValidators.required(context,
                                  errorText: "بالرجاء ادخال العلامة المميزة"),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.8,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: FormBuilderDropdown(
                              onChanged: (value) async {
                                _formkey.currentState!.fields["city_id"]!
                                    .reset();
                                _formkey.currentState!.fields["area_id"]!
                                    .reset();
                                String countryName = context
                                    .read(countriesStateManagment)
                                    .countries
                                    .firstWhere((element) =>
                                        element["id"] ==
                                        int.parse(value.toString()))["name"];
                                await requestCities(countryName: countryName)
                                    .then((value) => setState(() {
                                          cities = value;
                                        }));
                              },
                              icon: context
                                      .read(countriesStateManagment)
                                      .countries
                                      .isNotEmpty
                                  ? Icon(Icons.arrow_downward)
                                  : Container(
                                      width: 10,
                                      height: 10,
                                      child: CircularProgressIndicator(
                                        color: violet,
                                      )),
                              items: context
                                  .read(countriesStateManagment)
                                  .countries
                                  .map((e) => DropdownMenuItem(
                                        onTap: () {
                                          countryId = e["id"];
                                        },
                                        child: (Text(e["name"])),
                                        value: e["id"],
                                      ))
                                  .toList(),
                              name: 'country_id',
                              decoration: customformfielddecoration(
                                  labelText: "الدولة",
                                  context: context,
                                  obsecure: null,
                                  color: offwhite),
                              validator: FormBuilderValidators.required(context,
                                  errorText: "بالرجاء اختيار الدولة"),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.8,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: FormBuilderDropdown(
                              items: cities
                                  .map((e) => DropdownMenuItem(
                                        onTap: () {
                                          setState(() {
                                            cityId = e["id"];
                                            areas = e["areas"];
                                            _formkey.currentState!
                                                .fields["area_id"]!
                                                .reset();
                                          });
                                        },
                                        child: Text(e['name']),
                                        value: e["id"],
                                      ))
                                  .toList(),
                              name: 'city_id',
                              decoration: customformfielddecoration(
                                  labelText: "المدينة",
                                  context: context,
                                  obsecure: null,
                                  color: offwhite),
                              validator: FormBuilderValidators.required(context,
                                  errorText: "بالرجاء اختيار المدينة"),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.8,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: FormBuilderDropdown(
                              onChanged: (value) {
                                setState(() {
                                  areaId = int.parse(value.toString());
                                });
                              },
                              items: areas
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e['name']),
                                        value: e["id"],
                                      ))
                                  .toList(),
                              name: 'area_id',
                              decoration: customformfielddecoration(
                                  labelText: "المنطقة",
                                  context: context,
                                  obsecure: null,
                                  color: offwhite),
                              validator: FormBuilderValidators.required(context,
                                  errorText: "بالرجاء اختيار المنطقة"),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.8,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: FormBuilderTextField(
                              keyboardType: TextInputType.number,
                              name: 'zip',
                              decoration: customformfielddecoration(
                                  labelText: "رقم بريد",
                                  context: context,
                                  obsecure: null,
                                  color: offwhite),
                              validator: FormBuilderValidators.required(context,
                                  errorText: "بالرجاء ادخال رقم البريد"),
                            ),
                          ),
                        ),
                        Container(
                          height: screenHeight(context) * 0.045,
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(colors: [
                              Colors.blue.shade900,
                              Colors.purple.shade900
                            ]),
                          ),
                          child: customGeneralButton(
                              customOnPressed: () {
                                validation(context);
                              },
                              context: context,
                              title: "حساب جديد",
                              newIcon: Icon(
                                Icons.person_add,
                                color: Colors.white,
                              ),
                              primarycolor: Colors.transparent,
                              titlecolor: Colors.white,
                              borderColor: Colors.transparent),
                        ),
                        customGeneralButton(
                            customOnPressed: () {
                              Get.off(() => LoginScreen());
                            },
                            context: context,
                            title: "تسجيل دخول ",
                            newIcon: Icon(
                              Icons.login,
                              color: Colors.white,
                            ),
                            primarycolor: petrol,
                            titlecolor: Colors.white,
                            borderColor: Colors.transparent)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// validate the input and making sure no input is missing.
  Future validation(BuildContext contextm) async {
    if (await checkInternetConnection()) {
      // first we check if there is internet connection
      if (_formkey.currentState!.validate()) {
        // then we check if there are any missing fields.

        if (_formkey.currentState!.fields["phone"]!.value[0] != "0") {
          throw {Get.snackbar("خطأ", "هذا الرقم ليس صحيح")};
        }
        _formkey.currentState!.fields["phone"]!
            .setValue("+2" + _formkey.currentState!.fields["phone"]!.value);
        _formkey.currentState!.save();

        var loginInfo = _formkey.currentState!
            .value; // containes login info extracted from both email and password fields.

        if (loginInfo["password_confirmation"] != loginInfo["password"]) {
          throw {Get.snackbar("خطأ", "كلمتا السر ليسا متطابقتين")};
        }

        try {
          setState(() {
            isLogging = !isLogging;
          });
          await requestSignUp(loginInfo).then((value) {
            if (value["success"] == false) {
              setState(() {
                isLogging = !isLogging;
              });

              throw {
                Get.defaultDialog(
                    title: "خطا", middleText: value["message"].toString())
              };
            }
          });
          context.read(userStateManagment).userPhone =
              _formkey.currentState!.fields["phone"]!.value;
          setState(() {
            isLogging = !isLogging;
          });
          //if the process of loginning is successful, we pop up a message to inform the user of the success.
          Get.defaultDialog(
              barrierDismissible: false,
              title: "تم!",
              middleText: "تم انشاء الحساب بنجاح",
              confirm: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: violet),
                  onPressed: () {
                    Get.off(() => ActivationScreen(
                          number: context.read(userStateManagment).userPhone,
                        ));
                  },
                  child: Text("تأكيد")));
        } on Exception catch (e) {
          if (e is DioError) {
            Get.snackbar("خطا", "هذا الرقم مسجل بالفعل");
          }
          setState(() {
            isLogging = !isLogging;
          });
        }
      }
    } else {
      Get.defaultDialog(title: "خطأ", middleText: "لا يوجد اتصال بالانترنت");
      // if we have missing internet connection
      //.. we pop up a message to the user to inform them that there is missing internet connection
    }
  }
}
