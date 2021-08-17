import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

Widget generalCarouselSlider(
        {required int index, required List images, required}) =>
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
                imageUrl: images[imgindex].replaceAll(
                    "https://cezma.test", "http://fc23e3d0e899.ngrok.io"),
                placeholder: (context, url) =>
                    Image.asset(settings.images!.placeHolderImage),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ));
