import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

Widget generalCarouselSlider({required String images}) =>
    CarouselSlider.builder(
        options: CarouselOptions(
          enlargeCenterPage: false,
          viewportFraction: 1,
        ),
        itemCount: 1,
        itemBuilder: (context, imgindex, pageindex) => Container(
              width: screenWidth(context),
              color: Colors.transparent,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: images.replaceAll("https://cezma.test", apiBaseUrl),
                placeholder: (context, url) =>
                    Image.asset(settings.images!.placeHolderImage),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ));
