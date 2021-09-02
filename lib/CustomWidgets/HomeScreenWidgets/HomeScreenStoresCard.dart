import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/Screens/StoreScreens/StoreTransition.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Widget homeStoreCard(
    BuildContext context, List<dynamic> homeStores, int index) {
  return InkWell(
    onTap: () {
      Get.to(() => StoreTransition(store: homeStores[index]));
    },
    child: Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.065),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: screenWidth(context) * 0.07,
              backgroundImage: AssetImage("Assets/Images/PlaceHolder.png"),
              foregroundImage: NetworkImage(
                homeStores[index]["image"],
              ),
            ),
            Text(homeStores[index]["name"]),
          ],
        ),
      ),
    ),
  );
}
