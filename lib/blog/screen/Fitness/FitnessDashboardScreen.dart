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
import 'FitnessCustomHomeScreen.dart';
import 'FitnessHomeScreen.dart';

class FitnessDashboardScreen extends StatefulWidget {
  static String tag = '/FitnessDashboardScreen';

  @override
  FitnessDashboardScreenState createState() => FitnessDashboardScreenState();
}

class FitnessDashboardScreenState extends State<FitnessDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    log("Fitness");
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
          center: true,
          titleTextStyle: GoogleFonts.playfairDisplay(
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
            ? FitnessCustomHomeScreen()
            : FitnessHomeScreen());
  }
}
