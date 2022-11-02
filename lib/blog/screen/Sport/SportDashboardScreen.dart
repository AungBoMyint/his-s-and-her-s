import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';

import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../SearchBlogScreen.dart';
import 'SportCustomHomeScreen.dart';
import 'SportHomeScreen.dart';

class SportDashboardScreen extends StatefulWidget {
  static String tag = '/FitnessDashboardScreen';

  @override
  SportDashboardScreenState createState() => SportDashboardScreenState();
}

class SportDashboardScreenState extends State<SportDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    log("Sport");
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
          elevation: 0,
          showBack: false,
          color: context.scaffoldBackgroundColor,
          titleTextStyle: GoogleFonts.poppins(
              color: textPrimaryColorGlobal,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              fontSize: 16),
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
            ? SportCustomHomeScreen()
            : SportHomeScreen());
  }
}
