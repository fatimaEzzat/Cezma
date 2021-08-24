import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomFormBuilder.dart';
import 'package:test_store/Logic/ApiRequests/AuthRequests/Login.dart';
import 'package:test_store/Logic/MISC/CheckInternetConnection.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/SecondaryScreens/SplashScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_store/Variables/Settings.dart';

import 'SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visibility = true;
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Those two variables contain screen's size (width and height).
    double height = screenHeight(context);
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) => ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: settings.theme!.secondary,
          ),
          inAsyncCall: watch(userStateManagment).isLoggingIn,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("Assets/Logos/LogoWithoutText.svg"),
                  SizedBox(
                    height: height * 0.10,
                  ),
                  //  this customformfield contains the 2 input fields and the forgot password/remember me checkbox.
                  customformfield(
                    globalkey: _formkey,
                    context: context,
                    obsecure: visibility,
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
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
                        context: context,
                        customOnPressed: () {
                          validation(context);
                        },
                        title: 'تسجيل الدخول',
                        newIcon: Icon(
                          Icons.login,
                          color: settings.theme!.primary,
                        ),
                        primarycolor: Colors.transparent,
                        titlecolor: settings.theme!.primary,
                        borderColor: Colors.transparent),
                  ),
                  customGeneralButton(
                    context: context,
                    customOnPressed: () {
                      Get.to(() => SignupScreen());
                    },
                    title: 'حساب جديد',
                    newIcon: Icon(Icons.person_add, color: Colors.white),
                    primarycolor: petrol,
                    titlecolor: Colors.white,
                    borderColor: Colors.transparent,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
          await requestLogin(loginInfo);
          if (loginInfo['rememberme']) {
            SharedPreferences.getInstance().then((value) {
              value.setString("email", loginInfo["email"]);
            });
          }
          contextm.read(userStateManagment).setIsLoggingIn();
          Get.off(() => CustomSplashScreen());
        } catch (e) {
          contextm.read(userStateManagment).setIsLoggingIn();
          if (e is DioError) {
            Get.snackbar(
                "Error",
                e.response!.statusCode == 401
                    ? "Wrong Username or Email"
                    : "Unkown Error");
          }
        }
      }
    } else {
      Get.defaultDialog(title: "خطأ", middleText: "لا يوجد اتصال بالانترنت");
    }
  }
}
