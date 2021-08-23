import 'package:flutter/material.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Card homeStoreCard(BuildContext context, List<dynamic> homeStores, int index) {
  return Card(
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
            backgroundImage: AssetImage("Assets/Images/PlaceHolderImage.jpeg"),
            foregroundImage: NetworkImage(
              homeStores[index]["image"].replaceAll(
                  "https://cezma.test", "https://3a21-197-37-140-248.ngrok.io"),
            ),
          ),
          Text(homeStores[index]["name"]),
        ],
      ),
    ),
  );
}
