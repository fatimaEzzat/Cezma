import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';

Widget searchBar({required context, required color}) => FormBuilderTextField(
    cursorColor: Colors.white,
    name: 'search',
    decoration: customformfielddecoration(
        color: color,
        hinttext: "عن ماذا تبحث؟",
        context: context,
        obsecure: null,
        onPressed: () {}),
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.minLength(context, 7,
          errorText: "كلمة السر يجب ان تكون علي الاقل 7 احرف/ارقام/رموز"),
      FormBuilderValidators.required(
        context,
        errorText: "بالرجاء ادخال كلمة السر",
      )
    ]));
