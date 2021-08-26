import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/MyStoresState.dart';
import 'package:test_store/Screens/StoreScreens/ViewMyStoreScreen.dart';
import 'package:test_store/Screens/StoreScreens/ViewStoreScreen.dart';

class StoreTransition extends StatelessWidget {
  final store;
  const StoreTransition({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context
        .read(myStoresStateManagment)
        .myStores
        .any((element) => element["id"] == store["id"])) {
      return ViewMyStore(store: store);
    } else {
      return ViewStore(
        store: store,
      );
    }
  }
}
