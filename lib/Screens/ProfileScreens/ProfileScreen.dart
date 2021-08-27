import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/GeneralButton.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/SecondaryAppBar.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/ProfileScreens/EditProfileScreen.dart';
import 'package:test_store/Variables/CustomColors.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/Variables/Settings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: secondaryAppBar(context: context, title: "الصفحة الشخصية"),
          body: Consumer(
              builder: (context, watch, child) => Column(
                    children: [
                      SizedBox(
                        height: screenHeight(context) * 0.03,
                      ),
                      CircleAvatar(
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: "",
                          placeholder: (context, url) =>
                              Image.asset(settings.images!.placeHolderImage),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        radius: 50,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: Text(
                          watch(userStateManagment)
                              .userInfo!
                              .fullName
                              .toString(),
                          style: TextStyle(fontSize: width * 0.05),
                        ),
                      ),
                      SettingsList(
                        shrinkWrap: true,
                        contentPadding: EdgeInsets.only(top: height * 0.02),
                        backgroundColor: Colors.white,
                        sections: [
                          SettingsSection(
                            tiles: [
                              SettingsTile(
                                title: 'البريد الالكتروني',
                                subtitle: watch(userStateManagment)
                                    .userInfo!
                                    .email
                                    .toString(),
                                leading: Icon(Icons.mail, color: violet),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile(
                                title: 'الهاتف',
                                subtitle: watch(userStateManagment)
                                    .userInfo!
                                    .phone
                                    .toString(),
                                leading: Icon(
                                  Icons.phone,
                                  color: violet,
                                ),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile(
                                title: 'كلمة السر',
                                subtitle: "********",
                                leading: Icon(
                                  Icons.vpn_key,
                                  color: violet,
                                ),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile(
                                title: 'الدولة',
                                subtitle: "مصر",
                                leading: Icon(
                                  Icons.flag,
                                  color: violet,
                                ),
                                onPressed: (BuildContext context) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.2,
                      ),
                      Container(
                        height: screenHeight(context) * 0.05,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: new LinearGradient(colors: [
                            Colors.blue.shade900,
                            Colors.purple.shade900
                          ]),
                        ),
                        child: customGeneralButton(
                            customOnPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return EditProfilePage();
                              }));
                            },
                            context: context,
                            title: "تعديل ابيانات الشخصية",
                            primarycolor: Colors.transparent,
                            titlecolor: settings.theme!.primary,
                            newIcon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            borderColor: Colors.transparent),
                      )
                    ],
                  ))),
    );
  }
}
