// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Screens/NavBarScreens/HomeScreen.dart';
import 'package:test_store/Screens/NavBarScreens/MoreScreen.dart';
import 'package:test_store/Screens/NavBarScreens/OrdersScreen.dart';
import 'package:test_store/Screens/NavBarScreens/SectionsScreen.dart';
import 'package:test_store/Screens/NavBarScreens/StoresScreen.dart';
import 'package:test_store/Variables/Settings.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBar createState() => _CustomNavigationBar();
}

class _CustomNavigationBar extends State<CustomNavigationBar> {
  int _currentIndex = 4;
  final _homeScreen = GlobalKey<NavigatorState>();
  final _ordersScreen = GlobalKey<NavigatorState>();
  final _categoriesScreen = GlobalKey<NavigatorState>();
  final _profileScreen = GlobalKey<NavigatorState>();
  final _storesScreen = GlobalKey<NavigatorState>();
  late DataConnectionStatus connection;
  @override
  void initState() {
    super.initState();

    // DataConnectionChecker().onStatusChange.listen((event) {
    //   setState(() {
    //     connection = event;
    //     if (connection == DataConnectionStatus.disconnected) {
    //       Get.defaultDialog(
    //           barrierDismissible: false,
    //           title: "خطأ",
    //           middleText: "تعذر الاتصال بالانترنت",
    //           confirm: customGeneralButton(
    //               context: context,
    //               customOnPressed: () async {
    //                 bool test = await DataConnectionChecker().hasConnection;
    //                 if (test) {
    //                   Get.back();
    //                 }
    //               },
    //               newIcon: Icon(Icons.refresh),
    //               primarycolor: settings.theme!.secondary,
    //               title: 'اعادة الاتصال',
    //               titlecolor: Colors.white));
    //     } else {
    //       Get.back();
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        // appBar: primaryAppBar(context: context, tabBar: null),
        body: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            Navigator(
              key: _profileScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                fullscreenDialog: true,
                builder: (context) {
                  return MoreScreen();
                },
              ),
            ),
            Navigator(
              key: _ordersScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => OrdersScreen(),
              ),
            ),
            Navigator(
              key: _categoriesScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => SectionsScreen(),
              ),
            ),
            Navigator(
              key: _storesScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => StoresScreen(),
              ),
            ),
            Navigator(
              key: _homeScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => HomeScreen(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: settings.theme!.secondary,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (val) => _onTap(val, context),
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(settings.images!.menuIcon)),
                label: "القائمة"),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(settings.images!.ordersIcon)),
              label: "الطلبات",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.widgets_outlined),
              label: "الاقسام",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: "المتاجر",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(settings.images!.homeIcon)),
              label: "الرئيسية",
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int val, BuildContext context) {
    if (_currentIndex == val) {
      switch (val) {
        case 0:
          _profileScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 1:
          _ordersScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 2:
          _categoriesScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 3:
          _storesScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 4:
          _homeScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
  }
}
