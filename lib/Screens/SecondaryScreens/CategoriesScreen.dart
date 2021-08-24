import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/RequestsExport.dart';
import 'package:test_store/Logic/ApiRequests/SubCategoriesRequest.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
import 'package:test_store/Logic/StateManagment/FavoritesState.dart';
import 'package:test_store/Logic/StateManagment/FilteredProductsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:test_store/Variables/Settings.dart';

class CategoriesScreen extends StatefulWidget {
  final int id;
  const CategoriesScreen({
    Key? key,
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
  int selectedIndex = 0;
  initState() {
    super.initState();
    userToken = context.read(userStateManagment).userToken;
    //////// to listen to the list and detect if it has reached the bottom and load more data.

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      requestSubCategories(context, widget.id).then((value) => setState(() {
            subCategories = value;
          }));
    });

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
        final cartState = watch(cartStateManagment);
        final wishListState = watch(wishListtateManagment);
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
                  : Column(
                      children: [
                        SizedBox(
                          height: screenHeight(context) * 0.015,
                        ),
                        TabBar(
                            onTap: (index) async {
                              if (selectedIndex != index) {
                                selectedIndex = index;
                                watch(filteredProductsStateManagment)
                                    .setLoadingFilteredProductsState();
                                await requestCategoryProducts(
                                    selectedCat, 1, context, true);
                                watch(filteredProductsStateManagment)
                                    .setLoadingFilteredProductsState();
                              }
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
                                          vertical:
                                              screenHeight(context) * 0.012),
                                      child: Text(
                                        e["name"],
                                        style: TextStyle(
                                            fontSize:
                                                screenWidth(context) * 0.04),
                                      ),
                                    ))
                                .toList()),
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
                                          final filteredProductsState =
                                              watch(categoriesStateManagment);
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // if (!watch(
                                              //         filteredProductsStateManagment)
                                              //     .isLoadingFilteredProducts)
                                              //   if (filteredProductsState
                                              //       .filteredProducts
                                              //       .isNotEmpty)
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: AnimationLimiter(
                                                    child: GridView.builder(
                                                        controller:
                                                            _scrollController,
                                                        shrinkWrap: true,
                                                        primary: false,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                childAspectRatio:
                                                                    0.40 / 0.6,
                                                                crossAxisCount:
                                                                    2),
                                                        itemCount:
                                                            filteredProductsState
                                                                .subCategoriesProducts
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return AnimationConfiguration
                                                              .staggeredGrid(
                                                            columnCount: 2,
                                                            position: index,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                            child:
                                                                ScaleAnimation(
                                                              child: FadeInAnimation(
                                                                  child: productsCard(
                                                                      box: box,
                                                                      cartState:
                                                                          cartState,
                                                                      context:
                                                                          context,
                                                                      currentList:
                                                                          filteredProductsState
                                                                              .subCategoriesProducts,
                                                                      index:
                                                                          index,
                                                                      wishListState:
                                                                          wishListState)),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              )
                                              // else
                                              //   Column(
                                              //     children: [
                                              //       Icon(Icons.error),
                                              //       Text(
                                              //         "لا يوجد منجات من هذا النوع",
                                              //         style: TextStyle(
                                              //             color: settings
                                              //                 .theme!
                                              //                 .secondary),
                                              //       )
                                              //     ],
                                              //   )
                                              // else
                                              //   CircularProgressIndicator(
                                              //     backgroundColor:
                                              //         Colors.transparent,
                                              //     color:
                                              //         settings.theme!.secondary,
                                              //   ),
                                              // if (isLoadingItems)
                                              //   Center(
                                              //     child:
                                              //         CircularProgressIndicator(
                                              //       backgroundColor:
                                              //           Colors.transparent,
                                              //       color: settings
                                              //           .theme!.secondary,
                                              //     ),
                                              //   )
                                              // else
                                              //   Container()
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
        );
      },
    );
  }

  Future<void> loadData(BuildContext context) async {
    if (context
            .read(filteredProductsStateManagment)
            .currentFilteredCategoryPage <=
        context
            .read(filteredProductsStateManagment)
            .totalFilteredCategoriesPages) {
      setState(() {
        isLoadingItems = !isLoadingItems;
      });
      await requestCategoryProducts(
          selectedCat,
          context
              .read(filteredProductsStateManagment)
              .currentFilteredCategoryPage,
          context,
          false);
      setState(() {
        isLoadingItems = !isLoadingItems;
      });
    }
  }
}
