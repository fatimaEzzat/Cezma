import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/PrimaryAppBar.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SearchBar.dart';
import 'package:test_store/Logic/ApiRequests/OrdersRequests/Orders.dart';
import 'package:test_store/Logic/StateManagment/OrdersState.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/SecondaryScreens/OrderPageScreen.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _scrollController = ScrollController();
  late String? userToken = "";
  late int id;
  late var response;
  @override
  void initState() {
    userToken = context.read(userStateManagment).userToken;
    id = context.read(userStateManagment).userId!;
    // //////////////////
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        final isBottom = _scrollController.position.pixels != 0;
        if (isBottom) {
          loadData(context);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: primaryAppBar(context: context),
        body: Consumer(
          builder: (context, watch, child) {
            final ordersState = watch(ordersStateManagment);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: ordersState.orders.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return OrderPageScreen(
                                    index: index,
                                    id: ordersState.orders[index]["id"]
                                        .toString(),
                                    total: ordersState.orders[index]["total"]
                                            .toString() +
                                        " جم");
                              }));
                            },
                            title: Text("رقم الطلب:  " +
                                ordersState.orders[index]["id"].toString()),
                            subtitle: Text(
                                ordersState.orders[index]["total"].toString() +
                                    " جم"),
                          ),
                        );
                      }),
                ),
                ordersState.isLoadingNewItems
                    ? CircularProgressIndicator(
                        color: settings.theme!.secondary,
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> loadData(BuildContext context) async {
    if (context.read(ordersStateManagment).currentOrderPage <=
        context.read(ordersStateManagment).totalOrdersPages) {
      context.read(ordersStateManagment).setIsLoadingNewItems();
      await requestUserOrders(
          context.read(ordersStateManagment).currentOrderPage, context, false);
      context.read(ordersStateManagment).setIsLoadingNewItems();
    }
  }
}
