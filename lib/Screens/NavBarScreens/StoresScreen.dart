import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/PrimaryAppBar.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';
import 'package:test_store/Logic/ApiRequests/SubCategoriesRequest.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Logic/StateManagment/StoresState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'dart:math' as math;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Variables/Settings.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer(
        builder: (BuildContext context,
                T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) =>
            Scaffold(
          appBar: primaryAppBar(context: context),
          body: Center(
            child: Container(
              width: screenWidth(context) * 0.9,
              child: ListView(
                children: [
                  SizedBox(
                    height: screenHeight(context) * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          child: FormBuilderDropdown(
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
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )),
                                  // ////////
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )),
                                  // ////////
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ))),
                              name: '',
                              items: context
                                  .read(categoriesStateManagment)
                                  .categories
                                  .map((e) => DropdownMenuItem(
                                        onTap: () async {
                                          watch(categoriesStateManagment)
                                              .setIsLoadingSubCategories();
                                          await requestSubCategories(
                                              context, e["id"]);
                                          watch(categoriesStateManagment)
                                              .setIsLoadingSubCategories();
                                        },
                                        child: AutoSizeText(
                                          e["name"],
                                          maxLines: 1,
                                        ),
                                        value: e["id"],
                                      ))
                                  .toList()),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context) * 0.03,
                      ),
                      Flexible(
                        child: FormBuilderDropdown(
                          enabled: watch(categoriesStateManagment)
                                  .isLoadingSubCategories
                              ? false
                              : true,
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
                                    color: Colors.grey.shade300,
                                  )),
                              // ////////
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  )),
                              // ////////
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ))),
                          name: '',
                          items: watch(categoriesStateManagment)
                              .subCategories
                              .map((e) => DropdownMenuItem(
                                    child: AutoSizeText(
                                      e["name"],
                                      maxLines: 1,
                                    ),
                                    value: e["id"],
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
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
                        AnimationLimiter(
                      child: GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.40 / 0.6,
                                  crossAxisCount: 3),
                          itemCount: watch(storesStateManagment).stores.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: index,
                              duration: const Duration(milliseconds: 200),
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                    child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: watch(storesStateManagment)
                                          .stores[index]["image"]
                                          .replaceAll("https://cezma.test/",
                                              apiBaseUrl),
                                      placeholder: (context, url) =>
                                          Image.asset(settings
                                              .images!.placeHolderImage),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    Text(watch(storesStateManagment)
                                        .stores[index]["name"]),
                                  ],
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
      ),
    );
  }
}
// images[imgindex].replaceAll(
//                     "https://cezma.test", "http://fc23e3d0e899.ngrok.io"),