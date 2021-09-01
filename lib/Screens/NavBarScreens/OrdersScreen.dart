import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/PrimaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/OrdersRequests/Orders.dart';
import 'package:test_store/Logic/StateManagment/OrdersState.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/SecondaryScreens/OrderPageScreen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _scrollController = ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late String? userToken = "";
  late int id;
  late var response;
  @override
  void initState() {
    userToken = context.read(userStateManagment).userToken;
    id = context.read(userStateManagment).userId!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: primaryAppBar(context: context),
        body: Consumer(
          builder: (context, watch, child) {
            final ordersState = watch(ordersStateManagment);
            return SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              onLoading: () async {
                await loadData(context)
                    .then((value) => _refreshController.loadComplete());
              },
              onRefresh: () {
                requestUserOrders(1, context, true)
                    .then((value) => _refreshController.refreshCompleted());
              },
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
                              orders: ordersState.orders[index]["carts"],
                              statues: ordersState.orders[index]["status"],
                              total: ordersState.orders[index]["total"],
                            );
                          }));
                        },
                        trailing: Text(
                            ordersState.orders[index]["status"].toString()),
                        title: Text("رقم الطلب:  " +
                            ordersState.orders[index]["id"].toString()),
                        subtitle: Text(
                            ordersState.orders[index]["total"].toString() +
                                " جم"),
                      ),
                    );
                  }),
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
