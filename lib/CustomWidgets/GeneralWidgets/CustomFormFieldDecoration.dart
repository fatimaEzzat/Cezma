import 'package:flutter/material.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

// this is the decoration of the textformfields... it's a repetition decoration.
// so i created a variable that could be used multiple times with different variables..
// for example, the hint text.
InputDecoration customformfielddecoration(
        {required String hinttext,
        required BuildContext context,
        obsecure,
        required color,
        border = Colors.transparent,
        prefixIcon,
        onPressed()?}) =>
    InputDecoration(
        suffixIcon: obsecure != null
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(obsecure ? Icons.visibility_off : Icons.visibility))
            : null,
        prefixIcon: prefixIcon,
        isDense: true,
        hintText: hinttext,
        fillColor: color,
        filled: true,
        contentPadding: EdgeInsets.only(
            top: screenHeight(context) * 0.025,
            right: screenWidth(context) * 0.03,
            left: screenWidth(context) * 0.03),
        // ////////
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: border)),
        // ////////
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: border)),
        // ////////
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: settings.theme!.secondary)));
