import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/AppColor.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import 'package:kzn/main.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../SearchBlogScreen.dart';
import 'TravelCustomHomeScreen.dart';
import 'TravelHomeScreen.dart';

class TravelDashboardScreen extends StatefulWidget {
  static String tag = '/TravelDashboardScreen';

  @override
  TravelDashboardScreenState createState() => TravelDashboardScreenState();
}

class TravelDashboardScreenState extends State<TravelDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    log("Travel");
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
          color: primaryColor,
          showBack: false,
          titleTextStyle: GoogleFonts.robotoSlab(
              color: Colors.white,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          actions: [
            IconButton(
              onPressed: () {
                SearchBlogScreen().launch(context);
              },
              icon: Icon(Ionicons.search),
            )
          ],
        ),
        body: dashboardStore.enableCustomDashboard
            ? TravelCustomHomeScreen()
            : TravelHomeScreen());
  }
}
