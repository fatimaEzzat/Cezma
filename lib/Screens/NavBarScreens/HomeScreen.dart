import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/PrimaryAppBar.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';

import 'package:test_store/Logic/ApiRequests/Ads.dart';
import 'package:test_store/Logic/ApiRequests/ProductsRequest.dart';
import 'package:test_store/Logic/MISC/GetLocation.dart';
import 'package:test_store/Logic/MISC/LoadLocalAppSettings.dart';
import 'package:test_store/Logic/StateManagment/AdsState.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/FavoritesState.dart';
import 'package:test_store/Logic/StateManagment/ProductsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_store/Variables/Settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _carouselController = CarouselController();
  late int totalpages = 0;
  String? userToken;
  late var response;
  GetLocation testp = GetLocation();
  late Box box;
  @override
  initState() {
    super.initState();
    box = Hive.box('favorites');
    userToken = context.read(userStateManagment).userToken;
    //////// to listen to the list and detect if it has reached the bottom and load more data.
    _scrollController.addListener(() async {
      // check if the user scrolled all the way to the bottom and that there is not any items loading.

      if (_scrollController.position.atEdge &&
          !context.read(productsStateManagment).isLoadingNewItems) {
        final isBottom = _scrollController.position.pixels != 0;
        if (isBottom) {
          context.read(productsStateManagment).setIsLoadingNewItems();

          await loadData(context).then((value) =>
              context.read(productsStateManagment).setIsLoadingNewItems());
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
    var width = screenWidth(context);
    var height = screenHeight(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: searchBar(context: context),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: height * 0.3,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Consumer(
                        builder: (BuildContext context,
                            T Function<T>(ProviderBase<Object?, T>) watch,
                            Widget? child) {
                          final adsState = watch(adsStateManagment);
                          return Container(
                            color: Colors.white,
                            child: CarouselSlider.builder(
                                carouselController: _carouselController,
                                options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      if ((index + 1) % 10 == 0) {
                                        if (adsState.currentAdsPage <=
                                            adsState.totalAdsPages) {
                                          requestAds(adsState.currentAdsPage,
                                              context, false);
                                        } else {}
                                      } else {}
                                    },
                                    height: 400.0,
                                    enlargeCenterPage: true),
                                itemCount: adsState.ads.length,
                                itemBuilder: (context, index, pageindex) =>
                                    Container(
                                      width: width,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: apiBaseUrl +
                                            adsState.ads[index]["image"],
                                        placeholder: (context, url) =>
                                            Image.asset(settings
                                                .images!.placeHolderImage),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    )),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Consumer(builder: (context, watch, child) {
                      final productsState = watch(productsStateManagment);
                      final cartState = watch(cartStateManagment);
                      final wishListState = watch(wishListtateManagment);
                      return AnimationLimiter(
                        child: GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.40 / 0.6,
                                    crossAxisCount: 2),
                            itemCount: productsState.products.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredGrid(
                                columnCount: 2,
                                position: index,
                                duration: const Duration(milliseconds: 200),
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      child: productsCard(
                                          context: context,
                                          currentList: productsState.products,
                                          index: index,
                                          cartState: cartState,
                                          box: box,
                                          wishListState: wishListState)),
                                ),
                              );
                            }),
                      ); 
                    }),
                  ),
                ],
              ),
            ),
            Center(
              child: Consumer(
                builder: (BuildContext context,
                    T Function<T>(ProviderBase<Object?, T>) watch,
                    Widget? child) {
                  return Container(
                    color: Colors.transparent,
                    child: watch(productsStateManagment).isLoadingNewItems
                        ? Center(
                            child: CircularProgressIndicator(
                              color: settings.theme!.secondary,
                              backgroundColor: Colors.transparent,
                            ),
                          )
                        : Container(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> loadData(BuildContext context) async {
    if (context.read(productsStateManagment).currentProductPage <=
        context.read(productsStateManagment).totalProductsPages) {
      await requestProducts(userToken, context,
          context.read(productsStateManagment).currentProductPage, false);
    }
  }
}
