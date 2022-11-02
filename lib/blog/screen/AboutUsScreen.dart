import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import '../utils/AppColor.dart';
import '../language/language.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/AppImages.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kzn/main.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/decorations.dart';
import 'WebViewScreen.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
    FacebookAudienceNetwork.init(
      iOSAdvertiserTrackingEnabled: true,
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(LanguageEn.lblAboutUs,
          showBack: true, textColor: Colors.white),
      body: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (_, snap) {
            if (snap.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(8),
                      decoration: boxDecorationRoundedWithShadowWidget(
                          defaultRadius.toInt(),
                          blurRadius: 5),
                      child: Image.asset(ic_logo, width: 120, height: 120)),
                  Text('${snap.data!.appName.validate()}',
                      style: boldTextStyle(size: 20)),
                  8.height,
                  Text('V ${snap.data!.version.validate()}',
                      style: secondaryTextStyle()),
                ],
              );
            }
            return SizedBox();
          }).center(),
      bottomNavigationBar: Container(
        height: !appStore.isSurvey ? 180 : 145,
        child: Column(
          children: [
            Text(LanguageEn.lblFollowUs, style: boldTextStyle()),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    var whatsappUrl =
                        "whatsapp://send?phone=${dashboardStore.whatsapp}";
                    launch(whatsappUrl);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    padding: EdgeInsets.all(10),
                    child: Image.asset(ic_whatsApp, height: 35, width: 35),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (dashboardStore.instagram.isNotEmpty) {
                      WebViewScreen(url: dashboardStore.instagram, name: "")
                          .launch(context);
                    } else {
                      toast(LanguageEn.txtURLEmpty);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(ic_insta, height: 35, width: 35),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (dashboardStore.twitter.isNotEmpty) {
                      WebViewScreen(url: dashboardStore.twitter, name: "")
                          .launch(context);
                    } else {
                      toast(LanguageEn.txtURLEmpty);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(ic_twitter, height: 35, width: 35),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (dashboardStore.facebook.isNotEmpty) {
                      WebViewScreen(url: dashboardStore.facebook, name: "")
                          .launch(context);
                    } else {
                      toast(LanguageEn.txtURLEmpty);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(ic_facebook, height: 35, width: 35),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (dashboardStore.contact.isNotEmpty) {
                      launch(('tel://${dashboardStore.contact.validate()}'));
                    } else {
                      toast(LanguageEn.txtURLEmpty);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.call,
                      color: appStore.isDarkMode ? Colors.white : primaryColor,
                      size: 36,
                    ),
                  ),
                )
              ],
            ),
            8.height,
            dashboardStore.copyrightText.isNotEmpty
                ? Text(dashboardStore.copyrightText,
                    style: secondaryTextStyle(letterSpacing: 1.2), maxLines: 1)
                : Text(
                    LanguageEn.lblCopyright +
                        " @${DateTime.now().year} meetmighty",
                    style: secondaryTextStyle(letterSpacing: 1.2)),
            8.height,
            showBannerAds()
          ],
        ),
      ),
    );
  }
}
