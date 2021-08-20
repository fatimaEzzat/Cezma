import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Logic/ApiRequests/AuthRequests/SignUp.dart';
import 'package:test_store/Logic/MISC/CheckInternetConnection.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/AuthScreens/LoginScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Variables/Settings.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // Those two variables contain screen's size (width and height).
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer(
          builder: (BuildContext context,
                  T Function<T>(ProviderBase<Object?, T>) watch,
                  Widget? child) =>
              ModalProgressHUD(
            inAsyncCall: watch(userStateManagment).isLoggingIn,
            child: FormBuilder(
              key: _formkey,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Wrap(
                        runSpacing: height * 0.02,
                        children: [
                          Container(
                            width: width * 0.8,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: FormBuilderTextField(
                                name: 'first_name',
                                decoration: customformfielddecoration(
                                    hinttext: "الاسم الاول",
                                    context: context,
                                    obsecure: null,
                                    color: offwhite),
                                validator: FormBuilderValidators.required(
                                    context,
                                    errorText: "بالرجاء ادخال الاسم الاول"),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.8,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: FormBuilderTextField(
                                name: 'last_name',
                                decoration: customformfielddecoration(
                                    hinttext: "الاسم الاخير",
                                    context: context,
                                    obsecure: null,
                                    color: offwhite),
                                validator: FormBuilderValidators.required(
                                    context,
                                    errorText: "بالرجاء ادخال الاسم الاخير"),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.8,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: FormBuilderTextField(
                                  name: 'email',
                                  decoration: customformfielddecoration(
                                      hinttext: "البريد الالكتروني",
                                      context: context,
                                      obsecure: null,
                                      color: offwhite),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.email(context,
                                        errorText:
                                            "بالرجاء ادخال بريد الكتروني صحيح"),
                                    FormBuilderValidators.required(
                                      context,
                                      errorText:
                                          "بالرجاء ادخال البريد الالكتروني",
                                    )
                                  ])),
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
                                    hinttext: "كلمة السر",
                                    context: context,
                                    obsecure: null,
                                    color: offwhite),
                                validator: FormBuilderValidators.required(
                                    context,
                                    errorText: "بالرجاء ادخال كلمة السر"),
                              ),
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
                                    hinttext: "تأكيد كلمة السر",
                                    context: context,
                                    obsecure: null,
                                    color: offwhite),
                                validator: FormBuilderValidators.required(
                                    context,
                                    errorText:
                                        " بالرجاء ادخال كلمة السر مجددا"),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.8,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: FormBuilderTextField(
                                keyboardType: TextInputType.number,
                                name: 'phone',
                                decoration: customformfielddecoration(
                                    hinttext: "رقم الهاتف",
                                    context: context,
                                    obsecure: null,
                                    color: offwhite),
                                validator: FormBuilderValidators.required(
                                    context,
                                    errorText: "بالرجاء ادخال رقم الهاتف"),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.8,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: FormBuilderTextField(
                                name: 'address',
                                decoration: customformfielddecoration(
                                    hinttext: "العنوان",
                                    context: context,
                                    obsecure: null,
                                    color: offwhite),
                                validator: FormBuilderValidators.required(
                                    context,
                                    errorText: "بالرجاء ادخال العنوان"),
                              ),
                            ),
                          ),
                          customGeneralButton(
                              customOnPressed: () {
                                validation(context);
                              },
                              context: context,
                              title: "حساب جديد",
                              newIcon: Icon(
                                Icons.person_add,
                                color: Colors.white,
                              ),
                              primarycolor: settings.theme!.secondary,
                              titlecolor: Colors.white,
                              borderColor: Colors.transparent),
                          customGeneralButton(
                              customOnPressed: () {
                                Get.to(() => LoginScreen());
                              },
                              context: context,
                              title: "تسجيل دخول ",
                              newIcon: Icon(
                                Icons.login,
                                color: settings.theme!.secondary,
                              ),
                              primarycolor: Colors.white,
                              titlecolor: settings.theme!.secondary,
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
      ),
    );
  }

// validate the input and making sure no input is missing.
  Future validation(BuildContext contextm) async {
    if (await checkInternetConnection()) {
      // first we check if there is internet connection
      if (_formkey.currentState!.validate()) {
        // then we check if there are any missing fields.
        _formkey.currentState!.save();
        var loginInfo = _formkey.currentState!
            .value; // containes login info extracted from both email and password fields.
        try {
          contextm.read(userStateManagment).setIsLoggingIn();
          requestSignUp(loginInfo);
          contextm.read(userStateManagment).setIsLoggingIn();
          //if the process of loginning is successful, we pop up a message to inform the user of the success.
          Get.defaultDialog(
              barrierDismissible: false,
              title: "تم!",
              middleText: "تم انشاء الحساب بنجاح",
              confirm: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: settings.theme!.secondary),
                  onPressed: () {
                    Get.off(() => LoginScreen());
                  },
                  child: Text("تأكيد")));
        } on Exception catch (e) {
          if (e is DioError) {
            Get.snackbar("Error", e.response!.data.values.toString());
          }
          contextm.read(userStateManagment).setIsLoggingIn();
        }
      }
    } else {
      Get.defaultDialog(title: "خطأ", middleText: "لا يوجد اتصال بالانترنت");
      // if we have missing internet connection
      //.. we pop up a message to the user to inform them that there is missing internet connection
    }
  }
}
