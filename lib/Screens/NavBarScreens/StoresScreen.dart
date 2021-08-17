import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';
import 'package:test_store/Logic/ApiRequests/SubCategoriesRequest.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'dart:math' as math;
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          appBar: AppBar(
            flexibleSpace: searchBar(
                context: context, color: Colors.white.withOpacity(0.3)),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenWidth(context) * 0.4,
                      // height: screenHeight(context) * 0.07,
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
                                    onTap: () {
                                      requestSubCategories(context, e["id"]);
                                    },
                                    child: AutoSizeText(
                                      e["name"],
                                      maxLines: 1,
                                    ),
                                    value: e["id"],
                                  ))
                              .toList()),
                    ),
                    Container(
                      width: screenWidth(context) * 0.4,
                      child: FormBuilderDropdown(
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
                searchBar(
                    context: context, color: Colors.grey.withOpacity(0.3)),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Text(watch(categoriesStateManagment)
                  .subCategories
                  .length
                  .toString()),
              onPressed: () {
                requestSubCategories(context, 5);
              }),
        ),
      ),
    );
  }
}
