import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import 'package:kzn/main.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../SearchBlogScreen.dart';
import 'NewsCustomHomeScreen.dart';
import 'NewsHomeScreen.dart';

class NewsDashboardScreen extends StatefulWidget {
  static String tag = '/NewsDashboardScreen';

  @override
  NewsDashboardScreenState createState() => NewsDashboardScreenState();
}

class NewsDashboardScreenState extends State<NewsDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    log("News");
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(
          appName,
          showBack: false,
          center: true,
          color: context.scaffoldBackgroundColor,
          titleTextStyle: GoogleFonts.arapey(
              color: textPrimaryColorGlobal,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              fontSize: 20),
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
            ? NewsCustomHomeScreen()
            : NewsHomeScreen());
  }
}
