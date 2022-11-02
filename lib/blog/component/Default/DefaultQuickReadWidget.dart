import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../utils/AppColor.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

class DefaultQuickReadWidget extends StatelessWidget {
  static String tag = '/QuickReadWidget';
  final List<DefaultPostResponse>? list;

  DefaultQuickReadWidget(this.list);

  @override
  Widget build(BuildContext context) {
    if (dashboardStore.disableQuickview) return SizedBox();
    return Container(
      width: context.width(),
      margin: EdgeInsets.only(top: 24, left: 16, bottom: 16, right: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: radius(),
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.2),
            primaryColor.withOpacity(0.6)
          ],
        ),
        boxShadow: defaultBoxShadow(blurRadius: 5),
      ),

      ///ADD key
      child: Stack(
        children: [
          Positioned(
            right: 100,
            top: -23,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: appStore.isDarkMode ? Colors.white : primaryColor),
                padding: EdgeInsets.all(20)),
          ),
          Positioned(
            right: 20,
            bottom: -23,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: appStore.isDarkMode ? Colors.white : primaryColor),
                padding: EdgeInsets.all(20)),
          ),
          Positioned(
            left: 15,
            bottom: -23,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: appStore.isDarkMode ? Colors.white : primaryColor),
                padding: EdgeInsets.all(20)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Quick Look",
                  style: boldTextStyle(size: 20, color: Colors.white)),
              Text(
                  "To read something quickly, especially to find the information you need",
                  style: secondaryTextStyle(color: Colors.white)),
            ],
          ).paddingSymmetric(horizontal: 12, vertical: 24),
        ],
      ),
    ).onTap(() {
      QuickReadScreen(blogList: list).launch(context);
    });
  }
}
