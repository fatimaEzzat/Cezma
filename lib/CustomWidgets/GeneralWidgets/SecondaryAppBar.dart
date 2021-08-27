import 'package:flutter/material.dart';

AppBar secondaryAppBar(
        {required BuildContext context,
        required String title,
        Icon secondary = const Icon(
          Icons.ac_unit,
          size: 0,
        ),
        Function()? onSecondaryPressed,
        Function()? onPressed}) =>
    AppBar(
      flexibleSpace: Container(
          decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.blue.shade900, Colors.purple.shade900]),
      )),
      leading: BackButton(
        color: Colors.white,
        onPressed: onPressed,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      actions: [IconButton(onPressed: onSecondaryPressed, icon: secondary)],
      centerTitle: true,
    );
