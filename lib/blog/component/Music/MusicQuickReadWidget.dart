import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../main.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';
import '../AppWidget.dart';

class MusicQuickReadWidget extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  MusicQuickReadWidget(this.list);

  @override
  _MusicQuickReadWidgetState createState() => _MusicQuickReadWidgetState();
}

class _MusicQuickReadWidgetState extends State<MusicQuickReadWidget> {
  int pos = 0;
  Timer? time;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (dashboardStore.disableQuickview) return SizedBox();

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: radius(),
        boxShadow: defaultBoxShadow(blurRadius: 5),
      ),
      child: Container(
        width: context.width(),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: radius(),
          boxShadow: defaultBoxShadow(blurRadius: 5),
        ),

        ///ADD key
        child: Stack(
          alignment: Alignment.center,
          children: [
            Lottie.asset("assets/MusicQuick.json",
                width: context.width(), height: 120, fit: BoxFit.fill),
            Container(
              decoration: glassBoxDecoration(),
              child: Column(
                children: [
                  Text("Quick Look",
                          style: GoogleFonts.poppins(
                              color: textPrimaryColorGlobal,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 26),
                          textAlign: TextAlign.center)
                      .paddingLeft(8),
                  Text(
                      "To read something quickly, especially to find the information you need",
                      style: secondaryTextStyle(color: Colors.black),
                      textAlign: TextAlign.center),
                ],
              ).paddingSymmetric(horizontal: 12, vertical: 24),
            ),
          ],
        ),
      ).onTap(() {
        QuickReadScreen(blogList: widget.list).launch(context);
      }),
    );
  }
}
