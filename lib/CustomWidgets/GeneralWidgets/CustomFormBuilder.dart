import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:test_store/Screens/AuthScreens/ResetPasswordCodeScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';
import '../Decorations/CustomFormFieldDecoration.dart';

// this is a customformfield widget in a variable form.
// the context her is sent from the main build context of the widget tree of loginscreen.dart
// it is used to run the validation and get screenwidth proportions.
// the globalkey is sent out from the main class,aswell. to insure the form field is pointing to the right direction(key).

// ignore: must_be_immutable
Widget customformfield(
    {required GlobalKey globalkey,
    required BuildContext context,
    required bool obsecure,
    void onPressed()?}) {
  return FormBuilder(
    key: globalkey,
    child: Column(
      children: [
        Container(
          width: screenWidth(context) * 0.8,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: FormBuilderTextField(
                keyboardType: TextInputType.number,
                name: 'user',
                decoration: customformfielddecoration(
                    hinttext: "الرقم",
                    context: context,
                    obsecure: null,
                    color: offwhite),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.integer(context),
                  FormBuilderValidators.minLength(context, 11),
                  FormBuilderValidators.maxLength(context, 11)
                ])),
          ),
        ),
        SizedBox(
          height: screenHeight(context) * 0.03,
        ),
        Container(
          width: screenWidth(context) * 0.8,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: FormBuilderTextField(
                obscureText: obsecure,
                name: 'password',
                decoration: customformfielddecoration(
                    hinttext: "كلمة السر",
                    context: context,
                    obsecure: obsecure,
                    onPressed: onPressed,
                    color: offwhite),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.minLength(context, 7,
                      errorText:
                          "كلمة السر يجب ان تكون علي الاقل 7 احرف/ارقام/رموز"),
                  FormBuilderValidators.required(
                    context,
                    errorText: "بالرجاء ادخال كلمة السر",
                  )
                ])),
          ),
        ),
        Container(
          width: screenWidth(context) * 0.8,
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.to(() => ResetPasswordScreen());
                      },
                      child: Text(
                        "نسيت كلمة السر؟",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ))),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: FormBuilderCheckbox(
                    checkColor: settings.theme!.primary,
                    activeColor: settings.theme!.secondary,
                    name: "rememberme",
                    title: Text(
                      "تذكرني",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    initialValue: false,
                    tristate: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
