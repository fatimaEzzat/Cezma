import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/RequestsExport.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Logic/StateManagment/WishListState.dart';
import 'package:test_store/Logic/StateManagment/CategoryProductsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CategoriesScreen extends StatefulWidget {
  final int id;
  final String slug;
  const CategoriesScreen({
    Key? key,
    required this.slug,
    required this.id,
  }) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _scrollController = ScrollController();
  String? userToken;
  List subCategories = [];
  var selectedCat = "";
  bool isLoadingItems = false;
  final box = Hive.box('favorites');
  int selectedIndex = 1;
  initState() {
    super.initState();
    userToken = context.read(userStateManagment).userToken;
    //////// to listen to the list and detect if it has reached the bottom and load more data.
    subCategories = [
      {"name": "الجميع", "slug": widget.slug}
    ];
    subCategories.addAll(context
        .read(categoriesStateManagment)
        .categories
        .firstWhere((element) => element["id"] == widget.id)["sub"]);
    firstLoad(0);
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge && !isLoadingItems) {
        final isBottom = _scrollController.position.pixels != 0;
        if (isBottom) {
          await loadData(context);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext contexts,
          T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: subCategories.length,
            child: Scaffold(
              appBar:
                  secondaryAppBar(context: context, title: "الاقسام الفرعية"),
              body: subCategories.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                      color: violet,
                    ))
                  : SafeArea(
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight(context) * 0.015,
                          ),
                          IgnorePointer(
                            ignoring: watch(categoriesStateManagment)
                                .isLoadingNewCategories,
                            child: TabBar(
                                onTap: (index) async {
                                  await firstLoad(index);
                                },
                                unselectedLabelColor: Colors.black,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: violet),
                                indicatorColor: Colors.white,
                                isScrollable: true,
                                tabs: subCategories
                                    .map((e) => Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenWidth(context) * 0.02,
                                              vertical: screenHeight(context) *
                                                  0.012),
                                          child: Text(
                                            e["name"],
                                            style: TextStyle(
                                                fontSize: screenWidth(context) *
                                                    0.04),
                                          ),
                                        ))
                                    .toList()),
                          ),
                          Expanded(
                            child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: subCategories
                                    .map((e) => Consumer(
                                          builder: (BuildContext context,
                                              T Function<T>(
                                                      ProviderBase<Object?, T>)
                                                  watch,
                                              Widget? child) {
                                            final categoryProducts = watch(
                                                categoryProductsStateManagment);
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                watch(categoryProductsStateManagment)
                                                        .isLoadingFilteredProducts
                                                    ? CircularProgressIndicator(
                                                        color: violet,
                                                      )
                                                    : Expanded(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child:
                                                              AnimationLimiter(
                                                            child: GridView
                                                                .builder(
                                                                    controller:
                                                                        _scrollController,
                                                                    shrinkWrap:
                                                                        true,
                                                                    primary:
                                                                        false,
                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        childAspectRatio:
                                                                            0.40 /
                                                                                0.6,
                                                                        crossAxisCount:
                                                                            2),
                                                                    itemCount: categoryProducts
                                                                        .categoryProducts
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return AnimationConfiguration
                                                                          .staggeredGrid(
                                                                        columnCount:
                                                                            2,
                                                                        position:
                                                                            index,
                                                                        duration:
                                                                            const Duration(milliseconds: 200),
                                                                        child:
                                                                            ScaleAnimation(
                                                                          child:
                                                                              FadeInAnimation(child: productsCard(box: box, context: context, currentList: categoryProducts.categoryProducts, index: index, wishListState: "wishListState")),
                                                                        ),
                                                                      );
                                                                    }),
                                                          ),
                                                        ),
                                                      ),
                                                isLoadingItems
                                                    ? CircularProgressIndicator(
                                                        color: violet,
                                                      )
                                                    : Container()
                                              ],
                                            );
                                          },
                                        ))
                                    .toList()),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Future firstLoad(int index) async {
    if (selectedIndex != index) {
      selectedIndex = index;
      context
          .read(categoryProductsStateManagment)
          .setLoadingFilteredProductsState();
      selectedCat = subCategories[index]["slug"];
      await requestCategoryProducts(selectedCat, 1, context, true);
      context
          .read(categoryProductsStateManagment)
          .setLoadingFilteredProductsState();
    }
  }

  Future<void> loadData(BuildContext context) async {
    if (context
            .read(categoryProductsStateManagment)
            .currentCategoryProductsPage <=
        context
            .read(categoryProductsStateManagment)
            .totalCategoryProductsPages) {
      setState(() {
        isLoadingItems = !isLoadingItems;
      });

      await requestCategoryProducts(
          selectedCat,
          context
              .read(categoryProductsStateManagment)
              .currentCategoryProductsPage,
          context,
          false);
      setState(() {
        isLoadingItems = !isLoadingItems;
      });
    }
  }
}
