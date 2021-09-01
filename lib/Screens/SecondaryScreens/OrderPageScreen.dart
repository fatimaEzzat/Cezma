import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/ApiRequests/OrdersRequests/OrderStatus.dart';
import 'package:test_store/Logic/StateManagment/OrdersState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class OrderPageScreen extends StatelessWidget {
  final orders;
  final total;
  final statues;
  const OrderPageScreen(
      {Key? key,
      required this.orders,
      required this.total,
      required this.statues})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: BackButton(
            color: settings.theme!.secondary,
          ),
          title: Text(
            "معلومات الطلب",
            style: TextStyle(color: settings.theme!.secondary),
          ),
          centerTitle: true,
        ),
        body: Consumer(
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, listindex) {
                        final item = orders[listindex]["products"][0];
                        return Card(
                          child: ListTile(
                            title: Text(item["name"]),
                            subtitle: new RichText(
                              text: new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(
                                    text: " جم. " +
                                        (item["price"] - item["discount"])
                                            .toString(),
                                    style: new TextStyle(
                                      color: settings.theme!.secondary,
                                    ),
                                  ),
                                  new TextSpan(
                                    text: "  ",
                                    style: new TextStyle(
                                      color: settings.theme!.secondary,
                                    ),
                                  ),
                                  new TextSpan(
                                    text: item["price"].toString(),
                                    style: new TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Text(
                                orders[listindex]["qnt"].toString() + " x"),
                          ),
                        );
                      }),
                ),
                Card(
                    child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(
                          "المبلغ المدفوع",
                          style: TextStyle(
                              fontSize: screenWidth(context) * 0.040,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          total.toString(),
                          style:
                              TextStyle(fontSize: screenWidth(context) * 0.05),
                        ),
                      ),
                    ),
                    ListTile(
                        title: Text(
                          'حالة الطلب',
                          style: TextStyle(
                              fontSize: screenWidth(context) * 0.067,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(statues.toString())),
                  ],
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
