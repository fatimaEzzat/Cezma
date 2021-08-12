import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/Variables/Settings.dart';

SettingsTile govSettingTile(
        {required width,
        required countriesState,
        required formkey,
        required context,
        required height}) =>
    SettingsTile(
      enabled: false,
      title: 'المحافظة:',
      titleTextStyle: TextStyle(color: settings.theme!.secondary),
      trailing: Container(
        width: width * 0.5,
        child: FormBuilderDropdown(
          name: 'gov',
          allowClear: true,
          hint: Text("اختر محافظتك"),
          onChanged: (value) {
            countriesState.setSelectedGov(value);
            formkey.currentState!.fields["city"]!.setValue(null);
          },
          items: countriesState.governorates
              .map<DropdownMenuItem>((e) => DropdownMenuItem(
                    child: Text(
                      e["governorate_name_ar"],
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
          ),
        ),
      ),
      leading: ImageIcon(AssetImage("Images/egypt.png"),
          color: settings.theme!.secondary),
      onPressed: (BuildContext context) {},
    );
