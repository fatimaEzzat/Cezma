import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/Variables/Settings.dart';

SettingsTile citySettingTile(
        {required width,
        required countriesState,
        required context,
        required height}) =>
    SettingsTile(
      enabled: false,
      titleTextStyle: TextStyle(color: settings.theme!.secondary),
      title: 'المدينة:',
      trailing: Container(
        width: width * 0.5,
        child: FormBuilderDropdown(
          name: 'city',
          allowClear: true,
          hint: Text("اختر المدينة"),
          enabled: countriesState.selectedGov != null,
          items: countriesState.cities
              .where((element) {
                if (element["governorate_id"] == countriesState.selectedGov) {
                  return true;
                } else {
                  return false;
                }
              })
              .map<DropdownMenuItem>((e) => DropdownMenuItem(
                    child: Text(
                      e["city_name_ar"],
                      textAlign: TextAlign.center,
                    ),
                    value: e["id"],
                  ))
              .toList(),
          validator: FormBuilderValidators.required(context, errorText: ""),
          decoration: InputDecoration(
            errorStyle: TextStyle(height: 0),
            contentPadding:
                EdgeInsets.only(top: height * 0.015, right: width * 0.05),
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: settings.theme!.secondary)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      ),
      leading: ImageIcon(AssetImage("Images/buildings.png"),
          color: settings.theme!.secondary),
      onPressed: (BuildContext context) {},
    );
