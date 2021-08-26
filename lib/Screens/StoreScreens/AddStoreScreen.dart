import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/SubCategoriesRequest.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Logic/StateManagment/PlansState.dart';
import 'package:test_store/Screens/SecondaryScreens/PlansScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddStoreScreen extends StatefulWidget {
  const AddStoreScreen({Key? key}) : super(key: key);

  @override
  _AddStoreScreenState createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  late GlobalKey<FormBuilderState> _fbKey;
  bool isLoading = false;
  List subCategories = [];
  @override
  void initState() {
    _fbKey = GlobalKey<FormBuilderState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(context: context, title: "اضافة متجر"),
        body: Center(
          child: new Container(
            width: screenWidth(context) * 0.9,
            child: FormBuilder(
              key: _fbKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: screenHeight(context) * 0.03,
                  ),
                  CircleAvatar(
                    radius: screenHeight(context) * 0.06,
                  ),
                  SizedBox(
                    height: screenHeight(context) * 0.05,
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: Container(
                      child: FormBuilderTextField(
                          name: 'name',
                          decoration: customformfielddecoration(
                              hinttext: "اسم المتجر",
                              context: context,
                              border: Colors.grey,
                              color: Colors.white),
                          validator: FormBuilderValidators.required(
                            context,
                            errorText: "بالرجاء ادخال اسم المتجر",
                          )),
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: Container(
                      child: FormBuilderTextField(
                          name: 'username',
                          decoration: customformfielddecoration(
                              hinttext: "اسم المستخدم",
                              context: context,
                              border: Colors.grey,
                              color: Colors.white),
                          validator: FormBuilderValidators.required(
                            context,
                            errorText: "بالرجاء ادخال اسم المستخدم",
                          )),
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: FormBuilderTextField(
                      name: 'description',
                      maxLines: 5,
                      decoration: customformfielddecoration(
                          hinttext: "وصف المتجر",
                          context: context,
                          border: Colors.grey,
                          color: Colors.white),
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: FormBuilderTextField(
                      name: "phone",
                      decoration: customformfielddecoration(
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "20+",
                                style: TextStyle(color: violet),
                              ),
                            ],
                          ),
                          hinttext: "رقم الهاتف",
                          context: context,
                          border: Colors.grey,
                          color: Colors.white),
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: FormBuilderTextField(
                      name: "address",
                      decoration: customformfielddecoration(
                          hinttext: "العنوان",
                          context: context,
                          border: Colors.grey,
                          color: Colors.white),
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: FormBuilderTextField(
                      decoration: customformfielddecoration(
                          hinttext: "البريد الالكتروني",
                          context: context,
                          border: Colors.grey,
                          color: Colors.white),
                      name: "email",
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: FormBuilderTextField(
                      enabled: false,
                      name: "plan",
                      decoration: customformfielddecoration(
                          hinttext: "الباقة",
                          context: context,
                          border: Colors.grey,
                          color: Colors.white),
                    ),
                  ),
                  
                  SizedBox(
                    height: screenHeight(context) * 0.03,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: new LinearGradient(colors: [
                          Colors.blue.shade900,
                          Colors.purple.shade900
                        ])),
                    child: customGeneralButton(
                        customOnPressed: () {},
                        context: context,
                        title: "حفظ التعديلات",
                        primarycolor: Colors.transparent,
                        titlecolor: Colors.white,
                        newIcon: Icon(Icons.add),
                        borderColor: Colors.transparent),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
