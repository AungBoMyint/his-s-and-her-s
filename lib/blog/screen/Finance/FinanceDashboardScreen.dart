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
import 'FinanceCustomHomeScreen.dart';
import 'FinanceHomeScreen.dart';

class FinanceDashboardScreen extends StatefulWidget {
  static String tag = '/FitnessDashboardScreen';

  @override
  FinanceDashboardScreenState createState() => FinanceDashboardScreenState();
}

class FinanceDashboardScreenState extends State<FinanceDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    log("Finance");
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
          titleTextStyle: GoogleFonts.bebasNeue(
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
            ? FinanceCustomHomeScreen()
            : FinanceHomeScreen());
  }
}
