import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../utils/AppColor.dart';
import '../utils/AppImages.dart';
import '../utils/Extensions/AppButton.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/text_styles.dart';

showDialogBox(context, title, {Function? onCall, onCancelCall}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: radius()),
          actionsPadding: EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ic_logo, fit: BoxFit.cover, height: 80, width: 80),
              16.height,
              Text(title, style: boldTextStyle(), textAlign: TextAlign.center),
            ],
          ),
          actions: [
            Row(
              children: [
                AppButtonWidget(
                  elevation: 0,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: radius(defaultAppButtonRadius),
                    side: BorderSide(color: viewLineColor),
                  ),
                  color: context.cardColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Ionicons.close_sharp,
                          color: textPrimaryColorGlobal, size: 20),
                      6.width,
                      Text("Cancel",
                          style: boldTextStyle(color: textPrimaryColorGlobal)),
                    ],
                  ).fit(),
                  onTap: () {
                    onCancelCall.call();
                  },
                ).expand(),
                16.width,
                AppButtonWidget(
                  elevation: 0,
                  color: primaryColor,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: radius(defaultAppButtonRadius),
                    side: BorderSide(color: viewLineColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, color: Colors.white, size: 20),
                      6.width,
                      Text("yes", style: boldTextStyle(color: Colors.white)),
                    ],
                  ).fit(),
                  onTap: () {
                    onCall!.call();
                  },
                ).expand(),
              ],
            ),
          ],
        );
      });
}
