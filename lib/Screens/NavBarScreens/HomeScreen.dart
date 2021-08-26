import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/PrimaryAppBar.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';
import 'package:test_store/CustomWidgets/HomeScreenWidgets/HomeScreenStoresCard.dart';
import 'package:test_store/Logic/ApiRequests/ProductsRequests/ProductsRequest.dart';
import 'package:test_store/Logic/MISC/GetLocation.dart';
import 'package:test_store/Logic/StateManagment/HomeState.dart';
import 'package:test_store/Logic/StateManagment/ProductsState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/ScreenSize.dart';
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
    final homeAds = context.read(homeStateManagment).homeAds;
    final homeStores = context.read(homeStateManagment).homeStores;
    final homeProducts = context.read(homeStateManagment).homeProducts;
    final homeSliders = context.read(homeStateManagment).homeSliders;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: primaryAppBar(context: context),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                    bottom: screenHeight(context) * 0.01,
                    right: screenWidth(context) * 0.03,
                    left: screenWidth(context) * 0.03),
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [Colors.blue.shade900, Colors.purple.shade900]),
                ),
                child: searchBar(
                    color: Colors.white.withOpacity(0.5), context: context)),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: height * 0.3,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: settings.theme!.primary,
                        child: CarouselSlider.builder(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                                height: 400.0, enlargeCenterPage: true),
                            itemCount: homeSliders.length,
                            itemBuilder: (context, index, pageindex) =>
                                Container(
                                  width: width,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: homeSliders[index]["image"],
                                    placeholder: (context, url) => Image.asset(
                                        settings.images!.placeHolderImage),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: AnimationLimiter(
                          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight(context) * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CachedNetworkImage(
                            width: screenWidth(context) * 0.45,
                            height: screenHeight(context) * 0.11,
                            fit: BoxFit.fill,
                            imageUrl: homeAds[0]["image"],
                            placeholder: (context, url) =>
                                Image.asset(settings.images!.placeHolderImage),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          CachedNetworkImage(
                            width: screenWidth(context) * 0.45,
                            height: screenHeight(context) * 0.11,
                            fit: BoxFit.fill,
                            imageUrl: homeAds[1]["image"],
                            placeholder: (context, url) =>
                                Image.asset(settings.images!.placeHolderImage),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.012,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        padding:
                            EdgeInsets.only(right: screenWidth(context) * 0.04),
                        child: Text(
                          "ابرز المتاجر",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth(context) * 0.04),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.01,
                      ),
                      Container(
                        height: screenHeight(context) * 0.15,
                        width: screenWidth(context) * 0.95,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: homeStores.length,
                          itemBuilder: (BuildContext context, int index) {
                            return homeStoreCard(context, homeStores, index);
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.015,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        padding:
                            EdgeInsets.only(right: screenWidth(context) * 0.04),
                        child: Text(
                          "اخترنا لك",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth(context) * 0.04),
                        ),
                      ),
                      Container(
                        height: screenHeight(context) * 0.35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: homeProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Consumer(
                              builder: (BuildContext context,
                                      T Function<T>(ProviderBase<Object?, T>)
                                          watch,
                                      Widget? child) =>
                                  Card(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                child: productsCard(
                                  context: context,
                                  currentList: homeProducts,
                                  index: index,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ))),
                ],
              ),
            ),
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
