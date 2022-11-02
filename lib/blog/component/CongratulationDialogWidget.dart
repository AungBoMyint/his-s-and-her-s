import 'package:flutter/material.dart';
import '../../main.dart';
import '../utils/AppColor.dart';
import '../utils/Extensions/AppButton.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/text_styles.dart';

class CongratulationDialogWidget extends StatefulWidget {
  final String? text;
  final int? freeTrialDurationInHours;

  CongratulationDialogWidget(
      {required this.text, required this.freeTrialDurationInHours});

  _CongratulationDialogWidgetState createState() =>
      _CongratulationDialogWidgetState();
}

class _CongratulationDialogWidgetState extends State<CongratulationDialogWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);

    _controller.forward();

    startFreeTrial(
        freeTrialDurationInHour: widget.freeTrialDurationInHours.validate());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.only(left: 8, top: 32, right: 8, bottom: 16),
            decoration: ShapeDecoration(
                color: appStore.isDarkMode ? primaryColor : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.text!.validate(),
                    style: primaryTextStyle(size: 20, wordSpacing: 2),
                    textAlign: TextAlign.center),
                16.height,
                AppButtonWidget(
                  color: primaryColor,
                  textColor: Colors.white,
                  text: "Cancel",
                  onTap: () async {
                    finish(context);
                    finish(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
