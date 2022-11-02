import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../main.dart';
import '../screen/ProfileScreen.dart';
import '../screen/BookMarkScreen.dart';
import '../screen/SignInScreen.dart';
import '../utils/AppImages.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/AppColor.dart';
import '../utils/HomeScreenConfig.dart';
import 'CategoryScreen.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = '/DashboardScreen';

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  List<Widget> widgets = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    widgets.add(getHomeWidget());
    /* widgets.add(CategoryScreen());
    widgets.add(userStore.isLoggedIn
        ? BookMarkScreen()
        : SignInScreen(isDashboard: true));
    widgets.add(ProfileScreen()); */
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget tabItem(var pos, {var icon, var img}) {
      return GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = pos;
            setState(() {});
          });
        },
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: currentIndex == pos
              ? BoxDecoration(
                  shape: BoxShape.circle, color: primaryColor.withOpacity(0.2))
              : BoxDecoration(),
          child: Icon(icon,
              color: currentIndex == pos
                  ? appStore.isDarkMode
                      ? Colors.white
                      : primaryColor
                  : textSecondaryColor),
        ),
      );
    }

    return Scaffold(
      body: widgets[currentIndex],
      bottomNavigationBar: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    color: shadowColorGlobal,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 1.0)),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: currentIndex == 0
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withOpacity(0.2))
                          : BoxDecoration(),
                      child: Image.asset(ic_logo_transparent,
                          fit: BoxFit.cover,
                          height: 32,
                          width: 32,
                          color: currentIndex == 0
                              ? appStore.isDarkMode
                                  ? Colors.white
                                  : primaryColor
                              : textSecondaryColor),
                    ),
                  ),
                  /* tabItem(1, icon: Icons.category),
                  tabItem(2, icon: Ionicons.bookmark),
                  tabItem(3, icon: FontAwesome.user), */
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
