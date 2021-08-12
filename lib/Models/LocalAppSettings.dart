import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:test_store/Logic/MISC/HexToColor.dart';

class LocalAppSettings {
  AppTheme? theme;
  AppIcons? images;
  LocalAppSettings({
    this.theme,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'theme': theme!.toMap(),
      'icons': images!.toMap(),
    };
  }

  factory LocalAppSettings.fromMap(Map<String, dynamic> map) {
    return LocalAppSettings(
      theme: AppTheme.fromMap(map['theme']),
      images: AppIcons.fromMap(map['images']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalAppSettings.fromJson(String source) =>
      LocalAppSettings.fromMap(json.decode(source));
}

class AppTheme {
  Color primary;
  Color secondary;
  AppTheme({
    required this.primary,
    required this.secondary,
  });

  Map<String, dynamic> toMap() {
    return {
      'primary': primary.value,
      'secondary': secondary.value,
    };
  }

  factory AppTheme.fromMap(Map<String, dynamic> map) {
    return AppTheme(
      primary: HexColor(map['primary_color']),
      secondary: HexColor(map['secondary_color']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppTheme.fromJson(String source) =>
      AppTheme.fromMap(json.decode(source));
}

class AppIcons {
  String homeIcon;
  String menuIcon;
  String ordersIcon;
  String appLogo;
  String emptyCartIcon;
  String categoriesIcon;
  String placeHolderImage;
  AppIcons(
      {required this.homeIcon,
      required this.menuIcon,
      required this.ordersIcon,
      required this.appLogo,
      required this.emptyCartIcon,
      required this.categoriesIcon,
      required this.placeHolderImage});

  Map<String, dynamic> toMap() {
    return {
      'home_icon': homeIcon,
      'menu_icon': menuIcon,
      'orders_icon': ordersIcon,
      'app_logo': appLogo,
      'empty_cart_icon': emptyCartIcon,
      "categories_icon": categoriesIcon,
      "place_holder_image": placeHolderImage
    };
  }

  factory AppIcons.fromMap(Map<String, dynamic> map) {
    return AppIcons(
      homeIcon: map['home_icon'],
      menuIcon: map['menu_icon'],
      ordersIcon: map['orders_icon'],
      appLogo: map['app_logo'],
      emptyCartIcon: map['empty_cart_icon'],
      categoriesIcon: map["categories_icon"],
      placeHolderImage: map["place_holder_image"],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppIcons.fromJson(String source) =>
      AppIcons.fromMap(json.decode(source));
}
