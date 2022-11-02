import 'dart:async';

import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

class FinanceQuickReadWidget extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  FinanceQuickReadWidget(this.list);

  @override
  _FinanceQuickReadWidgetState createState() => _FinanceQuickReadWidgetState();
}

class _FinanceQuickReadWidgetState extends State<FinanceQuickReadWidget> {
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
        border: Border.all(width: 0.2),
        boxShadow: defaultBoxShadow(blurRadius: 5),
      ),
      child: Container(
        width: context.width(),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: defaultBoxShadow(blurRadius: 5),
        ),
        child: Row(
          children: [
            commonCacheImageWidget(widget.list![pos].image,
                fit: BoxFit.cover, width: 110, height: 110),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quick Look", style: boldTextStyle(size: 18)),
                Text(
                    "To read something quickly, especially to find the information you need",
                    style: secondaryTextStyle()),
              ],
            ).paddingSymmetric(horizontal: 12, vertical: 24).expand(),
          ],
        ),
      ).onTap(() {
        QuickReadScreen(blogList: widget.list).launch(context);
      }),
    );
  }
}
