import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/PrimaryAppBar.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';
import 'package:test_store/CustomWidgets/HomeScreenWidgets/HomeScreenStoresCard.dart';
import 'package:test_store/Logic/ApiRequests/HomeRequest.dart';
import 'package:test_store/Logic/StateManagment/HomeState.dart';
import 'package:test_store/Screens/SecondaryScreens/SearchScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_store/Variables/Settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _carouselController = CarouselController();
  bool isSearching = false;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = screenWidth(context);
    var height = screenHeight(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: primaryAppBar(context: context),
        body: Consumer(
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final homeAds = watch(homeStateManagment).homeAds;
            final homeStores = watch(homeStateManagment).homeStores;
            final homeProducts = watch(homeStateManagment).homeProducts;
            final homeSliders = watch(homeStateManagment).homeSliders;
            return Column(
              children: [
                Container(
                    padding: EdgeInsets.only(
                        bottom: screenHeight(context) * 0.01,
                        right: screenWidth(context) * 0.03,
                        left: screenWidth(context) * 0.03),
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(colors: [
                        Colors.blue.shade900,
                        Colors.purple.shade900
                      ]),
                    ),
                    child: searchBar(
                        color: Colors.white.withOpacity(0.5),
                        context: context,
                        onTap: () {
                          Get.to(() => SearchScreen());
                        })),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () {
                      requestHome(context: context).then(
                          (value) => _refreshController.refreshCompleted());
                    },
                    child: CustomScrollView(
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
                                          placeholder: (context, url) =>
                                              Image.asset(settings
                                                  .images!.placeHolderImage),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(settings
                                                  .images!.placeHolderImage),
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
                                  placeholder: (context, url) => Image.asset(
                                      settings.images!.placeHolderImage),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          settings.images!.placeHolderImage),
                                ),
                                CachedNetworkImage(
                                  width: screenWidth(context) * 0.45,
                                  height: screenHeight(context) * 0.11,
                                  fit: BoxFit.fill,
                                  imageUrl: homeAds[1]["image"],
                                  placeholder: (context, url) => Image.asset(
                                    settings.images!.placeHolderImage,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    settings.images!.placeHolderImage,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight(context) * 0.012,
                            ),
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              padding: EdgeInsets.only(
                                  right: screenWidth(context) * 0.04),
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
                                  return homeStoreCard(
                                      context, homeStores, index);
                                },
                              ),
                            ),
                            SizedBox(
                              height: screenHeight(context) * 0.015,
                            ),
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              padding: EdgeInsets.only(
                                  right: screenWidth(context) * 0.04),
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
                                            T Function<T>(
                                                    ProviderBase<Object?, T>)
                                                watch,
                                            Widget? child) =>
                                        Card(
                                      elevation: 0,
                                      shadowColor: Colors.transparent,
                                      child: productsCard(
                                        context: context,
                                        currentItem: homeProducts[index],
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
