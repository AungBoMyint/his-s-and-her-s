/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../component/CustomSettingItemWidget.dart';
import '../component/DialogComponent.dart';
import 'package:kzn/main.dart';
import '../language/language.dart';
import '../network/RestApi.dart';
import '../screen/ChooseTopicsScreen.dart';
import '../screen/EditProfileScreen.dart';
import '../screen/SelectThemeScreen.dart';
import '../screen/SignInScreen.dart';
import '../screen/WebViewScreen.dart';
import '../utils/AppColor.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/device_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/AppConstant.dart';
import '../utils/AppImages.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../component/PollSurveyButtonWidget.dart';
import '../model/FontSizeModel.dart';
import 'AboutUsScreen.dart';
import 'ChangePasswordScreen.dart';
import 'MultipleDemoScreen.dart';

class ProfileScreen extends StatefulWidget {
  static String tag = '/ProfileScreen';

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: context.statusBarHeight + 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                16.height,
                GestureDetector(
                  onTap: () async {
                    bool res = await EditProfileScreen().launch(context);
                    if (res == true) setState(() {});
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                          padding: EdgeInsets.all(4),
                          decoration: boxDecorationWithRoundedCornersWidget(
                              boxShape: BoxShape.circle,
                              backgroundColor: context.cardColor,
                              border: Border.all(
                                  width: 4,
                                  color: appStore.isDarkMode
                                      ? Colors.white
                                      : primaryColor)),
                          child: userStore.profileImage.isNotEmpty
                              ? CircleAvatar(
                                  backgroundColor: context.cardColor,
                                  backgroundImage:
                                      NetworkImage(userStore.profileImage),
                                  maxRadius: 55)
                              : CircleAvatar(
                                  backgroundColor: context.cardColor,
                                  backgroundImage: AssetImage(ic_profile),
                                  maxRadius: 55)),
                      Container(
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.only(right: 6, bottom: 4),
                        decoration: boxDecorationWithRoundedCornersWidget(
                            boxShape: BoxShape.circle,
                            backgroundColor: context.cardColor,
                            border:
                                Border.all(width: 0.5, color: primaryColor)),
                        child: Icon(Icons.edit,
                            size: 18, color: context.iconColor),
                      )
                    ],
                  ),
                ),
                8.height,
                Text(userStore.fName + " " + userStore.lName,
                    style: boldTextStyle(size: 20)),
                Text(userStore.email, style: secondaryTextStyle()),
                8.height,
              ],
            ).paddingSymmetric(horizontal: 16).visible(userStore.isLoggedIn),
            Divider(height: 5).visible(userStore.isLoggedIn),
            CustomSettingItemWidget(
              title: LanguageEn.lblSelectBlogType,
              leading: Icon(Ionicons.checkmark_circle_outline),
              onTap: () {
                MultipleDemoScreen().launch(context);
              },
            ).visible(enableMultipleDemo),
            Divider(height: 5).visible(enableMultipleDemo),
            CustomSettingItemWidget(
              title: LanguageEn.lblChooseTopic,
              leading: Icon(Ionicons.checkmark_circle_outline),
              onTap: () {
                ChooseTopicsScreen().launch(context);
              },
            ),
            Divider(height: 5),
            if (!appStore.isSurvey) PollSurveyButtonWidget(),
            Divider(height: 5).visible(!appStore.isSurvey),
            CustomSettingItemWidget(
              title: LanguageEn.lblChangePassword,
              leading: Icon(Ionicons.ios_key_outline),
              onTap: () {
                ChangePasswordScreen().launch(context);
              },
            ).visible(userStore.isLoggedIn &&
                !getBoolAsync(isSocial) &&
                !getBoolAsync(isOtp)),
            Divider(height: 5).visible(userStore.isLoggedIn &&
                !getBoolAsync(isSocial) &&
                !getBoolAsync(isOtp)),
            CustomSettingItemWidget(
              title: LanguageEn.lblSelectLanguageEn,
              leading: Icon(Ionicons.LanguageEn_outline),
              onTap: () async {
                hideKeyboard(context);
                bool res = await LanguageEnScreen().launch(context);
                if (res == true) setState(() {});
              },
            ),
            Divider(height: 5),
            CustomSettingItemWidget(
              title: LanguageEn.lblSelectTheme,
              leading: Icon(MaterialCommunityIcons.theme_light_dark),
              onTap: () async {
                hideKeyboard(context);
                bool res = await SelectThemeScreen().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Slide);
                if (res == true) setState(() {});
              },
            ),
            Divider(height: 5),
            CustomSettingItemWidget(
              leading: Icon(FontAwesome.font, size: 20),
              paddingAfterLeading: 20,
              title: LanguageEn.lblChooseTextSize,
              trailing: DropdownButton<FontSizeModel>(
                items: fontSizes.map((e) {
                  return DropdownMenuItem<FontSizeModel>(
                      child:
                          Text('${e.title}', style: primaryTextStyle(size: 14)),
                      value: e);
                }).toList(),
                dropdownColor: context.cardColor,
                value: fontSize,
                isDense: true,
                underline: SizedBox(),
                onChanged: (FontSizeModel? v) async {
                  hideKeyboard(context);
                  await setValue(fontSizePref, v!.fontSize);
                  fontSize = fontSizes.firstWhere((element) =>
                      element.fontSize ==
                      getIntAsync(fontSizePref, defaultValue: 16));
                  setState(() {});
                },
              ),
              onTap: () {
                //
              },
            ),
            Divider(height: 5),
            CustomSettingItemWidget(
              title: LanguageEn.lblEnableDisablePushNotification,
              leading: Icon(MaterialCommunityIcons.bell_outline),
              onTap: () async {},
              trailing: Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  activeColor: primaryColor,
                  value: appStore.isNotificationOn,
                  onChanged: (v) {
                    appStore.setNotification(v);
                    setState(() {});
                  },
                ).withHeight(10),
              ),
            ),
            Divider(height: 5),
            CustomSettingItemWidget(
              title: LanguageEn.lblShare + " " + appName,
              leading: Icon(Ionicons.share_social_outline),
              onTap: () {
                PackageInfo.fromPlatform().then((value) {
                  Share.share(
                      'Share $appName app\n$playStoreBaseURL${value.packageName}');
                });
              },
            ),
            Divider(height: 5),
            CustomSettingItemWidget(
              title: LanguageEn.lblRateUs,
              leading: Icon(AntDesign.staro),
              onTap: () {
                PackageInfo.fromPlatform().then((value) {
                  String package = '';
                  if (isAndroid) package = value.packageName;

                  launch('${storeBaseURL()}$package');
                });
              },
            ),
            Divider(height: 5),
            CustomSettingItemWidget(
              title: LanguageEn.lblPrivacyPolicy,
              leading: Icon(Ionicons.document_text_outline),
              onTap: () {
                if (dashboardStore.privacyPolicy.isNotEmpty)
                  WebViewScreen(
                          name: LanguageEn.lblPrivacyPolicy,
                          url: dashboardStore.privacyPolicy)
                      .launch(context);
                else
                  toast(LanguageEn.txtURLEmpty);
              },
            ),
            Divider(height: 5),
            CustomSettingItemWidget(
              title: LanguageEn.lblTermsCondition,
              leading: Icon(Ionicons.document_text_outline),
              onTap: () async {
                if (dashboardStore.termCondition.isNotEmpty)
                  WebViewScreen(
                          name: LanguageEn.lblTermsCondition,
                          url: dashboardStore.termCondition)
                      .launch(context);
                else
                  toast(LanguageEn.txtURLEmpty);
              },
            ),
            Divider(height: 5),
            CustomSettingItemWidget(
              title: LanguageEn.lblAboutUs,
              leading: Icon(Ionicons.md_information_circle_outline),
              onTap: () {
                hideKeyboard(context);
                AboutUsScreen().launch(context,
                    pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
              },
            ),
            Divider(height: 5),
            CustomSettingItemWidget(
              onTap: () {
                SignInScreen().launch(context);
              },
              paddingAfterLeading: 18,
              title: LanguageEn.lblSignIn,
              leading: Icon(MaterialIcons.login, size: 22),
            ).visible(!userStore.isLoggedIn),
            CustomSettingItemWidget(
              onTap: () {
                showDialogBox(context, LanguageEn.logOutTxt, onCall: () {
                  logout(context);
                  setState(() {});
                }, onCancelCall: () {
                  finish(context);
                });
              },
              paddingAfterLeading: 18,
              title: LanguageEn.lblLogOut,
              leading: Icon(SimpleLineIcons.logout, size: 22),
            ).visible(userStore.isLoggedIn),
            8.height,
          ],
        ),
      ),
    );
  }
}
 */