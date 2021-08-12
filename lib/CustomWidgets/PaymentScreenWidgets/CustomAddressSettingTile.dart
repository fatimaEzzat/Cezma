import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/Variables/Settings.dart';

SettingsTile customAddressSettingTile(
        {required width,
        required controller,
        required context,
        required height,
        required locationState,
        required onTap}) =>
    SettingsTile(
      enabled: false,
      titleTextStyle: TextStyle(color: settings.theme!.secondary),
      title: '',
      trailing: Container(
        width: width * 0.8,
        child: FormBuilderTextField(
          controller: controller,
          enabled: true,
          name: 'customAddress',
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
      leading: IgnorePointer(
        ignoring: locationState.isGettingLocation,
        child: InkWell(
          onTap: onTap,
          child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: settings.theme!.secondary)),
              child: locationState.isGettingLocation
                  ? CircularProgressIndicator(
                      color: settings.theme!.secondary,
                    )
                  : Icon(
                      Icons.my_location,
                      color: Colors.red,
                    )),
        ),
      ),
    );
