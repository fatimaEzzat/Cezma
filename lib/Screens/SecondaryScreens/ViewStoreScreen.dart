import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/StoreProductsRequest.dart';
import 'package:test_store/Logic/StateManagment/StoresState.dart';
import 'package:test_store/Screens/SecondaryScreens/AddProductScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class ViewStore extends StatefulWidget {
  final store;
  const ViewStore({Key? key, required this.store}) : super(key: key);

  @override
  _ViewStoreState createState() => _ViewStoreState();
}

class _ViewStoreState extends State<ViewStore> {
  @override
  void initState() {
    requestStoreProducts(
            isRefresh: true,
            context: context,
            userName: widget.store["username"],
            currentPage: 1)
        .then((value) => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(context: context, title: 'متجري'),
        body: Center(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.04,
                ),
                CircleAvatar(
                  radius: screenHeight(context) * 0.055,
                  backgroundImage: AssetImage(
                    "Assets/Images/PlaceHolderImage.jpeg",
                  ),
                ),
                Text(
                  widget.store["name"],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight(context) * 0.02),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                Text(widget.store["description"]),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                Container(
                  height: screenHeight(context) * 0.04,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: new LinearGradient(
                        colors: [Colors.blue.shade900, Colors.purple.shade900]),
                  ),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent, elevation: 0),
                      onPressed: () {},
                      icon: Icon(Icons.chat_bubble_rounded),
                      label: Text("محادثة المتجر")),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                RichText(
                  text: new TextSpan(
                    children: widget.store["categories"]
                        .map<TextSpan>((e) => TextSpan(
                            text: "/" + e["name"],
                            style: TextStyle(color: Colors.black)))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    tileColor: Colors.grey.shade200,
                    leading: Icon(Icons.phone),
                    title: Text(widget.store["phone"]),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    tileColor: Colors.grey.shade200,
                    leading: Icon(Icons.room),
                    title: Text(widget.store["address"].toString()),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Container(
                  width: screenWidth(context),
                  height: screenHeight(context) * 0.055,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: new LinearGradient(
                        colors: [Colors.blue.shade900, Colors.purple.shade900]),
                  ),
                  child: customGeneralButton(
                      customOnPressed: () {
                        Get.to(() => AddProductScreen());
                      },
                      context: context,
                      title: "اضافة منتج",
                      primarycolor: Colors.transparent,
                      titlecolor: Colors.white,
                      newIcon: Icon(Icons.add),
                      borderColor: Colors.transparent),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: AnimationLimiter(
                    child: Consumer(
                      builder: (BuildContext context,
                              T Function<T>(ProviderBase<Object?, T>) watch,
                              Widget? child) =>
                          GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.40 / 0.6,
                                      crossAxisCount: 2),
                              itemCount: watch(storesStateManagment)
                                  .storeProducts
                                  .length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  columnCount: 2,
                                  position: index,
                                  duration: const Duration(milliseconds: 200),
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(child: Text("sfsf")),
                                  ),
                                );
                              }),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
