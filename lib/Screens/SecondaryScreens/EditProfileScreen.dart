import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomGeneralButton.dart';
import 'package:test_store/Logic/ApiRequests/RequestsExport.dart';
import 'package:test_store/Logic/StateManagment/CountriesState.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/AuthScreens/PasswordResetScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? _userPassword;
  @override
  void initState() {
    _userPassword = context.read(userStateManagment).userPassword;
    super.initState();
  }

  final _formkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                context.read(countriesStateManagment).setSelectedGov(null);
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer(builder: (context, watch, child) {
          final state = watch(userStateManagment);
          return Column(
            children: [
              FormBuilder(
                key: _formkey,
                child: Expanded(
                    child: ListView(
                  children: [
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("الاسم الاول"),
                        subtitle: FormBuilderTextField(
                          validator: FormBuilderValidators.required(context,
                              errorText: "بالرجاء ادخال الاسم الاول"),
                          initialValue: state.userInfo!.firstName,
                          name: 'first_name',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "الاسم الاول",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: settings.theme!.secondary)),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("أسم العائلة"),
                        subtitle: FormBuilderTextField(
                          validator: FormBuilderValidators.required(context,
                              errorText: "بالرجاء ادخال الاسم الاخير"),
                          name: 'last_name',
                          initialValue: state.userInfo!.secondName,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "أسم العائلة",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: settings.theme!.secondary)),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("رقم الهاتف"),
                        subtitle: FormBuilderTextField(
                          validator: FormBuilderValidators.integer(context,
                              errorText: "بالرجاء ادخال رقم الهاتف"),
                          initialValue: state.userInfo!.phone,
                          name: 'phone',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "رقم الهاتف",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: settings.theme!.secondary)),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("العنوان"),
                        subtitle: FormBuilderTextField(
                          validator: FormBuilderValidators.required(context,
                              errorText: "بالرجاء ادخال العنوان"),
                          initialValue: state.userInfo!.address,
                          name: 'address',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "العنوان",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: settings.theme!.secondary)),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("البريد الاكتروني"),
                        subtitle: FormBuilderTextField(
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context,
                                errorText: "بالرجاء ادخال البريد الالكتروني"),
                            FormBuilderValidators.email(context,
                                errorText: "بالرجاء ادخال بريد الكتروني صحيح"),
                          ]),
                          initialValue: state.userInfo!.email,
                          name: 'email',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "البريد الاكتروني",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: settings.theme!.secondary)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              Card(
                elevation: 0.2,
                child: ListTile(
                  title: Text("كلمة السر"),
                  subtitle: TextFormField(
                    obscureText: true,
                    initialValue: _userPassword,
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: offwhite,
                      hintText: "كلمة السر",
                      labelStyle: TextStyle(),
                      contentPadding: EdgeInsets.only(
                          top: height * 0.04, right: width * 0.05),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: settings.theme!.secondary)),
                    ),
                  ),
                ),
              ),
              customGeneralButton(
                  customOnPressed: () async {
                    await validation();
                  },
                  context: context,
                  title: "حفظ البيانات الشخصية",
                  primarycolor: settings.theme!.secondary,
                  titlecolor: Colors.white,
                  newIcon: Icon(
                    Icons.done,
                    color: Colors.white,
                  )),
              customGeneralButton(
                  customOnPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return PasswordResetScreen();
                    }));
                  },
                  context: context,
                  title: "تغيير كلمة السر",
                  primarycolor: Colors.white,
                  titlecolor: settings.theme!.secondary,
                  newIcon: Icon(
                    Icons.change_circle,
                    color: settings.theme!.secondary,
                  ))
            ],
          );
        }),
      ),
    );
  }

  Future validation() async {
    var pref = await SharedPreferences.getInstance();
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      var editInfo = _formkey.currentState!.value;
      Get.defaultDialog(
          title: "Confirmation",
          content: Text("هل انت واثق من تغيير تلك المعلومات عن حسابك؟"),
          confirm: ElevatedButton(
            child: Text(
              "لا",
              style: TextStyle(color: settings.theme!.secondary),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          cancel: ElevatedButton(
            child: Text("نعم"),
            style: ElevatedButton.styleFrom(
              primary: settings.theme!.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () async {
              try {
                Get.back();
                Get.defaultDialog(
                    title: "جاري التنفيذ",
                    content: CircularProgressIndicator(
                      color: settings.theme!.secondary,
                    ),
                    barrierDismissible: false);
                await requestChangeInfo(
                    pref.getString("token"), editInfo, context);
                Get.back();
                Get.defaultDialog(
                  barrierDismissible: false,
                  title: "!تم بنجاح",
                  content: Icon(Icons.check_circle),
                  confirm: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: settings.theme!.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    onPressed: () {
                      _formkey.currentState!.reset();
                      Get.back();
                    },
                    child: Text(
                      "تأكيد",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } on Exception catch (e) {
                Get.back();
                Get.back(); //we back two times to cancel the 2 dialogs.
                Get.snackbar("Error", e.toString());
              }
            },
          ));
    }
  }
}
