import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
import 'package:test_store/Logic/ApiRequests/ProductsRequests/SearchProducts.dart';
import 'package:test_store/Logic/StateManagment/CartState.dart';
import 'package:test_store/Logic/StateManagment/WishListState.dart';
import 'package:test_store/Logic/StateManagment/SearchedProductsState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchitem = "";
  final box = Hive.box('favorites');
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.read(searchedProductsStateManagement).searchedProducts =
                    [];
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: settings.theme!.secondary,
              )),
          title: FormBuilderTextField(
            onChanged: (value) async {
              if (value == "") {
                context
                    .read(searchedProductsStateManagement)
                    .clearSearchedProducts();
              }
              if (!context.read(searchedProductsStateManagement).isSearching) {
                await requestSearchProduct(value!, context, 1, true).then((r) {
                  if (value == "") {
                    context
                        .read(searchedProductsStateManagement)
                        .clearSearchedProducts();
                  }
                });
              }
            },
            name: 'search',
            decoration: customformfielddecoration(
                color: offwhite,
                hinttext: "كلمة البحث",
                context: context,
                obsecure: null),
          ),
        ),
        body: Consumer(builder: (context, watch, child) {
          var width = screenWidth(context);
          final searchedpPoducts = watch(searchedProductsStateManagement);
          final List searchedList = searchedpPoducts.searchedProducts;
          return searchedList.isEmpty
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
              : searchedpPoducts.isSearching
                  ? Center(
                      child: CircularProgressIndicator(
                        color: settings.theme!.secondary,
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.40 / 0.6, crossAxisCount: 2),
                      itemCount: searchedList.length,
                      itemBuilder: (context, index) {
                        return productsCard(
                          context: context,
                          currentItem: searchedList,
             
                        );
                      });
        }),
      ),
    );
  }
}
