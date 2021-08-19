// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
// import 'package:test_store/Logic/ApiRequests/CategoryProducts.dart';
// import 'package:test_store/Logic/ApiRequests/RequestsExport.dart';
// import 'package:test_store/Logic/StateManagment/CartState.dart';
// import 'package:test_store/Logic/StateManagment/CategoriesState.dart';
// import 'package:test_store/Logic/StateManagment/FavoritesState.dart';
// import 'package:test_store/Logic/StateManagment/FilteredProductsState.dart';
// import 'package:test_store/Logic/StateManagment/UserState.dart';
// import 'package:test_store/Variables/ScreenSize.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:test_store/Variables/Settings.dart';

// class CategoriesScreen extends StatefulWidget {
//   const CategoriesScreen({Key? key}) : super(key: key);

//   @override
//   _CategoriesScreenState createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   final _scrollController = ScrollController();
//   String? userToken;
//   int? totalCatPages;
//   var selectedCat = "";
//   bool isLoading = false;
//   bool isLoadingItems = false;
//   final box = Hive.box('favorites');
//   int selectedIndex = 0;
//   initState() {
//     super.initState();
//     userToken = context.read(userStateManagment).userToken;

//     //////// to listen to the list and detect if it has reached the bottom and load more data.
//     _scrollController.addListener(() async {
//       if (_scrollController.position.atEdge && !isLoadingItems) {
//         final isBottom = _scrollController.position.pixels != 0;
//         if (isBottom) {
//           await loadData(context);
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (BuildContext contexts,
//           T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
//         final categoriesState = watch(categoriesStateManagment);
//         final cartState = watch(cartStateManagment);
//         final wishListState = watch(wishListtateManagment);
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: DefaultTabController(
//             length: categoriesState.categories.length,
//             child: Scaffold(
//               appBar: AppBar(
//                 elevation: 0,
//                 flexibleSpace: Container(
//                   decoration: new BoxDecoration(
//                     gradient: new LinearGradient(
//                         colors: [Colors.blue.shade900, Colors.purple.shade900]),
//                   ),
//                   child: PreferredSize(
//                     preferredSize:
//                         Size.fromHeight(screenHeight(context) * 0.06),
//                     child: IgnorePointer(
//                       ignoring: watch(filteredProductsStateManagment)
//                           .isLoadingFilteredProducts,
//                       child: NotificationListener<ScrollUpdateNotification>(
//                         onNotification: (notif) {
//                           if (notif.metrics.atEdge) {
//                             loadCategories(context);
//                           }
//                           return true;
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: screenWidth(context) * 0.015),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TabBar(
//                                     onTap: (index) async {
//                                       if (selectedIndex != index) {
//                                         selectedCat = categoriesState
//                                             .categories[index]["slug"];
//                                         selectedIndex = index;
//                                         watch(filteredProductsStateManagment)
//                                             .setLoadingFilteredProductsState();
//                                         await requestCategoryProducts(
//                                             selectedCat, 1, context, true);
//                                         watch(filteredProductsStateManagment)
//                                             .setLoadingFilteredProductsState();
//                                       }
//                                     },
//                                     unselectedLabelColor:
//                                         settings.theme!.secondary,
//                                     indicator: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15),
//                                         color: settings.theme!.secondary),
//                                     indicatorColor: Colors.white,
//                                     isScrollable: true,
//                                     tabs: categoriesState.categories
//                                         .map((e) => Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal:
//                                                       screenWidth(context) *
//                                                           0.02,
//                                                   vertical:
//                                                       screenHeight(context) *
//                                                           0.012),
//                                               child: Text(
//                                                 e["name"],
//                                                 style: TextStyle(
//                                                     fontSize:
//                                                         screenWidth(context) *
//                                                             0.04),
//                                               ),
//                                             ))
//                                         .toList()),
//                               ),
//                               if (categoriesState.isLoadingNewCategories)
//                                 Center(
//                                   child: CircularProgressIndicator(
//                                     color: settings.theme!.secondary,
//                                     backgroundColor: Colors.white,
//                                   ),
//                                 )
//                               else
//                                 Container(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               body: TabBarView(
//                   physics: NeverScrollableScrollPhysics(),
//                   children: categoriesState.categories
//                       .map((e) => Consumer(
//                             builder: (BuildContext context,
//                                 T Function<T>(ProviderBase<Object?, T>) watch,
//                                 Widget? child) {
//                               final filteredProductsState =
//                                   watch(filteredProductsStateManagment);
//                               return Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   if (!watch(filteredProductsStateManagment)
//                                       .isLoadingFilteredProducts)
//                                     if (filteredProductsState
//                                         .filteredProducts.isNotEmpty)
//                                       Expanded(
//                                         child: Container(
//                                           padding: EdgeInsets.only(top: 10),
//                                           child: AnimationLimiter(
//                                             child: GridView.builder(
//                                                 controller: _scrollController,
//                                                 shrinkWrap: true,
//                                                 primary: false,
//                                                 gridDelegate:
//                                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                                         childAspectRatio:
//                                                             0.40 / 0.6,
//                                                         crossAxisCount: 2),
//                                                 itemCount: filteredProductsState
//                                                     .filteredProducts.length,
//                                                 itemBuilder: (context, index) {
//                                                   return AnimationConfiguration
//                                                       .staggeredGrid(
//                                                     columnCount: 2,
//                                                     position: index,
//                                                     duration: const Duration(
//                                                         milliseconds: 200),
//                                                     child: ScaleAnimation(
//                                                       child: FadeInAnimation(
//                                                           child: productsCard(
//                                                               box: box,
//                                                               cartState:
//                                                                   cartState,
//                                                               context: context,
//                                                               currentList:
//                                                                   filteredProductsState
//                                                                       .filteredProducts,
//                                                               index: index,
//                                                               wishListState:
//                                                                   wishListState)),
//                                                     ),
//                                                   );
//                                                 }),
//                                           ),
//                                         ),
//                                       )
//                                     else
//                                       Column(
//                                         children: [
//                                           Icon(Icons.error),
//                                           Text(
//                                             "لا يوجد منجات من هذا النوع",
//                                             style: TextStyle(
//                                                 color:
//                                                     settings.theme!.secondary),
//                                           )
//                                         ],
//                                       )
//                                   else
//                                     CircularProgressIndicator(
//                                       backgroundColor: Colors.transparent,
//                                       color: settings.theme!.secondary,
//                                     ),
//                                   if (isLoadingItems)
//                                     Center(
//                                       child: CircularProgressIndicator(
//                                         backgroundColor: Colors.transparent,
//                                         color: settings.theme!.secondary,
//                                       ),
//                                     )
//                                   else
//                                     Container()
//                                 ],
//                               );
//                             },
//                           ))
//                       .toList()),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> loadCategories(BuildContext context) async {
//     final catState = context.read(categoriesStateManagment);
//     if (catState.currentCategoryPage <= catState.totalCategoryPages) {
//       catState.setCategoriesLoadingState();
//       await requestCategoriesList(context,
//           context.read(categoriesStateManagment).currentCategoryPage, false);
//       catState.setCategoriesLoadingState();
//     }
//   }

//   Future<void> loadData(BuildContext context) async {
//     if (context
//             .read(filteredProductsStateManagment)
//             .currentFilteredCategoryPage <=
//         context
//             .read(filteredProductsStateManagment)
//             .totalFilteredCategoriesPages) {
//       setState(() {
//         isLoadingItems = !isLoadingItems;
//       });
//       await requestCategoryProducts(
//           selectedCat,
//           context
//               .read(filteredProductsStateManagment)
//               .currentFilteredCategoryPage,
//           context,
//           false);
//       setState(() {
//         isLoadingItems = !isLoadingItems;
//       });
//     }
//   }
// }
