import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/GeneralWidgets/CustomGeneralButton.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/AuthScreens/LoginScreen.dart';
import 'package:test_store/Screens/SecondaryScreens/EditProfileScreen.dart';
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
                      Expanded(
                        child: SettingsList(
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
                                  leading: Icon(Icons.mail,
                                      color: settings.theme!.secondary),
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
                                    color: settings.theme!.secondary,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                                SettingsTile(
                                  title: 'كلمة السر',
                                  subtitle: "********",
                                  leading: Icon(
                                    Icons.vpn_key,
                                    color: settings.theme!.secondary,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                                SettingsTile(
                                  title: 'الدولة',
                                  subtitle: "مصر",
                                  leading: Icon(
                                    Icons.flag,
                                    color: settings.theme!.secondary,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      customGeneralButton(
                          customOnPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return EditProfilePage();
                            }));
                          },
                          context: context,
                          title: "تعديل ابيانات الشخصية",
                          primarycolor: settings.theme!.secondary,
                          titlecolor: settings.theme!.primary,
                          newIcon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          borderColor: Colors.transparent)
                    ],
                  ))),
    );
  }
}
