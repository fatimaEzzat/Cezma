import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight(context) * 0.08,
              ),
              SvgPicture.asset("Assets/Logos/LogoWithoutText.svg"),
              SizedBox(
                height: screenHeight(context) * 0.05,
              ),
              Text(
                "اعادة تعيين كلمة السر",
                style: TextStyle(
                    color: violet,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth(context) * 0.05),
              ),
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              Container(
                width: screenWidth(context) * 0.7,
                child: Text(
                  "قم باداخل كلمة المرور الجديدة",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: SizedBox(
                    width: screenWidth(context) * 0.8,
                    child: FormBuilderTextField(
                      name: "password",
                      decoration: customformfielddecoration(
                          hinttext: "كلمة المرور الجديدة",
                          context: context,
                          color: Colors.grey.shade200),
                    )),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: SizedBox(
                    width: screenWidth(context) * 0.8,
                    child: FormBuilderTextField(
                      name: "password_confirmation",
                      decoration: customformfielddecoration(
                          hinttext: "تأكيد كلمة المرور ",
                          context: context,
                          color: Colors.grey.shade200),
                    )),
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
                    title: "اعادة تعيين كلمة المرور",
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
