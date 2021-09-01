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
import 'package:test_store/Logic/ApiRequests/StoresRequest/EditStoreRequest.dart';
import 'package:test_store/Logic/ApiRequests/TagsRequest.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Logic/StateManagment/PlansState.dart';
import 'package:test_store/Logic/StateManagment/TagsState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Variables/Settings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EditStoreScreen extends StatefulWidget {
  final Map store;
  const EditStoreScreen({Key? key, required this.store}) : super(key: key);

  @override
  _EditStoreScreenState createState() => _EditStoreScreenState();
}

class _EditStoreScreenState extends State<EditStoreScreen> {
  late GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
 
  bool isLoading = false;
  List categories = [];
  int selectedPlan = 0;
  List plans = [];
  List tags = [];
  bool isLoadingItems = false;
  Map storeInfo = {};
  bool isChanged = false;
  TextEditingController _textEditingController = TextEditingController();
  final _carouselController = CarouselController();
  @override
  void initState() {
    categories = context.read(categoriesStateManagment).allCategories;
    plans = context.read(plansStateManagment).plans;
    tags = context.read(tagsStateManagment).tags;
    selectedPlan = widget.store["plan_id"];
    _textEditingController.text = widget.store["plan_id"].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(context: context, title: "تعديل المتجر"),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Center(
            child: Container(
              width: screenWidth(context) * 0.9,
              child: FormBuilder(
                key: _fbKey,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
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
                          initialValue: widget.store["description"],
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
                          initialValue: widget.store["address"],
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
                          initialValue: widget.store["email"],
                          decoration: customformfielddecoration(
                              labelText: "البريد الالكتروني",
                              context: context,
                              border: Colors.grey,
                              color: Colors.white),
                          name: "email",
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            child: CarouselSlider.builder(
                                carouselController: _carouselController,
                                options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    height: screenHeight(context) * 0.4),
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
                                        _fbKey
                                            .currentState!.fields["plan_id"]!
                                            // ignore: invalid_use_of_protected_member
                                            .setValue(plans[index]["id"]
                                                .toString());
                                      });
                                    },
                                    child: Card(
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: selectedPlan ==
                                                  plans[index]["id"]
                                              ? BorderSide(
                                                  color: violet, width: 2)
                                              : BorderSide.none),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  width:
                                                      screenWidth(context) *
                                                          0.8,
                                                  fit: BoxFit.fill,
                                                  imageUrl: apiMockImage,
                                                  placeholder: (context,
                                                          url) =>
                                                      Image.asset(settings
                                                          .images!
                                                          .placeHolderImage),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(settings
                                                          .images!
                                                          .placeHolderImage),
                                                ),
                                                plans[index]["discount"] !=
                                                        null
                                                    ? Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .topEnd,
                                                        child: FittedBox(
                                                          fit: BoxFit.none,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets
                                                                    .all(5),
                                                            color: Colors.red,
                                                            child:
                                                                AutoSizeText(
                                                              "خصم " +
                                                                  "%" +
                                                                  discount
                                                                      .toStringAsFixed(
                                                                          1),
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),
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
                                                              FontWeight
                                                                  .w600),
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
                                                      screenHeight(context) *
                                                          0.01,
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
                                                    screenWidth(context) *
                                                        0.04),
                                            child: customGeneralButton(
                                                customOnPressed: () {
                                                  Get.defaultDialog(
                                                      title: "مواصفات الباقة",
                                                      content: Column(
                                                        children: plans[index]
                                                                ["features"]
                                                            .map<Widget>(
                                                                (e) => Text(e[
                                                                    "feature"]))
                                                            .toList(),
                                                      ));
                                                },
                                                context: context,
                                                title: "موصفات",
                                                primarycolor: violet,
                                                titlecolor: Colors.white,
                                                newIcon: Icon(Icons.info),
                                                borderColor:
                                                    Colors.transparent),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
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
                          initialValue: widget.store["phone"],
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
                            initialValue: widget.store["name"],
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
                              initialValue: widget.store["username"],
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
                        height: screenHeight(context) * 0.045,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: new LinearGradient(colors: [
                              Colors.blue.shade900,
                              Colors.purple.shade900
                            ])),
                        child: IgnorePointer(
                          ignoring: isChanged,
                          child: customGeneralButton(
                              customOnPressed: () {
                                validation();
                              },
                              context: context,
                              title: "تعديل المتجر",
                              primarycolor: Colors.transparent,
                              titlecolor: Colors.white,
                              newIcon: Icon(Icons.edit),
                              borderColor: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.03,
                      ),
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
    if (_fbKey.currentState!.fields["username"] != widget.store["username"]) {
      print(_fbKey.currentState!.fields["username"]!.value);
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
        await requestEditStore(
            context: context,
            storeInfo: storeInfo,
            storeName: widget.store["username"]);
        setState(() {
          isLoading = !isLoading;
        });
      }
    } else {
      Get.snackbar("لا يوجد تعديلات", "خطأ");
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
