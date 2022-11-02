import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../SearchBlogScreen.dart';
import 'FoodCustomHomeScreen.dart';
import 'FoodHomeScreen.dart';

class FoodDashboardScreen extends StatefulWidget {
  @override
  _FoodDashboardScreenState createState() => _FoodDashboardScreenState();
}

class _FoodDashboardScreenState extends State<FoodDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    log("Food");
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
          center: true,
          elevation: 0,
          showBack: false,
          color: context.scaffoldBackgroundColor,
          titleTextStyle: GoogleFonts.notoSerif(
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
            ? FoodCustomHomeScreen()
            : FoodHomeScreen());
  }
}
