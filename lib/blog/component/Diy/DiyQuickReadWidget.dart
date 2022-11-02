import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';
import '../AppWidget.dart';

class DiyQuickReadWidget extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  DiyQuickReadWidget(this.list);

  @override
  _DiyQuickReadWidgetState createState() => _DiyQuickReadWidgetState();
}

class _DiyQuickReadWidgetState extends State<DiyQuickReadWidget> {
  int pos = 0;
  Timer? time;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    time = Timer.periodic(new Duration(milliseconds: 1000), (Timer t) {
      setState(() {
        pos = (pos + 1) % widget.list!.length;
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (dashboardStore.disableQuickview) return SizedBox();
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withOpacity(0.01),
            primaryColor,
            primaryColor.withOpacity(0.01),
            primaryColor,
          ],
        ),
        boxShadow: defaultBoxShadow(blurRadius: 5),
      ),
      child: Container(
        width: context.width(),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: defaultBoxShadow(blurRadius: 5)),

        ///ADD key
        child: Stack(
          children: [
            HorizontalList(
                padding: EdgeInsets.zero,
                itemCount: widget.list!.length,
                itemBuilder: (_, i) {
                  return commonCacheImageWidget(widget.list![i].image,
                      fit: BoxFit.cover, width: 100, height: 120);
                }),
            Container(
                height: 120,
                width: context.width(),
                decoration: glassBoxDecoration()),
            Column(
              children: [
                Text("Quick Look",
                        style: GoogleFonts.cormorantGaramond(
                            color: primaryColor,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 26))
                    .paddingLeft(8),
                Text(
                    "To read something quickly, especially to find the information you need",
                    style: secondaryTextStyle(color: Colors.black),
                    textAlign: TextAlign.center),
              ],
            ).paddingSymmetric(horizontal: 12, vertical: 24),
          ],
        ),
      ).onTap(() {
        QuickReadScreen(blogList: widget.list).launch(context);
      }),
    );
  }
}
