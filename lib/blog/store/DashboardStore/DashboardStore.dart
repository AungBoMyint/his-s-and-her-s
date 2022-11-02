import '../../model/AppConfigurationResponse.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../network/RestApi.dart';
import 'package:mobx/mobx.dart';
part 'DashboardStore.g.dart';

class DashboardStore = DashboardStoreBase with _$DashboardStore;

abstract class DashboardStoreBase with Store {
  @observable
  String dashboardType = "";

  @observable
  bool enableCustomDashboard = false;

  @observable
  bool disableQuickview = false;

  @observable
  bool disableStory = false;

  @observable
  String whatsapp = "";

  @observable
  String facebook = "";

  @observable
  String twitter = "";

  @observable
  String instagram = "";

  @observable
  String contact = "";

  @observable
  String websiteUrl = "";

  @observable
  String privacyPolicy = "";

  @observable
  String copyrightText = "";

  @observable
  String termCondition = "";

  @observable
  String bannerId = "";

  @observable
  String bannerIdIos = "";

  @observable
  String interstitialId = "";

  @observable
  String interstitialIdIos = "";

  @observable
  String adsType = "";

  @action
  Future<void> setEnableCustomDashboard(bool val) async {
    enableCustomDashboard = val;
  }

  @action
  Future<void> setDisableQuickView(bool val) async {
    disableQuickview = val;
  }

  @action
  Future<void> setDisableStory(bool val) async {
    disableStory = val;
  }

  @action
  Future<void> setWhatsapp(String val) async {
    whatsapp = val;
  }

  @action
  Future<void> setDashboardType(String val) async {
    dashboardType = val;
  }

  @action
  Future<void> setFacebook(String val) async {
    facebook = val;
  }

  @action
  Future<void> setTwitter(String val) async {
    twitter = val;
  }

  @action
  Future<void> setInstagram(String val) async {
    instagram = val;
  }

  @action
  Future<void> setContact(String val) async {
    contact = val;
  }

  @action
  Future<void> setWebsiteUrl(String val) async {
    websiteUrl = val;
  }

  @action
  Future<void> setPrivacyPolicy(String val) async {
    privacyPolicy = val;
  }

  @action
  Future<void> setCopyrightText(String val) async {
    copyrightText = val;
  }

  @action
  Future<void> setTermCondition(String val) async {
    termCondition = val;
  }

  @action
  Future<void> setBannerId(String val) async {
    bannerId = val;
  }

  @action
  Future<void> setBannerIdIos(String val) async {
    bannerIdIos = val;
  }

  @action
  Future<void> setInterstitialId(String val) async {
    interstitialId = val;
  }

  @action
  Future<void> setInterstitialIdIos(String val) async {
    interstitialIdIos = val;
  }

  @action
  Future<void> setAdsType(String val) async {
    adsType = val;
  }

  Future<void> init() async {
    AppConfigurationResponse snap = await getAppConfiguration();
    setEnableCustomDashboard(snap.enableCustomDashboard!);
    setDashboardType(snap.dashboardType!);
    setDisableQuickView(snap.disableQuickView!);
    setDisableStory(snap.disableStory!);
    setWhatsapp(snap.socialLink!.whatsapp.validate());
    setFacebook(snap.socialLink!.facebook.validate());
    setTwitter(snap.socialLink!.twitter.validate());
    setInstagram(snap.socialLink!.instagram.validate());
    setContact(snap.socialLink!.contact.validate());
    setWebsiteUrl(snap.socialLink!.websiteUrl.validate());
    setPrivacyPolicy(snap.socialLink!.privacyPolicy.validate());
    setCopyrightText(snap.socialLink!.copyrightText.validate());
    setTermCondition(snap.socialLink!.termCondition.validate());
    if (snap.admob != null) {
      setAdsType(snap.admob!.adsType.validate());
      setBannerId(snap.admob!.bannerId.validate());
      setBannerIdIos(snap.admob!.bannerIdIos.validate());
      setInterstitialId(snap.admob!.interstitialId.validate());
      setInterstitialIdIos(snap.admob!.bannerIdIos.validate());
    }
  }
}
