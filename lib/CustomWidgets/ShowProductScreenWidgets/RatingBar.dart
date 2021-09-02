import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_store/Variables/ScreenSize.dart';

RatingBar ratingBar(product, BuildContext context, onRatingUpdate) {
  return RatingBar.builder(
    initialRating: 0,
    minRating: 0,
    direction: Axis.horizontal,
    itemSize: screenWidth(context) * 0.08,
    allowHalfRating: true,
    itemCount: 5,
    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: onRatingUpdate,
  );
}
