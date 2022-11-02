import 'dart:async';

import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../utils/AppColor.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

class FoodQuickReadWidget extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  FoodQuickReadWidget(this.list);

  @override
  _FoodQuickReadWidgetState createState() => _FoodQuickReadWidgetState();
}

class _FoodQuickReadWidgetState extends State<FoodQuickReadWidget> {
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
        color: Theme.of(context).cardColor,
        boxShadow: defaultBoxShadow(blurRadius: 5),
      ),

      ///ADD key
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.only(right: 16, top: 16, bottom: 16),
        decoration: BoxDecoration(
          color: primaryColor,
          boxShadow: defaultBoxShadow(blurRadius: 5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quick Look",
                style: boldTextStyle(size: 18, color: Colors.white)),
            Text(
                "To read something quickly, especially to find the information you need",
                style: secondaryTextStyle(color: Colors.white)),
          ],
        ),
      ),
    ).onTap(() {
      QuickReadScreen(blogList: widget.list).launch(context);
    });
  }
}
