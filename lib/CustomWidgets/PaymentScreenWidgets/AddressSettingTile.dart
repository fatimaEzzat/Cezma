import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/Variables/Settings.dart';

SettingsTile addressSettingTile(
        {required width,
        required controller,
        required context,
        required height}) =>
    SettingsTile(
      enabled: false,
      titleTextStyle: TextStyle(color: settings.theme!.secondary),
      title: 'العنوان:',
      trailing: Container(
        width: width * 0.5,
        child: FormBuilderTextField(
          controller: controller,
          enabled: false,
          name: 'address',
          cursorColor: settings.theme!.secondary,
          validator: FormBuilderValidators.required(context, errorText: ""),
          decoration: InputDecoration(
            errorStyle: TextStyle(height: 0),
            contentPadding: EdgeInsets.only(
              top: height * 0.02,
              right: width * 0.05,
            ),
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: settings.theme!.secondary)),
          ),
        ),
      ),
      leading: Icon(Icons.location_on, color: settings.theme!.secondary),
      onPressed: (BuildContext context) {},
    );
