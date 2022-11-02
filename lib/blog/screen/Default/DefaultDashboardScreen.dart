import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../main.dart';
import '../../screen/Default/DefaultCustomHomeScreen.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../SearchBlogScreen.dart';
import 'DefaultHomeScreen.dart';

class DefaultDashboardScreen extends StatefulWidget {
  static String tag = '/DefaultDashboardScreen';

  @override
  DefaultDashboardScreenState createState() => DefaultDashboardScreenState();
}

class DefaultDashboardScreenState extends State<DefaultDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    log("default");
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: context.scaffoldBackgroundColor,
          elevation: 2,
          leading: null,
          title: Text(appName,
              style: boldTextStyle(
                  color: textPrimaryColorGlobal, letterSpacing: 1, size: 16)),
          actions: [
            IconButton(
              onPressed: () {
                SearchBlogScreen().launch(context);
              },
              icon: Icon(Ionicons.search, color: context.iconColor),
            )
          ],
        ),
        body: dashboardStore.enableCustomDashboard
            ? DefaultCustomHomeScreen()
            : DefaultHomeScreen());
  }
}
