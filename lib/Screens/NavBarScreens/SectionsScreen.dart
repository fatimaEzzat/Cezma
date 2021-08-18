import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/StoresState.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({Key? key}) : super(key: key);

  @override
  _SectionsScreenState createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(
      builder: (BuildContext context,
          T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
        return AnimationLimiter(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: watch(storesStateManagment).stores.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1),
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: 3,
                    position: index,
                    duration: const Duration(milliseconds: 200),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: Column(
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    "apiBaseUrl + currentList[index][" "][0]",
                                placeholder: (context, url) => Image.asset(
                                    settings.images!.placeHolderImage),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        settings.images!.placeHolderImage),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(watch(storesStateManagment).stores[index]
                                ["name"])
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    ));
  }
}
