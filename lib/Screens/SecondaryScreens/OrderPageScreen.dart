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
  final int index;
  final String id;
  final total;
  const OrderPageScreen(
      {Key? key, required this.index, required this.id, required this.total})
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
            final ordersState = watch(ordersStateManagment);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: ordersState.orders[index]["items"].length,
                      itemBuilder: (context, listindex) {
                        final item = ordersState.orders[index]["items"]
                            [listindex]["product_id"];
                        return Card(
                          child: ListTile(
                            leading: Container(
                              width: screenWidth(context) * 0.2,
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: apiBaseUrl + item["images"][0],
                                placeholder: (context, url) => Image.asset(
                                    "settings.images!.placeHolderImage.jpeg"),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        settings.images!.placeHolderImage),
                              ),
                            ),
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
                          total,
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
                      trailing: FutureBuilder(
                        future: requestOrderStatus(
                            context.read(userStateManagment).userToken!, id),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data["status"],
                              style: TextStyle(
                                  fontSize: screenWidth(context) * 0.07),
                            );
                          }
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return CircularProgressIndicator(
                              color: settings.theme!.secondary,
                            );
                          }
                        },
                      ),
                    ),
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
