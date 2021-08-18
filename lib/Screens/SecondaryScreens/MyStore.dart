import 'package:flutter/material.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class MyStore extends StatefulWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context: context, title: 'متجري'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Text("الكترونيات/موبيلات")
          ],
        ),
      ),
    );
  }
}
