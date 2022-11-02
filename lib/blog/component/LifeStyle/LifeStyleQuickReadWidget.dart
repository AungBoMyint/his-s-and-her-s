import 'dart:async';

import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

class LifeStyleQuickReadWidget extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  LifeStyleQuickReadWidget(this.list);

  @override
  _LifeStyleQuickReadWidgetState createState() =>
      _LifeStyleQuickReadWidgetState();
}

class _LifeStyleQuickReadWidgetState extends State<LifeStyleQuickReadWidget> {
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
      margin: EdgeInsets.only(top: 16, right: 16, left: 16),
      padding: EdgeInsets.all(5),
      width: context.width(),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: radius(),
        boxShadow: defaultBoxShadow(blurRadius: 5),
      ),
      child: Column(
        children: [
          Text("Quick Look", style: boldTextStyle(size: 18)).paddingLeft(8),
          Text(
              "To read something quickly, especially to find the information you need",
              style: secondaryTextStyle(),
              textAlign: TextAlign.center),
        ],
      ).paddingSymmetric(horizontal: 12, vertical: 24),
    ).onTap(() {
      QuickReadScreen(blogList: widget.list).launch(context);
    });
  }
}
