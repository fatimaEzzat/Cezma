import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomFormFieldDecoration.dart';

AppBar searchBar({required context}) => AppBar(
      elevation: 0,
      centerTitle: true,
      title: Container(
        height: 40,
        child: FormBuilderTextField(
            cursorColor: Colors.white,
            name: 'search',
            decoration: customformfielddecoration(
                color: Colors.white.withOpacity(0.3),
                hinttext: "عن ماذا تبحث؟",
                context: context,
                obsecure: null,
                onPressed: () {}),
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
      flexibleSpace: Container(
          decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.blue.shade900, Colors.purple.shade900]),
      )),
    );
