import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/RequestsExport.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/AuthScreens/LoginScreen.dart';
import 'package:test_store/Screens/AuthScreens/PasswordResetScreen.dart';
import 'package:test_store/Screens/NavBarScreens/NavigationBar.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class EditProfilePage extends StatefulWidget {
  final isVerifying;
  const EditProfilePage({Key? key, this.isVerifying = false}) : super(key: key);

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: secondaryAppBar(
            context: context,
            title: "تعديل البينات الشخصية",
            onPressed: () {
              widget.isVerifying ? Get.off(() => LoginScreen()) : Get.back();
            }),
        body: Consumer(builder: (context, watch, child) {
          final state = watch(userStateManagment);
          return SafeArea(
            child: Column(
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
                          title: Text("البريد الاكتروني"),
                          subtitle: FormBuilderTextField(
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: "بالرجاء ادخال البريد الالكتروني"),
                              FormBuilderValidators.email(context,
                                  errorText:
                                      "بالرجاء ادخال بريد الكتروني صحيح"),
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
                Container(
                  height: screenHeight(context) * 0.045,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: new LinearGradient(
                        colors: [Colors.blue.shade900, Colors.purple.shade900]),
                  ),
                  child: customGeneralButton(
                      customOnPressed: () async {
                        await validation();
                      },
                      context: context,
                      title: "حفظ البيانات الشخصية",
                      primarycolor: Colors.transparent,
                      titlecolor: Colors.white,
                      newIcon: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      borderColor: Colors.transparent),
                ),
                customGeneralButton(
                    customOnPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return PasswordResetScreen();
                      }));
                    },
                    context: context,
                    title: "تغيير كلمة السر",
                    primarycolor: petrol,
                    titlecolor: Colors.white,
                    newIcon: Icon(
                      Icons.change_circle,
                      color: Colors.white,
                    ),
                    borderColor: Colors.transparent)
              ],
            ),
          );
        }),
      ),
    );
  }

  Future validation() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      var editInfo = _formkey.currentState!.value;
      Get.defaultDialog(
          title: "Confirmation",
          content: Text("هل انت واثق من تغيير تلك المعلومات عن حسابك؟    "),
          textConfirm: "نعم",
          buttonColor: violet,
          confirmTextColor: Colors.white,
          onConfirm: () async {
            try {
              Get.back();
              Get.defaultDialog(
                  title: "جاري التنفيذ",
                  content: CircularProgressIndicator(
                    color: violet,
                  ),
                  barrierDismissible: false);
              await requestChangeInfo(
                  context.read(userStateManagment).userToken,
                  editInfo,
                  context);
              Get.back();
              Get.defaultDialog(
                barrierDismissible: false,
                title: "!تم بنجاح",
                content: Icon(Icons.check_circle),
                buttonColor: violet,
                confirmTextColor: Colors.white,
                onConfirm: () {
                  _formkey.currentState!.reset();

                  Get.offAll(() => CustomNavigationBar());
                },
              );
            } on Exception catch (e) {
              Get.back();
              Get.back(); //we back two times to cancel the 2 dialogs.
              Get.snackbar("Error", e.toString());
            }
          },
          textCancel: "لا",
          cancelTextColor: violet,
          onCancel: () {
            Get.back();
          });
    }
  }
}
