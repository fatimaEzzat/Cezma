import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/Decorations/CustomFormFieldDecoration.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/NewMessagePopUp.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/ProductsCard.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/ApiRequests/MessagingRequests/SendMessage.dart';
import 'package:test_store/Logic/ApiRequests/StoresRequest/StoreProductsRequest.dart';
import 'package:test_store/Logic/StateManagment/StoresState.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class ViewStore extends StatefulWidget {
  final store;
  const ViewStore({Key? key, required this.store}) : super(key: key);

  @override
  _ViewStoreState createState() => _ViewStoreState();
}

class _ViewStoreState extends State<ViewStore> {
  final _formkey = GlobalKey<FormBuilderState>();
  String message = "";
  @override
  void initState() {
    requestStoreProducts(
            isRefresh: true,
            context: context,
            userName: widget.store["username"],
            currentPage: 1)
        .then((value) => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(context: context, title: widget.store["name"]),
        body: Container(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.03),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.04,
                ),
                CircleAvatar(
                  radius: screenHeight(context) * 0.055,
                  backgroundImage: AssetImage(
                    "Assets/Images/PlaceHolderImage.jpeg",
                  ),
                ),
                Text(
                  widget.store["name"],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight(context) * 0.02),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                Text(widget.store["description"].toString()),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                Container(
                  height: screenHeight(context) * 0.04,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: new LinearGradient(
                        colors: [Colors.blue.shade900, Colors.purple.shade900]),
                  ),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent, elevation: 0),
                      onPressed: () {
                        Get.defaultDialog(
                            title: "اكتب رسالتك",
                            content: FormBuilder(
                              key: _formkey,
                              child: Column(
                                children: [
                                  FormBuilderTextField(
                                    validator:
                                        FormBuilderValidators.required(context),
                                    cursorColor: violet,
                                    name: "nessage",
                                    maxLines: 4,
                                    onChanged: (value) {
                                      message = value!;
                                    },
                                    decoration: customformfielddecoration(
                                        context: context,
                                        color: Colors.grey.shade200),
                                  ),
                                  customGeneralButton(
                                      customOnPressed: () async {
                                        newMessagePopUp(
                                            context, widget.store["id"]);
                                        Get.back();
                                        Get.defaultDialog(
                                            title: "تم",
                                            middleText:
                                                "تم ارسال الرسالة للمتجر");
                                      },
                                      context: context,
                                      title: "ارسل",
                                      primarycolor: violet,
                                      titlecolor: Colors.white,
                                      newIcon: Icon(Icons.send),
                                      borderColor: Colors.transparent)
                                ],
                              ),
                            ));
                      },
                      icon: Icon(Icons.chat_bubble_rounded),
                      label: Text("محادثة المتجر")),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                widget.store["categories"] == null
                    ? Container()
                    : RichText(
                        text: new TextSpan(
                          children: widget.store["categories"]
                              .map<TextSpan>((e) => TextSpan(
                                  text: "/" + e["name"].toString(),
                                  style: TextStyle(color: Colors.black)))
                              .toList(),
                        ),
                      ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    tileColor: Colors.grey.shade200,
                    leading: Icon(Icons.phone),
                    title: Text(widget.store["phone"].toString()),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    tileColor: Colors.grey.shade200,
                    leading: Icon(Icons.room),
                    title: Text(widget.store["address"].toString()),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: AnimationLimiter(
                    child: Consumer(
                      builder: (BuildContext context,
                              T Function<T>(ProviderBase<Object?, T>) watch,
                              Widget? child) =>
                          GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.40 / 0.6,
                                      crossAxisCount: 2),
                              itemCount: watch(storesStateManagment)
                                  .storeProducts
                                  .length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  columnCount: 2,
                                  position: index,
                                  duration: const Duration(milliseconds: 200),
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                        child: productsCard(
                                      context: context,
                                      currentItem: watch(storesStateManagment)
                                          .storeProducts[index],
                                    )),
                                  ),
                                );
                              }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
