import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddStoreScreen extends StatefulWidget {
  const AddStoreScreen({Key? key}) : super(key: key);

  @override
  _AddStoreScreenState createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
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
              child: ListView(
                children: [
                  SizedBox(
                    height: screenHeight(context) * 0.03,
                  ),
                  new Container(
                      child: Text(
                    "اضف متجرك لدينا",
                    style: TextStyle(fontSize: screenWidth(context) * 0.05),
                  )),
                
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
                          name: 'storename',
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
                    child: FormBuilderTextField(
                        name: 'storedesc',
                        maxLines: 5,
                        decoration: customformfielddecoration(
                            hinttext: "وصف المتجر",
                            context: context,
                            border: Colors.grey,
                            color: Colors.white),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            context,
                            errorText: "بالرجاء ادخال الوصف",
                          )
                        ])),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: FormBuilderDropdown(
                        validator: FormBuilderValidators.required(
                          context,
                          errorText: "اختر القسم الرئيسي",
                        ),
                        decoration: customformfielddecoration(
                            hinttext: "القسم الرئيسي",
                            context: context,
                            border: Colors.grey,
                            color: Colors.white),
                        name: "mainCategories",
                        items: context
                            .read(categoriesStateManagment)
                            .categories
                            .map((e) => DropdownMenuItem(
                                  child: AutoSizeText(
                                    e["name"],
                                    maxLines: 1,
                                  ),
                                ))
                            .toList()),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: FormBuilderDropdown(
                        validator: FormBuilderValidators.required(
                          context,
                          errorText: "اختر القسم الفرعي",
                        ),
                        decoration: customformfielddecoration(
                            hinttext: "القسم الفرعي",
                            context: context,
                            border: Colors.grey,
                            color: Colors.white),
                        name: "subCategories",
                        items: context
                            .read(categoriesStateManagment)
                            .categories
                            .map((e) => DropdownMenuItem(
                                  child: AutoSizeText(
                                    e["name"],
                                    maxLines: 1,
                                  ),
                                ))
                            .toList()),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: FormBuilderTextField(
                      validator: FormBuilderValidators.required(
                        context,
                        errorText: "ادخل الرقم",
                      ),
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
                      name: "phone",
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: FormBuilderTextField(
                      validator: FormBuilderValidators.required(
                        context,
                        errorText: "ادخل العنوان",
                      ),
                      decoration: customformfielddecoration(
                          hinttext: "العنوان",
                          context: context,
                          border: Colors.grey,
                          color: Colors.white),
                      name: "address",
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
