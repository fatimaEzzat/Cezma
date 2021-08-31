import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/PlansState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/EndPoints.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:test_store/Variables/Settings.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  late final plans;
  int selectedPlan = 0;
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    plans = context.read(plansStateManagment).plans;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: context.read(plansStateManagment).plans.length,
                itemBuilder: (BuildContext context, int index) {
                  late final discount;
                  if (plans[index]["discount"] != null) {
                    discount =
                        (plans[index]["discount"] / plans[index]["price"]) *
                            100;
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedPlan = index;
                      });
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenHeight(context) * 0.02),
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: selectedPlan == index
                                ? BorderSide(color: violet, width: 2)
                                : BorderSide.none),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: apiMockImage,
                                  placeholder: (context, url) => Image.asset(
                                      settings.images!.placeHolderImage),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          settings.images!.placeHolderImage),
                                ),
                                plans[index]["discount"] != null
                                    ? Align(
                                        alignment: AlignmentDirectional.topEnd,
                                        child: FittedBox(
                                          fit: BoxFit.none,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            color: Colors.red,
                                            child: AutoSizeText(
                                              "خصم " +
                                                  "%" +
                                                  discount.toStringAsFixed(1),
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        plans[index]["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(plans[index]["total"].toString() +
                                          " جم " +
                                          "(" +
                                          plans[index]["type"] +
                                          ")"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight(context) * 0.01,
                                  )
                                ],
                              ),
                              subtitle: Text(
                                plans[index]["description"],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenHeight(context) * 0.019),
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.zero,
                                iconColor: violet,
                                textColor: violet,
                                title: Text("المواصفات"),
                                children: plans[index]["features"]
                                    .map<Widget>((e) => Text(e["feature"]))
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            customGeneralButton(
                customOnPressed: () {},
                context: context,
                title: "اشترك الان",
                primarycolor: violet,
                titlecolor: Colors.white,
                newIcon: Icon(Icons.card_membership),
                borderColor: violet)
          ],
        ),
      ),
    );
  }
}
