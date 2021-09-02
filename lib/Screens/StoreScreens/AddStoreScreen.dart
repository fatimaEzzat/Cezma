import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/StoresRequest/AddStoreRequest.dart';
import 'package:test_store/Logic/ApiRequests/TagsRequest.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Logic/StateManagment/PlansState.dart';
import 'package:test_store/Logic/StateManagment/TagsState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Variables/Settings.dart';

class AddStoreScreen extends StatefulWidget {
  const AddStoreScreen({Key? key}) : super(key: key);

  @override
  _AddStoreScreenState createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  var _fbKey;
  bool isLoading = false;
  List categories = [];
  int selectedPlan = 0;
  List plans = [];
  List tags = [];
  bool isLoadingItems = false;
  TextEditingController _textEditingController = TextEditingController();
  final _carouselController = CarouselController();
  @override
  void initState() {
    _fbKey = GlobalKey<FormBuilderState>();
    categories = context.read(categoriesStateManagment).allCategories;
    plans = context.read(plansStateManagment).plans;
    tags = context.read(tagsStateManagment).tags;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(context: context, title: "اضافة متجر"),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: CircularProgressIndicator(
            color: violet,
          ),
          child: Center(
            child: Container(
              width: screenWidth(context) * 0.95,
              child: FormBuilder(
                key: _fbKey,
                child: SingleChildScrollView(
                  child: Column(
                    // addAutomaticKeepAlives: true,
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
                        child: FormBuilderTextField(
                          name: 'description',
                          maxLines: 5,
                          decoration: customformfielddecoration(
                              labelText: "وصف المتجر",
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
                              labelText: "العنوان",
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
                              labelText: "البريد الالكتروني",
                              context: context,
                              border: Colors.grey,
                              color: Colors.white),
                          name: "email",
                        ),
                      ),
                      Container(
                        child: CarouselSlider.builder(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                                enableInfiniteScroll: false, aspectRatio: 2.4),
                            itemCount: plans.length,
                            itemBuilder: (context, index, pageindex) {
                              late final discount;
                              if (plans[index]["discount"] != null) {
                                discount = (plans[index]["discount"] /
                                        plans[index]["price"]) *
                                    100;
                              }
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedPlan = plans[index]["id"];
                                    _textEditingController.text =
                                        plans[index]["name"];
                                    _fbKey.currentState!.fields["plan_id"]!
                                        // ignore: invalid_use_of_protected_member
                                        .setValue(
                                            plans[index]["id"].toString());
                                  });
                                },
                                child: Card(
                                  elevation: 0.5,
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: selectedPlan == plans[index]["id"]
                                          ? BorderSide(color: violet, width: 2)
                                          : BorderSide.none),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  plans[index]["name"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(plans[index]["price"]
                                                        .toString() +
                                                    " جم " +
                                                    "(" +
                                                    plans[index]["type"] +
                                                    ")"),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  screenHeight(context) * 0.01,
                                            )
                                          ],
                                        ),
                                        subtitle: Text(
                                          plans[index]["description"],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenWidth(context) * 0.04),
                                        child: customGeneralButton(
                                            customOnPressed: () {
                                              Get.defaultDialog(
                                                  title: "مواصفات الباقة",
                                                  content: Column(
                                                    children: plans[index]
                                                            ["features"]
                                                        .map<Widget>((e) =>
                                                            Text(e["feature"]))
                                                        .toList(),
                                                  ));
                                            },
                                            context: context,
                                            title: "موصفات",
                                            primarycolor: violet,
                                            titlecolor: Colors.white,
                                            newIcon: Icon(Icons.info),
                                            borderColor: Colors.transparent),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: FormBuilderTextField(
                          validator: FormBuilderValidators.required(context,
                              errorText: "يجب اخيار باقة"),
                          controller: _textEditingController,
                          enabled: false,
                          name: "plan_id",
                          decoration: customformfielddecoration(
                              labelText: "الباقة",
                              context: context,
                              border: Colors.grey,
                              color: Colors.white),
                        ),
                      ),
                      Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: FormBuilderTextField(
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.required(context),
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
                              labelText: "رقم الهاتف",
                              context: context,
                              border: Colors.grey,
                              color: Colors.white),
                        ),
                      ),
                      Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: FormBuilderTextField(
                            name: 'name',
                            decoration: customformfielddecoration(
                                labelText: "اسم المتجر",
                                context: context,
                                border: Colors.grey,
                                color: Colors.white),
                            validator: FormBuilderValidators.required(
                              context,
                              errorText: "بالرجاء ادخال اسم المتجر",
                            )),
                      ),
                      Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Container(
                          child: FormBuilderTextField(
                              name: 'username',
                              decoration: customformfielddecoration(
                                  labelText: "اسم المستخدم",
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
                          child: Text("اختار الصنف")),
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
                          child: Text("اختار العلامة")),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await loadMoreTags();
                              },
                              icon: isLoadingItems
                                  ? CircularProgressIndicator()
                                  : Icon(Icons.refresh)),
                          Expanded(
                            child: Card(
                                color: Colors.transparent,
                                shadowColor: Colors.transparent,
                                child: FormBuilderFilterChip(
                                  name: 'tags',
                                  options: tags
                                      .map((e) => FormBuilderFieldOption(
                                            value: e["id"],
                                            child: Text(e["name"]),
                                          ))
                                      .toList(),
                                )),
                          ),
                        ],
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
                            customOnPressed: () async {
                              await validation();
                            },
                            context: context,
                            title: "اضف المتجر",
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
        ),
      ),
    );
  }

  Future<void> validation() async {
    if (_fbKey.currentState!.validate()) {
      _fbKey.currentState!.save();
      final storeInfo = _fbKey.currentState!.value;
      setState(() {
        isLoading = !isLoading;
      });
      if (storeInfo["phone"][0] != "0") {
        setState(() {
          isLoading = !isLoading;
        });
        throw {Get.snackbar("خطأ", "هذا الرقم ليس صحيح")};
      }

      await requestAddStore(context: context, storeInfo: storeInfo);
      setState(() {
        isLoading = !isLoading;
      });
    }
  }

  Future<void> loadMoreTags() async {
    if (context.read(tagsStateManagment).tagsCurrentPage <=
        context.read(tagsStateManagment).tagsLastPage) {
      setState(() {
        isLoading = !isLoading;
      });

      await requestTags(
          context, false, context.read(tagsStateManagment).tagsCurrentPage);

      setState(() {
        isLoadingItems = !isLoadingItems;
      });
    }
  }
}
