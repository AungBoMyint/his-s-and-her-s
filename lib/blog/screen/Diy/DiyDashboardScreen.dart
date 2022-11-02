import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../SearchBlogScreen.dart';
import 'DiyCustomHomeScreen.dart';
import 'DiyHomeScreen.dart';

class DiyDashboardScreen extends StatefulWidget {
  static String tag = '/MusicDashboardScreen';

  @override
  DiyDashboardScreenState createState() => DiyDashboardScreenState();
}

class DiyDashboardScreenState extends State<DiyDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    log("Diy");
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
          center: true,
          titleTextStyle: GoogleFonts.cormorantGaramond(
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
            ? DiyCustomHomeScreen()
            : DiyHomeScreen());
  }
}
