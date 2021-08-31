import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:test_store/Logic/ApiRequests/FullRequest.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Screens/ProfileScreens/EditProfileScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import '../NavBarScreens/NavigationBar.dart';

// this splash screen will retrieve all the basic data required for the app( products, categories, order, etc.)

class CustomSplashScreen extends StatelessWidget {
  CustomSplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.blue.shade900, Colors.purple.shade900]),
      ),
      child: AnimatedSplashScreen.withScreenFunction(
        splash: SvgPicture.asset(
          "Assets/Logos/SplashScreenLogo.svg",
          height: screenHeight(context) * 0.2,
        ),
        backgroundColor: Colors.transparent,
        screenFunction: () async {
          await SharedPreferences.getInstance().then((sharedvalue) async {
            context.read(userStateManagment).userToken =
                sharedvalue.getString("token").toString();
            await firstSuperRequest(
                context: context,
                pageNumber: 1,
                userId: sharedvalue.getString("user_id").toString(),
                userToken: sharedvalue.getString("token"));
          });

          if (context.read(userStateManagment).userInfo!.firstName != null) {
            return CustomNavigationBar();
          } else {
            return EditProfilePage();
          }
        },
      ),
    );
  }
}
