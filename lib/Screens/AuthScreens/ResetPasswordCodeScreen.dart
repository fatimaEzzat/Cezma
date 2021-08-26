import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Logic/ApiRequests/AuthRequests/ResetPasswordRequest.dart';
import 'package:test_store/Screens/AuthScreens/ChangePasswordScreen.dart';
import 'package:test_store/Screens/AuthScreens/PasswordResetScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: violet,
          ),
        ),
        body: Center(
          child: FormBuilder(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.08,
                ),
                Image.asset("Assets/Logos/ResetPasswordLogo.png"),
                SizedBox(
                  height: screenHeight(context) * 0.05,
                ),
                Text(
                  "هل نسيت كلمة السر ؟",
                  style: TextStyle(color: violet, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Container(
                  width: screenWidth(context) * 0.7,
                  child: Text(
                    "قم بادخال الرقم او البريد الالكتروني الخاص بك لاستلام رابط اعادة تعيين كلمة المرور",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                SizedBox(
                    width: screenWidth(context) * 0.8,
                    child: FormBuilderTextField(
                        name: "phone",
                        decoration: customformfielddecoration(
                            hinttext: "البريد الالكتروني/الهاتف",
                            context: context,
                            color: Colors.grey.shade200),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.integer(context),
                          FormBuilderValidators.minLength(context, 11),
                          FormBuilderValidators.maxLength(context, 11)
                        ]))),
                SizedBox(
                  height: screenHeight(context) * 0.02,
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
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          final info = _formkey.currentState!.value;
                          if (info["phone"][0] != "0") {
                            throw {Get.snackbar("خطأ", "هذا الرقم ليس صحيح")};
                          }
                          try {
                            await requestResetPassword(
                                _formkey.currentState!.value);
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: "تم",
                                middleText: "تم ارسال كود اعادة التعيين",
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  Get.back();
                                  Get.off(() => ChangePasswordScreen());
                                });
                          } catch (e) {
                            if (e is DioError) {
                              Get.snackbar(
                                  "Error", e.response!.data.toString());
                            }
                          }
                        }
                      },
                      context: context,
                      title: "اعادة تعيين كلمة المرور",
                      primarycolor: Colors.transparent,
                      titlecolor: Colors.white,
                      newIcon: Icon(Icons.recommend),
                      borderColor: Colors.transparent),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
