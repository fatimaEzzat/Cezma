import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';
import 'package:test_store/Logic/ApiRequests/ProductsRequests/SearchProducts.dart';
import 'package:test_store/Logic/StateManagment/SearchedProductsState.dart';
import 'package:test_store/Screens/SecondaryScreens/ProductViewScreen.dart';
import 'package:test_store/Screens/StoreScreens/StoreTransition.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchitem = "";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Colors.blue.shade900, Colors.purple.shade900]),
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: BackButton(
              color: Colors.white,
            ),
            title: searchBar(
                context: context,
                color: Colors.grey.shade100,
                onChanged: (value) {
                  requestSearchItem(value, context, 1, false);
                })),
        body: Consumer(builder: (context, watch, child) {
          var width = screenWidth(context);
          final searchedItemsState = watch(searchedItemsStateManagement);
          final Map searchedItems = searchedItemsState.searchedItems;
          return searchedItems.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: width * 0.3,
                      color: settings.theme!.secondary,
                    ),
                    Text(
                      "ابدأ ابحث",
                      style: TextStyle(fontSize: screenWidth(context) * 0.1),
                    )
                  ],
                ))
              : searchedItemsState.isSearching
                  ? Center(
                      child: CircularProgressIndicator(
                        color: settings.theme!.secondary,
                      ),
                    )
                  : SettingsList(
                      sections: searchedItems.entries
                          .map((element) => SettingsSection(
                              title: element.key,
                              tiles: element.value["data"]
                                  .map<SettingsTile>((e) => SettingsTile(
                                      onPressed: (value) {
                                        e.keys.contains("store_id")
                                            ? Get.to(() => ProductViewScreen(
                                                  product: e,
                                                ))
                                            : Get.to(() =>
                                                StoreTransition(store: e));
                                      },
                                      title: e["name"]))
                                  .toList()))
                          .toList());
        }),
      ),
    );
  }
}
