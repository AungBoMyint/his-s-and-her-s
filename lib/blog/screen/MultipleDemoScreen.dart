import 'package:flutter/material.dart';
import 'package:kzn/main.dart';
import '../language/language.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/string_extensions.dart';
import '../model/ServerModal.dart';
import '../network/RestApi.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/text_styles.dart';

class MultipleDemoScreen extends StatefulWidget {
  @override
  _MultipleDemoScreenState createState() => _MultipleDemoScreenState();
}

class _MultipleDemoScreenState extends State<MultipleDemoScreen> {
  int selectedIndex = 0;
  String mAppUrl = "";
  bool mIsLoggedIn = false;

  int i = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
    mIsLoggedIn = userStore.isLoggedIn;
  }

  Widget itemWidget(
      {required Function onTap,
      String? title,
      int code = 0,
      required String img}) {
    return Container(
      width: (context.width() - 44) / 2,
      height: context.height() * 0.35,
      decoration: boxDecorationWithShadowWidget(
        backgroundColor: context.cardColor,
        borderRadius: radius(defaultRadius),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(img,
                  fit: BoxFit.cover, alignment: Alignment.topCenter, height: 50)
              .cornerRadiusWithClipRRect(defaultRadius),
          AnimatedContainer(
            duration: Duration(milliseconds: 800),
            decoration: BoxDecoration(
                color: getIntAsync(DETAIL_PAGE_VARIANT, defaultValue: 0) == code
                    ? Colors.black12
                    : Colors.black45,
                borderRadius: radius(defaultRadius)),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 800),
            child: Text(title!.validate(),
                style: boldTextStyle(), textAlign: TextAlign.center),
            decoration: BoxDecoration(
                color: getIntAsync(DETAIL_PAGE_VARIANT, defaultValue: 0) == code
                    ? context.cardColor
                    : Colors.white54,
                borderRadius: radius(defaultRadius)),
            padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
          ).center(),
          Positioned(
            bottom: 8,
            right: 8,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 800),
              padding: EdgeInsets.all(4),
              child: Icon(Icons.check, size: 18, color: context.iconColor),
              decoration: BoxDecoration(
                  color: context.cardColor,
                  shape: BoxShape.circle,
                  boxShadow: defaultBoxShadow()),
            ).visible(
                getIntAsync(DETAIL_PAGE_VARIANT, defaultValue: 0) == code),
          ),
        ],
      ),
    ).onTap(() async {
      onTap.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(LanguageEn.lblMultipleDemo,
          showBack: true,
          textColor: Colors.white,
          actions: [
            IconButton(
                icon: Icon(Icons.check, color: Colors.white),
                onPressed: () async {
                  await setValue(baseURL, mAppUrl);
                  logout(context, isDemo: true);
                })
          ]),
      body: SingleChildScrollView(
        child: Wrap(
          runSpacing: 12,
          spacing: 12,
          children: List.generate(mServerList.length, (i) {
            return itemWidget(
                code: i,
                title: mServerList[i].title,
                img: mServerList[i].img!,
                onTap: () async {
                  setValue(DETAIL_PAGE_VARIANT, i);
                  dashboardStore.setDashboardType(mServerList[i].type!);
                  i = i;
                  mAppUrl = mServerList[i].url!;
                  setState(() {});
                });
          }),
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
