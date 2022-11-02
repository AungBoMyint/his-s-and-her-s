import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import 'package:kzn/main.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../SearchBlogScreen.dart';
import 'MusicCustomHomeScreen.dart';
import 'MusicHomeScreen.dart';

class MusicDashboardScreen extends StatefulWidget {
  static String tag = '/MusicDashboardScreen';

  @override
  MusicDashboardScreenState createState() => MusicDashboardScreenState();
}

class MusicDashboardScreenState extends State<MusicDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(
          appName.toUpperCase(),
          elevation: 0,
          showBack: false,
          center: true,
          titleTextStyle: GoogleFonts.poppins(
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
            ? MusicCustomHomeScreen()
            : MusicHomeScreen());
  }
}
