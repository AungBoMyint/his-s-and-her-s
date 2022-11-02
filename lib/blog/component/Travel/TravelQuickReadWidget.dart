import 'dart:async';

import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

class TravelQuickReadWidget extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  TravelQuickReadWidget(this.list);

  @override
  _TravelQuickReadWidgetState createState() => _TravelQuickReadWidgetState();
}

class _TravelQuickReadWidgetState extends State<TravelQuickReadWidget> {
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
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(5),
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
          children: [
            Positioned(
              right: 20,
              top: 10,
              child: Image.asset(ic_quickTravel1,
                  width: 30, height: 30, color: Colors.blue),
            ),
            Positioned(
              left: 60,
              child: Image.asset(ic_quickTravel2,
                  width: 30, height: 30, color: Colors.yellow),
            ),
            Positioned(
              right: 150,
              bottom: 10,
              child: Image.asset(ic_quickTravel3,
                  width: 30, height: 30, color: Colors.green),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quick Look", style: boldTextStyle(size: 20)),
                Text(
                    "To read something quickly, especially to find the information you need",
                    style: secondaryTextStyle()),
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
