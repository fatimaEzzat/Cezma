import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Screens/SecondaryScreens/AddProductScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class MyStore extends StatefulWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: secondaryAppBar(context: context, title: 'متجري'),
        body: Center(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  "الشامي ستورز",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight(context) * 0.02),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                Text("الكترونيات/موبيلات"),
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
                      onPressed: () {},
                      icon: Icon(Icons.chat_bubble_rounded),
                      label: Text("محادثة المتجر")),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                Text("وصف المتجر هذا النص هو"),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    tileColor: Colors.grey.shade200,
                    leading: Icon(Icons.phone),
                    title: Text("01061715164"),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    tileColor: Colors.grey.shade200,
                    leading: Icon(Icons.room),
                    title: Text("القاهرة مدينة نصر"),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Container(
                  width: screenWidth(context),
                  height: screenHeight(context) * 0.055,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: new LinearGradient(
                        colors: [Colors.blue.shade900, Colors.purple.shade900]),
                  ),
                  child: customGeneralButton(
                      customOnPressed: () {
                        Get.to(() => AddProductScreen());
                      },
                      context: context,
                      title: "اضافة منتج",
                      primarycolor: Colors.transparent,
                      titlecolor: Colors.white,
                      newIcon: Icon(Icons.add),
                      borderColor: Colors.transparent),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
