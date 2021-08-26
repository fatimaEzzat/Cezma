import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

Card storeCard(BuildContext context, Map store) {
    return Card(
      elevation: 0.4,
      child: Column(
        children: [
          Container(
            child: CachedNetworkImage(
              width: screenWidth(context) * 0.3,
              height: screenWidth(context) * 0.3,
              fit: BoxFit.fill,
              imageUrl: store["image"].contains("placeholder")
                  ? apiBaseUrl + store["image"]
                  : store["image"],
              placeholder: (context, url) =>
                  Image.asset(settings.images!.placeHolderImage),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Text(store["name"]),
        ],
      ),
    );
  }