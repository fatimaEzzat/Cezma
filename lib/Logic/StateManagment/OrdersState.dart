import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final ordersStateManagment =
    ChangeNotifierProvider<OrdersState>((ref) => OrdersState());

class OrdersState extends ChangeNotifier {
  late int currentOrderPage = 1;
  late int totalOrdersPages = 0;
  List orders = [];
  bool isLoadingNewItems = false;

  void setIsLoadingNewItems() {
    isLoadingNewItems = !isLoadingNewItems;

    notifyListeners();
  }

  void setTotalOrderPages(int totalPages) {
    totalOrdersPages = totalPages;
    notifyListeners();
  }

  void addOrders(List input) {
    orders.addAll(input);
    notifyListeners();
  }

  void setCurrentOrderPage(int cOPage) {
    currentOrderPage = cOPage;
    notifyListeners();
  }
}
