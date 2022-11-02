import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

class NewsQuickReadWidget extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  NewsQuickReadWidget(this.list);

  @override
  _NewsQuickReadWidgetState createState() => _NewsQuickReadWidgetState();
}

class _NewsQuickReadWidgetState extends State<NewsQuickReadWidget> {
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
      width: context.width(),
      decoration: BoxDecoration(
          borderRadius: radius(),
          color: Theme.of(context).cardColor,
          boxShadow: defaultBoxShadow(blurRadius: 5)),
      child: Row(
        children: [
          Column(
            children: [
              Text("Quick Look",
                      style: GoogleFonts.ptSerif(
                          color: textPrimaryColorGlobal,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 24))
                  .paddingLeft(8),
              Text(
                  "To read something quickly, especially to find the information you need",
                  style: secondaryTextStyle(),
                  textAlign: TextAlign.center),
            ],
          ).paddingSymmetric(horizontal: 12, vertical: 24).expand(),
        ],
      ),
    ).onTap(() {
      QuickReadScreen(blogList: widget.list).launch(context);
    });
  }
}
