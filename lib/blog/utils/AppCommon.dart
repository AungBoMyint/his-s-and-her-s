import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../component/SelectLanguageWidget.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/device_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/AppColor.dart';
import '../utils/AppImages.dart';
import '../component/AdmobAdComponent.dart';
import '../component/FacebookAdComponent.dart';
import '../model/BlogDetailResponse.dart';
import 'AppConstant.dart';
import 'Extensions/Colors.dart';
import 'Extensions/decorations.dart';
import 'Extensions/shared_pref.dart';

InputDecoration inputDecoration(BuildContext context,
    {String? label, Widget? prefixIcon}) {
  return InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide(color: Colors.transparent)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide(color: context.theme.colorScheme.error)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide(color: Colors.transparent)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide(color: Colors.transparent)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide(color: Colors.transparent)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide(color: context.theme.colorScheme.error)),
    alignLabelWithHint: true,
    filled: true,
    isDense: true,
    labelText: label ?? "Sample Text",
    labelStyle: secondaryTextStyle(),
  );
}

defaultSetting() {
  defaultRadius = 16;
  appBarBackgroundColorGlobal = primaryColor;
  appButtonBackgroundColorGlobal = primaryColor;
  defaultAppButtonTextColorGlobal = Colors.white;
  defaultAppButtonRadius = defaultRadius;
  defaultBlurRadius = 0;
  defaultSpreadRadius = 0;
}

toast(String? value,
    {ToastGravity? gravity,
    length = Toast.LENGTH_SHORT,
    Color? bgColor,
    Color? textColor}) {
  Fluttertoast.showToast(
    msg: value.validate(),
    toastLength: length,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: bgColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}

Widget appButton(context, text, onTap) {
  return InkWell(
    borderRadius: radiusWidget(23),
    onTap: () {
      onTap();
    },
    child: Container(
      alignment: Alignment.center,
      //width: context.width(),
      height: 45,
      child: Text(text, style: boldTextStyle(color: Colors.white)),
      decoration: boxDecorationWithRoundedCornersWidget(
          borderRadius: radiusWidget(23), backgroundColor: primaryColor),
    ),
  );
}

Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() => Image.asset(ic_placeHolder, fit: BoxFit.fill);

Widget placeholderImageWidget({width, height}) => Image.asset(
      ic_placeHolder,
      fit: BoxFit.fill,
      width: width,
      height: height,
    );

Widget commonCacheImageWidget(String? url,
    {double? width, BoxFit? fit, double? height}) {
  if (url.toString().startsWith('http')) {
    if (isMobile) {
      return CachedNetworkImage(
        placeholder:
            placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: '$url',
        height: height,
        width: width,
        fit: fit,
      );
    } else {
      return Image.network(url!, height: height, width: width, fit: fit);
    }
  } else {
    return Image.asset(ic_placeHolder, height: height, width: width, fit: fit);
  }
}

Widget dotIndicator(list, i, {bool isPersonal = false}) {
  return SizedBox(
    height: 16,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        list.length,
        (ind) {
          return Container(
            height: isPersonal == true ? 6 : 4,
            width: isPersonal == true ? 6 : 20,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: i == ind ? primaryColor : Colors.grey.withOpacity(0.5),
                borderRadius: radiusWidget(4)),
          );
        },
      ),
    ),
  );
}

setLogInValue() {
  userStore.setLogin(getBoolAsync(isLogIn), isInitializing: true);
  userStore.setToken(getStringAsync(apiToken), isInitialization: true);
  userStore.setUserID(getIntAsync(uId), isInitialization: true);
  userStore.setUserEmail(getStringAsync(userEmail), isInitialization: true);
  userStore.setFirstName(getStringAsync(firstName), isInitialization: true);
  userStore.setLastName(getStringAsync(lastName), isInitialization: true);
  userStore.setUserPassword(getStringAsync(userPassword),
      isInitialization: true);
  userStore.setUserImage(getStringAsync(userPhotoUrl), isInitialization: true);
}

String storeBaseURL() {
  return isAndroid ? playStoreBaseURL : appStoreBaseURL;
}

dateConverter(date) {
  DateTime now = DateTime.parse(date);
  log(DateFormat.yMMMEd().add_jms().format(now));
  return DateFormat.yMMMEd().add_jms().format(now);
}

void textToSpeech(BuildContext context, BlogDetailResponse detailData,
    String mLanguage, String postContent) async {
  /* String? res = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
    backgroundColor: Colors.transparent,
    builder: (context) => SelectLanguageWidget(language: mLanguage),
  ); */
/* 
  if (res.validate().isNotEmpty) {
    postDetailStore.setBodyTranslated(true);
    mLanguage = res!;

    postDetailStore.translatePostTitle(
        parseHtmlString(detailData.postTitle.validate()),
        language: mLanguage);
    postDetailStore.translatePostContent(parseHtmlString(postContent),
        language: mLanguage);
  } */
}

Future<void> setPostContent(
    BlogDetailResponse detailData, String mLanguage, String postContent) async {
  postDetailStore.setBodyTranslated(true);
  postDetailStore.translatePostTitle(
      parseHtmlString(detailData.postTitle.validate()),
      language: mLanguage);
  postDetailStore.translatePostContent(parseHtmlString(postContent),
      language: mLanguage);
}

Widget showBannerAds() {
  return !appStore.isSurvey
      ? dashboardStore.adsType.toString() == isGoogleAds
          ? Container(
              height: 60,
              child: AdWidget(
                ad: BannerAd(
                  adUnitId: /* kReleaseMode ? */ getBannerAdUnitId()! /*  : BannerAd.testAdUnitId */,
                  size: AdSize.banner,
                  request: AdRequest(),
                  listener: BannerAdListener(),
                )..load(),
              ),
            )
          : loadFacebookBannerId()
      : SizedBox();
}

void loadInterstitialAds() {
  if (appStore.isSurvey == false) {
    dashboardStore.adsType.toString() == isGoogleAds
        ? createInterstitialAd()
        : loadFacebookInterstitialAd();
  }
}

void showInterstitialAds() {
  if (appStore.isSurvey == false) {
    dashboardStore.adsType.toString() == isGoogleAds
        ? adShow()
        : showFacebookInterstitialAd();
  }
}

Future<void> startFreeTrial({required int freeTrialDurationInHour}) async {
  await setValue(IS_FREE_TRIAL_START, true);
  await setValue(FREE_TRIAL_DURATION, DateTime.now().millisecondsSinceEpoch);
  await setValue(FREE_TRIAL_TOTAL_DURATION, freeTrialDurationInHour);

  startTimer();
  await setValue(IS_SURVEY, true);
  appStore.setSurveyStatus();
}

void startTimer() async {
  if (DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(
              getIntAsync(FREE_TRIAL_DURATION)))
          .inHours <
      getIntAsync(FREE_TRIAL_TOTAL_DURATION)) {
    rewardTimer = Timer.periodic(const Duration(hours: 1), (timer) async {
      startTimer();
    });
  } else {
    closeTimer();
  }
}

void closeTimer() async {
  await setValue(IS_SURVEY, false);
  await setValue(FREE_TRIAL_DURATION, 0);
  await setValue(FREE_TRIAL_TOTAL_DURATION, 0);
  await setValue(IS_FREE_TRIAL_START, false);
  appStore.setSurveyStatus();
  rewardTimer?.cancel();
}
