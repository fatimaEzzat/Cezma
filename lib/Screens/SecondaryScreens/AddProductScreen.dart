import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/SubCategoriesRequest.dart';

import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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
        appBar: secondaryAppBar(context: context, title: "اضافة المنتج"),
        body: Center(
          child: FormBuilder(
              key: _fbKey,
              child: Container(
                  width: screenWidth(context) * 0.95,
                  child: ListView(children: [
                    SizedBox(
                      height: screenHeight(context) * 0.04,
                    ),
                    Text(
                      "اضف صور المنتج",
                      style: TextStyle(fontSize: screenWidth(context) * 0.045),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.02,
                    ),
                    Container(
                      height: screenHeight(context) * 0.08,
                      child: ListView(
                        children: [
                          Image.asset(
                            "Assets/Images/PlaceHolderImage.jpeg",
                          ),
                        ],
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.02,
                    ),
                    Card(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
                      child: Container(
                        child: FormBuilderTextField(
                            name: 'productName',
                            decoration: customformfielddecoration(
                                hinttext: "اسم المنتج",
                                context: context,
                                border: Colors.grey,
                                color: Colors.white),
                            validator: FormBuilderValidators.required(
                              context,
                              errorText: "ادخل اسم المنتج",
                            )),
                      ),
                    ),
                    Card(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
                      child: Container(
                        child: FormBuilderTextField(
                            maxLines: 5,
                            name: 'productDescription',
                            decoration: customformfielddecoration(
                                hinttext: "وصف المنتج",
                                context: context,
                                border: Colors.grey,
                                color: Colors.white),
                            validator: FormBuilderValidators.required(
                              context,
                              errorText: "ادخل وصف المنتج",
                            )),
                      ),
                    ),
                    Card(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
                      child: FormBuilderDropdown(
                          onChanged: (value) async {
                            _fbKey.currentState!
                              ..fields["subCategories"]!.reset();
                            setState(() {
                              isLoading = !isLoading;
                            });
                            subCategories = await requestSubCategories(
                                context, int.parse(value.toString()));
                            setState(() {
                              isLoading = !isLoading;
                            });
                          },
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
                                    value: e["id"],
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
                          enabled: !isLoading,
                          validator: FormBuilderValidators.required(
                            context,
                            errorText: "اختر القسم الفرعي",
                          ),
                          decoration: customformfielddecoration(
                              enabled: !isLoading,
                              hinttext: "القسم الفرعي",
                              context: context,
                              border: Colors.grey,
                              color: Colors.white),
                          name: "subCategories",
                          items: subCategories
                              .map((e) => DropdownMenuItem(
                                    value: e["id"],
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
                      child: Container(
                        child: FormBuilderTextField(
                            name: 'price',
                            decoration: customformfielddecoration(
                                hinttext: "السعر",
                                context: context,
                                border: Colors.grey,
                                color: Colors.white),
                            validator: FormBuilderValidators.required(
                              context,
                              errorText: "ادخل السعر",
                            )),
                      ),
                    ),
                    Card(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
                      child: Container(
                        child: FormBuilderTextField(
                            name: 'discountedPrice',
                            decoration: customformfielddecoration(
                                hinttext: "السعر بعد الخصم",
                                context: context,
                                border: Colors.grey,
                                color: Colors.white),
                            validator: FormBuilderValidators.required(
                              context,
                              errorText: "",
                            )),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.054,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: new LinearGradient(colors: [
                            Colors.blue.shade900,
                            Colors.purple.shade900
                          ])),
                      child: customGeneralButton(
                          customOnPressed: () {
                            _fbKey.currentState!.validate();
                          },
                          context: context,
                          title: "اضف المنتج",
                          primarycolor: Colors.transparent,
                          titlecolor: Colors.white,
                          newIcon: Icon(Icons.add),
                          borderColor: Colors.transparent),
                    )
                  ]))),
        ),
      ),
    );
  }
}
