import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/Screens/AuthScreens/LoginScreen.dart';
import 'package:test_store/Screens/SecondaryScreens/ProfileScreen.dart';
import 'package:test_store/Screens/SecondaryScreens/MyStore.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double start = 0;
  double end = -0.25;
  Color test = Colors.blue;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
            child: ListView(
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.05,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.14),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle, color: Colors.blue.shade900),
                    label: Text(
                      "اضافة المتجر",
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(color: Colors.blue.shade900, width: 2),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.035,
                ),
                ListTile(
                  dense: true,
                  tileColor: Colors.grey.shade100,
                  leading: Icon(Icons.person),
                  title: Text("الصفحة الشخصية"),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ProfileScreen();
                        }));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: violet,
                      )),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                ListTile(
                  dense: true,
                  tileColor: Colors.grey.shade100,
                  leading: Icon(Icons.store),
                  title: Text("متجري"),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return MyStore();
                        }));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: violet,
                      )),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                Divider(
                  thickness: 1.2,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                ListTile(
                  dense: true,
                  tileColor: Colors.grey.shade100,
                  leading: Icon(
                    Icons.info,
                  ),
                  title: Text("من نحن"),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: violet,
                      )),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                ListTile(
                  dense: true,
                  tileColor: Colors.grey.shade100,
                  leading: Icon(Icons.description),
                  title: Text("شروط الاستخدام"),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: violet,
                      )),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.013,
                ),
                ListTile(
                  dense: true,
                  tileColor: Colors.grey.shade100,
                  leading: Icon(Icons.article),
                  title: Text("سياسة الخصوصية"),
                  trailing: RotationTransition(
                    turns: Tween(begin: start, end: end).animate(_controller),
                    child: IconButton(
                        onPressed: () {
                          double temp = 0;
                          temp = start;
                          start = end;
                          end = temp;
                          setState(() {});
                          _controller.forward(from: 0);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: violet,
                        )),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                customGeneralButton(
                    customOnPressed: () async {
                      await SharedPreferences.getInstance()
                          .then((value) => value.clear());
                      Get.off(() => LoginScreen());
                    },
                    context: context,
                    title: "تسجيل الخروج",
                    primarycolor: Colors.grey.shade100,
                    titlecolor: Colors.purple.shade800,
                    newIcon: Icon(
                      Icons.logout,
                      color: Colors.purple.shade800,
                    ),
                    borderColor: Colors.grey.shade200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
