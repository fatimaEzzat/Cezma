import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Screens/AuthScreens/LoginScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({Key? key}) : super(key: key);

  @override
  _ActivationScreenState createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.off(() => LoginScreen());
              },
              icon: Icon(
                Icons.cancel,
                color: violet,
              )),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("Assets/Logos/design.png"),
              SizedBox(
                height: screenHeight(context) * 0.05,
              ),
              Text(
                "تفعيل الحساب",
                style: TextStyle(color: violet, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              Text(
                "قم بادخال الاربع ارقام الذي تم ارسالهم اليك",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              SizedBox(
                width: screenWidth(context) * 0.7,
                child: PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    activeColor: Colors.grey,
                    disabledColor: Colors.grey.shade200,
                    inactiveColor: Colors.grey.shade200,
                    selectedColor: Colors.grey.shade200,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.grey.shade200,
                    shape: PinCodeFieldShape.circle,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                  onChanged: (String value) {},
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              Container(
                height: screenHeight(context) * 0.045,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: new LinearGradient(
                      colors: [Colors.blue.shade900, Colors.purple.shade900]),
                ),
                child: customGeneralButton(
                    customOnPressed: () {},
                    context: context,
                    title: "تفعيل الحساب",
                    primarycolor: Colors.transparent,
                    titlecolor: Colors.white,
                    newIcon: Icon(Icons.recommend),
                    borderColor: Colors.transparent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
