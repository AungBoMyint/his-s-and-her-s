import 'package:flutter/material.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/AppColor.dart';
import '../utils/AppConstant.dart';
import 'package:mobx/mobx.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../utils/Extensions/device_extensions.dart';
import '../utils/Extensions/shared_pref.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool isDarkMode = false;

  @observable
  bool isLoading = false;

  @observable
  String selectedLanguage = "";

  @observable
  bool isSurvey = false;

  @observable
  bool isNotificationOn = false;

  @action
  void setNotification(bool val) {
    isNotificationOn = val;
    setValue(notificationOn, val);

    if (isMobile) {
      OneSignal.shared.disablePush(!val);
    }
  }

  @action
  void setLoading(bool val) => isLoading = val;

  @action
  Future<void> setSurveyStatus() async {
    if (getBoolAsync(IS_FREE_TRIAL_START)) {
      isSurvey = true;
    } else {
      isSurvey = false;
    }
  }

  @action
  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkMode = aIsDarkMode;

    if (isDarkMode) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = viewLineColor;
      /*  defaultLoaderBgColorGlobal = Colors.black26;
      defaultLoaderAccentColorGlobal = Colors.white; */
      appButtonBackgroundColorGlobal = Colors.white;
      shadowColorGlobal = Colors.white12;
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;

      /*   defaultLoaderBgColorGlobal = Colors.white; */
      appButtonBackgroundColorGlobal = primaryColor;
      shadowColorGlobal = Colors.black12;
    }
  }

  @action
  Future<void> setLanguage(String aCode, {BuildContext? context}) async {
    /* selectedLanguageDataModel = getSelectedLanguageModel(defaultLanguage: defaultValues.defaultLanguage);
    selectedLanguage = getSelectedLanguageModel(defaultLanguage: defaultValues.defaultLanguage)!.languageCode!;

    if (context != null) language = BaseLanguage.of(context)!;
    language = await AppLocalizations().load(Locale(selectedLanguage)); */
  }
}
