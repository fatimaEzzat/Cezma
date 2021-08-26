import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/PrimaryAppBar.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/StoreCard.dart';
import 'package:test_store/Logic/ApiRequests/CategoriesRequest/CategoryStoresRequest.dart';
import 'package:test_store/Logic/ApiRequests/StoresRequest/StoresRequest.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Logic/StateManagment/StoresState.dart';
import 'package:test_store/Screens/StoreScreens/StoreTransition.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'dart:math' as math;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Variables/Settings.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  late GlobalKey<FormBuilderState> _fbKey;
  List subCategories = [];
  bool isLoading = false;
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
        appBar: primaryAppBar(context: context),
        body: Center(
          child: Container(
            width: screenWidth(context) * 0.9,
            child: ListView(
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                FormBuilder(
                  key: _fbKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Consumer(
                          builder: (BuildContext context,
                                  T Function<T>(ProviderBase<Object?, T>) watch,
                                  Widget? child) =>
                              FormBuilderDropdown(
                                  enabled: !watch(storesStateManagment)
                                      .isLoadingStores,
                                  onChanged: (value) async {
                                    _fbKey.currentState!
                                      ..fields["subCategories"]!.reset();
                                    setState(() {
                                      var selectedCat = context
                                          .read(categoriesStateManagment)
                                          .categories
                                          .firstWhere((element) =>
                                              element["id"] == value)["slug"];
                                      loadStores(selectedCat);
                                      subCategories = context
                                          .read(categoriesStateManagment)
                                          .categories
                                          .firstWhere((element) =>
                                              element["id"] == value)["sub"];
                                    });
                                  },
                                  hint: Text("الاقسام الرئيسية"),
                                  icon: Transform.rotate(
                                      angle: math.pi / 2,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: violet,
                                      )),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: screenHeight(context) * 0.025,
                                          right: screenWidth(context) * 0.03,
                                          left: screenWidth(context) * 0.03),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          )),
                                      // ////////
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          )),
                                      // ////////
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ))),
                                  name: 'mainCategories',
                                  items: context
                                      .read(categoriesStateManagment)
                                      .categories
                                      .map((e) => DropdownMenuItem(
                                            child: AutoSizeText(
                                              e["name"],
                                              maxLines: 1,
                                            ),
                                            value: e["id"],
                                          ))
                                      .toList()),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await resetStores();
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: violet,
                          )),
                      Flexible(
                        child: Consumer(
                          builder: (BuildContext context,
                                  T Function<T>(ProviderBase<Object?, T>) watch,
                                  Widget? child) =>
                              FormBuilderDropdown(
                            onChanged: (value) {
                              loadStores(value.toString());
                            },
                            enabled:
                                !watch(storesStateManagment).isLoadingStores,
                            hint: Text("الاقسام الفرعية"),
                            icon: Transform.rotate(
                              angle: math.pi / 2,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: violet,
                              ),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: screenHeight(context) * 0.025,
                                    right: screenWidth(context) * 0.03,
                                    left: screenWidth(context) * 0.03),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                    )),
                                // ////////
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                    )),
                                // ////////

                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ))),
                            name: 'subCategories',
                            items: subCategories
                                .map((e) => DropdownMenuItem(
                                      child: AutoSizeText(
                                        e["name"].toString(),
                                        maxLines: 1,
                                      ),
                                      value: e["slug"].toString(),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                searchBar(
                    context: context, color: Colors.grey.withOpacity(0.3)),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Consumer(
                  builder: (BuildContext context,
                          T Function<T>(ProviderBase<Object?, T>) watch,
                          Widget? child) =>
                      watch(storesStateManagment).isLoadingStores
                          ? Center(
                              child: CircularProgressIndicator(
                                color: violet,
                              ),
                            )
                          : AnimationLimiter(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.8,
                                          crossAxisCount: 3),
                                  itemCount:
                                      watch(storesStateManagment).stores.length,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      columnCount: 3,
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                            child: InkWell(
                                          onTap: () {
                                            Get.to(() => StoreTransition(
                                                  store: watch(
                                                          storesStateManagment)
                                                      .stores[index],
                                                ));
                                          },
                                          child: storeCard(
                                              context,
                                              watch(storesStateManagment)
                                                  .stores[index]),
                                        )),
                                      ),
                                    );
                                  }),
                            ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetStores() async {
    if (_fbKey.currentState!.fields["subCategories"]!.value != null ||
        _fbKey.currentState!.fields["mainCategories"]!.value != null) {
      _fbKey.currentState!.reset();
      subCategories = [];
      context.read(storesStateManagment).setStoreLoadingState();
      await requestStores(
          context: context, pageNumber: 1, isRefresh: true, category: null);
      context.read(storesStateManagment).setStoreLoadingState();
    }
  }

  Future<void> loadStores(String categorySlug) async {
    context.read(storesStateManagment).setStoreLoadingState();
    await requestCategoryStores(categorySlug, 1, context, true);
    context.read(storesStateManagment).setStoreLoadingState();
  }
}
