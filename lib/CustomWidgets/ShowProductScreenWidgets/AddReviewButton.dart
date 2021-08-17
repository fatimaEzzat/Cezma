import 'package:flutter/material.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Container addReviewButton(BuildContext context) {
    return Container(
                width: screenWidth(context) * 0.4,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("اضافة تقييم"),
                  style: ElevatedButton.styleFrom(
                    primary: petrol,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              );
  }