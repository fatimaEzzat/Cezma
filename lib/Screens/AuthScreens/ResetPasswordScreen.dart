import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Screens/AuthScreens/LoginScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: violet,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("Assets/Images/ResetPasswordLogo.png"),
              SizedBox(
                height: screenHeight(context) * 0.05,
              ),
              Text(
                "هل نسيت كلمة السر ؟",
                style: TextStyle(color: violet, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              Container(
                width: screenWidth(context) * 0.7,
                child: Text(
                  "قم بادخال الرقم او البريد الالكتروني الخاص بك لاستلام رابط اعادة تعيين كلمة المرور",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              SizedBox(
                  width: screenWidth(context) * 0.8,
                  child: FormBuilderTextField(
                    name: "phone",
                    decoration: customformfielddecoration(
                        hinttext: "البريد الالكتروني/الهاتف",
                        context: context,
                        color: Colors.grey.shade200),
                  )),
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
