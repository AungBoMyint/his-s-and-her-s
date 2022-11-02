import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzn/bottom_nav/bottombar.dart';
import '../../main.dart';
import '../../ui/routes/main_route.dart';
import '../screen/DashboardScreen.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/AppImages.dart';
import '../utils/Extensions/Widget_extensions.dart';

import 'WalkThroughScreen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    dashboardStore.init().whenComplete(() {
      checkFirstSeen();
    });
    await Future.delayed(Duration(seconds: 2));
  }

  Future checkFirstSeen() async {
    bool seen = (getBoolAsync('isFirstTime'));
    if (seen) {
      Get.off(() => BottomBar());
      /*  DashboardScreen().launch(context, isNewTask: true); */
    } else {
      await setValue('isFirstTime', true);
      WalkThroughScreen().launch(context, isNewTask: true);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(10),
              decoration: boxDecorationRoundedWithShadowWidget(
                  defaultRadius.toInt(),
                  blurRadius: 5),
              child: Image.asset(ic_logo, width: 120, height: 120)),
          Text(appName, style: boldTextStyle(size: 24)),
        ],
      ).center(),
    );
  }
}
