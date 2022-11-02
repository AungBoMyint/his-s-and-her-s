import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../utils/Extensions/device_extensions.dart';

import '../utils/AppConstant.dart';

bool _isInterstitialAdLoaded = false;

// Load InterstitialAd
void loadFacebookInterstitialAd() {
  FacebookInterstitialAd.loadInterstitialAd(
    placementId: kReleaseMode
        ? getInterstitialFacebookAdUnitId()!
        : isAndroid
            ? fbInterstitialId
            : fbInterstitialIdIos,
    listener: (result, value) {
      print(">> FAN > Interstitial Ad: $result --> $value");
      if (result == InterstitialAdResult.LOADED) _isInterstitialAdLoaded = true;

      if (result == InterstitialAdResult.DISMISSED &&
          value["invalidated"] == true) {
        _isInterstitialAdLoaded = false;
        loadFacebookInterstitialAd();
      }
    },
  );
}

// Show InterstitialAd
void showFacebookInterstitialAd() {
  if (_isInterstitialAdLoaded == true)
    FacebookInterstitialAd.showInterstitialAd();
  else
    print("Interstial Ad not yet loaded!");
}

String? getBannerFacebookAdUnitId() {
  if (Platform.isIOS) {
    return dashboardStore.bannerIdIos.isNotEmpty
        ? dashboardStore.bannerIdIos
        : fbBannerIdIos;
  } else if (Platform.isAndroid) {
    return dashboardStore.bannerId.isNotEmpty
        ? dashboardStore.bannerId
        : fbBannerId;
  }
  return null;
}

String? getInterstitialFacebookAdUnitId() {
  if (Platform.isIOS) {
    return dashboardStore.interstitialIdIos.isNotEmpty
        ? dashboardStore.interstitialIdIos
        : fbInterstitialIdIos;
  } else if (Platform.isAndroid) {
    return dashboardStore.interstitialId.isNotEmpty
        ? dashboardStore.interstitialId
        : fbInterstitialId;
  }
  return null;
}

Widget loadFacebookBannerId() {
  return FacebookBannerAd(
    placementId: kReleaseMode
        ? getBannerFacebookAdUnitId()!
        : isAndroid
            ? fbBannerId
            : fbBannerIdIos,
    bannerSize: BannerSize.STANDARD,
    listener: (result, value) {
      print("Banner Ad: $result -->  $value");
    },
  );
}
