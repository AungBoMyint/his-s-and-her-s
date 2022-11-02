import 'dart:async';

import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

class SportQuickReadWidget extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  SportQuickReadWidget(this.list);

  @override
  _SportQuickReadWidgetState createState() => _SportQuickReadWidgetState();
}

class _SportQuickReadWidgetState extends State<SportQuickReadWidget> {
  int pos = 0;
  Timer? time;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (dashboardStore.disableQuickview) return SizedBox();

    return Container(
      width: context.width(),
      margin: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 8),
      height: 120,
      color: primaryColor.withOpacity(0.6),
      padding: EdgeInsets.all(6),
      child: Container(
        width: context.width(),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: defaultBoxShadow(blurRadius: 5)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              left: 60,
              child: Image.asset(ic_sports,
                  width: 30, height: 30, color: Colors.yellow),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Image.asset(ic_sports,
                  width: 30, height: 30, color: Colors.green),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Quick Look", style: boldTextStyle(size: 18))
                    .paddingLeft(8),
                Text(
                    "To read something quickly, especially to find the information you need",
                    style: secondaryTextStyle(),
                    textAlign: TextAlign.center),
              ],
            ).paddingSymmetric(horizontal: 12),
          ],
        ),
      ).onTap(() {
        QuickReadScreen(blogList: widget.list).launch(context);
      }),
    );
  }
}
