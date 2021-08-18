import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formkey = GlobalKey<FormBuilderState>();
  bool visibility = false;
  bool visibilityRe = false;
  // we use these two variables to manage and check if the input is to be visible or not.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: ImageIcon(
                AssetImage("Images/arrow.png"),
                color: settings.theme!.secondary,
              ))
        ],
        title: Text(
          "تعديل البينات الشخصية",
          style: TextStyle(color: settings.theme!.secondary),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: FormBuilder(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "Images/secure.png",
                    scale: screenWidth(context) * 0.007,
                    color: Colors.grey,
                  ),
                  Text(
                    "اعادة تعيين كلمة المرور",
                    style: TextStyle(
                        fontSize: screenWidth(context) * 0.07,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "قم بادخال كلمة مرور الجديدة",
                    style: TextStyle(
                        fontSize: screenWidth(context) * 0.06,
                        color: settings.theme!.secondary),
                  ),
                  Container(
                    width: screenWidth(context) * 0.8,
                    child: FormBuilderTextField(
                      validator: FormBuilderValidators.required(context),
                      name: 'newpassword',
                      obscureText: visibility,
                      decoration: InputDecoration(
                          suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                              },
                              icon: Icon(visibility
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          isDense: true,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: settings.theme!.secondary)),
                          fillColor: offwhite,
                          filled: true,
                          hintText: "كلمة المرور الجديدة"),
                    ),
                  ),
                  Container(
                    width: screenWidth(context) * 0.8,
                    child: FormBuilderTextField(
                      validator: FormBuilderValidators.required(context),
                      name: 'newpassword_re',
                      obscureText: visibilityRe,
                      decoration: InputDecoration(
                          suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibilityRe = !visibilityRe;
                                });
                              },
                              icon: Icon(visibilityRe
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          isDense: true,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: settings.theme!.secondary)),
                          fillColor: offwhite,
                          filled: true,
                          hintText: "تأكيد كلمة المرور"),
                    ),
                  ),
                  customGeneralButton(
                      customOnPressed: () {},
                      context: context,
                      title: "اعادة تعيين كلمة المرور",
                      primarycolor: settings.theme!.secondary,
                      titlecolor: Colors.white,
                      newIcon: Icon(Icons.change_circle),
                      borderColor: Colors.transparent)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
