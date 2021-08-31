import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

Container storeCard(BuildContext context, Map store) {
  return Container(
    width: screenWidth(context) * 0.4,
    child: Card(
      elevation: 0.4,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: store["image"].contains("placeholder")
                    ? apiBaseUrl + store["image"]
                    : store["image"],
                placeholder: (context, url) =>
                    Image.asset(settings.images!.placeHolderImage),
                errorWidget: (context, url, error) =>
                    Image.asset(settings.images!.placeHolderImage),
              ),
            ),
          ),
          Text(store["name"]),
        ],
      ),
    ),
  );
}
