import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/Decorations/SearchBarGradientDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/PrimaryAppBar.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Screens/SecondaryScreens/CategoriesScreen.dart';
import 'package:test_store/Variables/Settings.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({Key? key}) : super(key: key);

  @override
  _SectionsScreenState createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  List filteredSections = [];
  @override
  void initState() {
    filteredSections = context.read(categoriesStateManagment).categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.read(categoriesStateManagment).categories;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: primaryAppBar(context: context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              searchBarGradientDecoration(
                  context,
                  searchBar(
                      onChanged: (value) {
                        setState(() {
                          filteredSections = categories
                              .where((element) => element["slug"].contains(value))
                              .toList();
                          if (value == "") {
                            filteredSections = categories;
                          }
                        });
                      },
                      context: context,
                      color: Colors.white.withOpacity(0.5))),
              Container(
                child: AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: filteredSections.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 0.85),
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredGrid(
                        columnCount: 3,
                        position: index,
                        duration: const Duration(milliseconds: 200),
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => CategoriesScreen(
                                    slug: filteredSections[index]["slug"],
                                    id: filteredSections[index]["id"]));
                              },
                              child: Card(
                                elevation: 0.4,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      settings.images!.placeHolderImage,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(filteredSections[index]["name"])
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
