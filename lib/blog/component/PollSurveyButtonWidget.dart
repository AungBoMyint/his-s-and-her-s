import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pollfish/flutter_pollfish.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../main.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstant.dart';
import 'CongratulationDialogWidget.dart';
import 'CustomSettingItemWidget.dart';

class PollSurveyButtonWidget extends StatefulWidget {
  @override
  PollSurveyButtonWidgetState createState() => PollSurveyButtonWidgetState();
}

class PollSurveyButtonWidgetState extends State<PollSurveyButtonWidget> {
  String surveyAndroidKey = surveyAndroid;
  String surveyIosKey = surveyIOS;
  bool isReleaseMode = kDebugMode;
  Position indicatorPosition = Position.bottomRight;
  String requestUUID = '';

  bool _showButton = true;
  bool isClicked = false;
  int _cpa = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    initPollFish();
  }

  Future<void> initPollFish() async {
    _showButton = false;

    FlutterPollfish.instance.init(
      androidApiKey: surveyAndroidKey,
      iosApiKey: surveyIosKey,
      rewardMode: true,
      releaseMode: isReleaseMode,
      offerwallMode: false,
      requestUUID: requestUUID,
    );

    FlutterPollfish.instance
        .setPollfishSurveyReceivedListener(onPollFishSurveyReceived);

    FlutterPollfish.instance
        .setPollfishSurveyCompletedListener(onPollFishSurveyCompleted);

    FlutterPollfish.instance.setPollfishOpenedListener(onPollFishOpened);

    FlutterPollfish.instance.setPollfishClosedListener(onPollFishClosed);

    FlutterPollfish.instance
        .setPollfishSurveyNotAvailableListener(onPollFishSurveyNotAvailable);

    FlutterPollfish.instance
        .setPollfishUserRejectedSurveyListener(onPollFishUserRejectedSurvey);

    FlutterPollfish.instance
        .setPollfishUserNotEligibleListener(onPollFishUserNotEligible);
  }

  void onPollFishSurveyReceived(SurveyInfo? surveyInfo) {
    setState(() {
      if (surveyInfo != null) {
        _cpa = surveyInfo.surveyCPA ?? 0;
      }

      _showButton = true;
      appStore.setLoading(false);

      if (isClicked) FlutterPollfish.instance.show();
    });
  }

  void onPollFishSurveyCompleted(SurveyInfo? surveyInfo) async {
    await showDialog(
      context: context,
      builder: (_) {
        return CongratulationDialogWidget(
          text: "Congratulation, unlock 1 Day...!",
          freeTrialDurationInHours: 24 * 1,
        );
      },
    );
    setState(() {
      _showButton = false;
    });
  }

  void onPollFishOpened() {
    //
  }

  void onPollFishClosed() {
    //
  }

  void onPollFishSurveyNotAvailable() {
    setState(() {
      _showButton = false;
    });
  }

  void onPollFishUserRejectedSurvey() {
    setState(() {
      _showButton = false;
    });
  }

  void onPollFishUserNotEligible() {
    setState(() {
      _showButton = false;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() async {
    FlutterPollfish.instance.removeListeners();
    FlutterPollfish.instance.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return CustomSettingItemWidget(
        onTap: () {
          if (_showButton == true) {
            appStore.setLoading(false);
            FlutterPollfish.instance.show();
          } else {
            isClicked = true;
            toast('Please Wait');
          }
        },
        paddingAfterLeading: 18,
        title: "Remove Ads For 1 Day",
        leading: Icon(Ionicons.gift_outline, size: 22),
      );
    });
  }
}
