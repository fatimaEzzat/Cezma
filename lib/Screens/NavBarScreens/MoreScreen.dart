import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/PrimaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/ProfileRequests/MyStoresRequest.dart';
import 'package:test_store/Logic/StateManagment/MyStoresState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/AuthScreens/LoginScreen.dart';
import 'package:test_store/Screens/SecondaryScreens/AddStoreScreen.dart';
import 'package:test_store/Screens/SecondaryScreens/ProfileScreen.dart';
import 'package:test_store/Screens/SecondaryScreens/StoreTransition.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _scrollController = ScrollController();
  double start = 0;
  double end = -0.25;
  Color test = Colors.blue;
  bool isLoading = false;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge && !isLoading) {
        final isBottom = _scrollController.position.pixels != 0;
        if (isBottom) {
          await loadData(context);
          // print("object");
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: primaryAppBar(context: context, tabBar: null),
        body: Center(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
            child: ListView(
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.035,
                ),
                Text(
                  "متاجري",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: screenHeight(context) * 0.15,
                  child: Consumer(
                    builder: (BuildContext context,
                            T Function<T>(ProviderBase<Object?, T>) watch,
                            Widget? child) =>
                        ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: watch(myStoresStateManagment).myStores.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final item =
                            watch(myStoresStateManagment).myStores[index];
                        return InkWell(
                          onTap: () {
                            Get.to(() => StoreTransition(store: item));
                          },
                          child: Card(
                            elevation: 0.4,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: CachedNetworkImage(
                                      width: screenWidth(context) * 0.3,
                                      height: screenWidth(context) * 0.3,
                                      fit: BoxFit.fill,
                                      imageUrl: item["image"],
                                      placeholder: (context, url) =>
                                          Image.asset(settings
                                              .images!.placeHolderImage),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Text(item["name"]),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.14),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AddStoreScreen();
                      }));
                    },
                    icon: Icon(Icons.add_circle, color: violet),
                    label: Text(
                      "اضافة المتجر",
                      style: TextStyle(color: violet),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(color: violet, width: 2),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.035,
                ),
                ListTile(
                  dense: true,
                  tileColor: Colors.grey.shade100,
                  leading: Icon(Icons.person),
                  title: Text("الصفحة الشخصية"),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ProfileScreen();
                        }));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: violet,
                      )),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                Divider(
                  thickness: 1.2,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                ListTile(
                  dense: true,
                  tileColor: Colors.grey.shade100,
                  leading: Icon(
                    Icons.info,
                  ),
                  title: Text("من نحن"),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: violet,
                      )),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                ListTile(
                  dense: true,
                  tileColor: Colors.grey.shade100,
                  leading: Icon(Icons.description),
                  title: Text("شروط الاستخدام"),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: violet,
                      )),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                ListTile(
                  dense: true,
                  tileColor: Colors.grey.shade100,
                  leading: Icon(Icons.article),
                  title: Text("سياسة الخصوصية"),
                  trailing: RotationTransition(
                    turns: Tween(begin: start, end: end).animate(_controller),
                    child: IconButton(
                        onPressed: () {
                          double temp = 0;
                          temp = start;
                          start = end;
                          end = temp;
                          setState(() {});
                          _controller.forward(from: 0);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: violet,
                        )),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                customGeneralButton(
                    customOnPressed: () async {
                      await SharedPreferences.getInstance()
                          .then((value) => value.clear());
                      Get.off(() => LoginScreen());
                    },
                    context: context,
                    title: "تسجيل الخروج",
                    primarycolor: Colors.grey.shade100,
                    titlecolor: violet,
                    newIcon: Icon(
                      Icons.logout,
                      color: violet,
                    ),
                    borderColor: Colors.grey.shade200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadData(BuildContext context) async {
    if (context.read(myStoresStateManagment).myStoresCurrentPage <=
        context.read(myStoresStateManagment).myStoresLastPage) {
      setState(() {
        isLoading = !isLoading;
      });
      await requestMyStore(context.read(userStateManagment).userToken, context,
          context.read(myStoresStateManagment).myStoresCurrentPage);
      setState(() {
        isLoading = !isLoading;
      });
    }
  }
}
