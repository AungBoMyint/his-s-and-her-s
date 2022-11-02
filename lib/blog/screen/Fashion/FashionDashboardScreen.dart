import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import 'package:kzn/main.dart';
import '../SearchBlogScreen.dart';
import 'FashionCustomHomeScreen.dart';
import 'FashionHomeScreen.dart';

class FashionDashboardScreen extends StatefulWidget {
  @override
  _FashionDashboardScreenState createState() => _FashionDashboardScreenState();
}

class _FashionDashboardScreenState extends State<FashionDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    log("Fashion");
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
          titleTextStyle: GoogleFonts.redressed(
              letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 16),
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
            ? FashionCustomHomeScreen()
            : FashionHomeScreen());
  }
}
