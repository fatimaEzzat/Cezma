import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/StoresRequest/AddProductRequest.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class AddProductScreen extends StatefulWidget {
  final String storeName;
  const AddProductScreen({Key? key, required this.storeName}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late GlobalKey<FormBuilderState> _fbKey;
  List categories = [];
  bool isAdding = false;

  @override
  void initState() {
    categories.addAll(context.read(categoriesStateManagment).categories);
    context.read(categoriesStateManagment).categories.forEach((element) {
      categories.addAll(element["sub"]);
    });
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
          child: ModalProgressHUD(
            inAsyncCall: isAdding,
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
                        style:
                            TextStyle(fontSize: screenWidth(context) * 0.045),
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
                              name: 'name',
                              decoration: customformfielddecoration(
                                  labelText: "اسم المنتج",
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
                          child: FormBuilderDropdown(
                            name: 'type',
                            decoration: customformfielddecoration(
                                labelText: "النوع",
                                context: context,
                                border: Colors.grey,
                                color: Colors.white),
                            validator: FormBuilderValidators.required(
                              context,
                              errorText: "اختر نوع المنتج",
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Text("Products"),
                                value: "products",
                              ),
                              DropdownMenuItem(
                                child: Text("service"),
                                value: "service",
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Container(
                          child: FormBuilderTextField(
                              name: 'weight',
                              decoration: customformfielddecoration(
                                  labelText: "الوزن",
                                  context: context,
                                  border: Colors.grey,
                                  color: Colors.white),
                              validator: FormBuilderValidators.required(
                                context,
                                errorText: "ادخل وزن المنتج",
                              )),
                        ),
                      ),
                      Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Container(
                          child: FormBuilderTextField(
                              maxLines: 5,
                              name: 'description',
                              decoration: customformfielddecoration(
                                  labelText: "وصف المنتج",
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
                          child: FormBuilderFilterChip(
                            name: 'categories',
                            options: categories
                                .map((e) => FormBuilderFieldOption(
                                      value: e["id"],
                                      child: Text(e["name"]),
                                    ))
                                .toList(),
                          )),
                      Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Container(
                          child: FormBuilderTextField(
                              keyboardType: TextInputType.number,
                              name: 'price',
                              decoration: customformfielddecoration(
                                  labelText: "السعر",
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
                            keyboardType: TextInputType.number,
                            name: 'discount',
                            decoration: customformfielddecoration(
                                labelText: "خصم (اختياري)",
                                context: context,
                                border: Colors.grey,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.054,
                      ),
                      Container(
                        height: screenHeight(context) * 0.045,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: new LinearGradient(colors: [
                              Colors.blue.shade900,
                              Colors.purple.shade900
                            ])),
                        child: customGeneralButton(
                            customOnPressed: () async {
                              if (_fbKey.currentState!.validate()) {
                                _fbKey.currentState!.save();
                                if (_fbKey.currentState!.fields["categories"]!
                                    .value.isEmpty) {
                                  throw {
                                    Get.defaultDialog(
                                        title: "خطأ",
                                        middleText: "اختر الصنف",
                                        confirm: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: violet),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("تاكيد")))
                                  };
                                }
                                setState(() {
                                  isAdding = !isAdding;
                                });
                                await requestAddProduct(
                                    productInfo: _fbKey.currentState!.value,
                                    context: context,
                                    storeName: widget.storeName);

                                setState(() {
                                  isAdding = !isAdding;
                                });
                              }
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
      ),
    );
  }
}
