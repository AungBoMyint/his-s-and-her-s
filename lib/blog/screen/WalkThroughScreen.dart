import 'package:flutter/material.dart';
import '../language/language.dart';
import '../model/WalkThroughModel.dart';
import '../utils/AppColor.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/AppImages.dart';
import 'ChooseTopicsScreen.dart';

class WalkThroughScreen extends StatefulWidget {
  static String tag = '/WalkThroughScreen';

  @override
  WalkThroughScreenState createState() => WalkThroughScreenState();
}

class WalkThroughScreenState extends State<WalkThroughScreen> {
  int? currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  List<WalkThroughModel> walkThroughClass = [
    WalkThroughModel(
      text:
          "❝  His’s & Her’s Learning မှ Fashion ကို စိတ်၀င်စားသူတွေအတွက် ကိုယ့်အားကိုယ်ကိုးပြီး အသက်မွေးဝမ်းကြောင်း ပညာရပ်တစ်ခုဖြင့် ဘဝကိုတိုးတက်အောင်မြင်အောင် ဆောင်ရွက်ပေးရန် ရည်ရွယ်ပါသည်  ❞",
      name:
          "⭐ HIS'S AND HER'S ENABLES WOMEN TO DEVELOP THEIR FASHION CAREERS ⭐",
      img: ic_walk1,
    ),
    WalkThroughModel(
      text:
          "❝  ယနေ့ သင်ယူလေ့လာနေခြင်း သည် သင့်၏အနာဂတ်ကို ပုံဖော်နေခြင်းသာ ဖြစ်ပါတယ်  ❞",
      name: "⭐ THE  FUTURE  DEPENDS  ON WHAT  YOU  DO  TODAY ⭐",
      img: ic_walk2,
    ),
    WalkThroughModel(
      text:
          "❝  မနက်ဖြန်မှာ Fashion နဲ့ပတ်သက်သော လုပ်ငန်းရှင်ကြီး လုပ်ဖို့ ယနေ့ သင်ယူလေ့လာလိုက်ပါ  ❞",
      name: "⭐  LEARN TODAY   ➡   LEAD TOMORROW   ➡  BE THE BEST  ⭐",
      img: ic_walk3,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    ChooseTopicsScreen().launch(context);
                  },
                  child: Text(LanguageEn.lblSkip, style: boldTextStyle()),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    walkThroughClass[currentIndex!.toInt()].name.toString(),
                    style: boldTextStyle(
                        size: 14, letterSpacing: 1, wordSpacing: 1),
                  ),
                  16.height,
                  Text(walkThroughClass[currentIndex!.toInt()].text.toString(),
                      style: secondaryTextStyle(size: 14, color: Colors.black)),
                ],
              ).paddingOnly(left: 16, right: 16, top: 30),
              SizedBox(
                height: context.height() / 2 + 40,
                child: PageView.builder(
                  itemCount: walkThroughClass.length,
                  controller: pageController,
                  itemBuilder: (context, i) {
                    return Image.asset(walkThroughClass[i].img.toString(),
                            fit: BoxFit.contain)
                        .paddingOnly(left: 16, right: 16);
                  },
                  onPageChanged: (int i) {
                    currentIndex = i;
                    setState(() {});
                  },
                ),
              ),
            ],
          ).paddingTop(context.statusBarHeight + 4),
          Positioned(
            bottom: 50,
            right: 16,
            left: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dotIndicator(walkThroughClass, currentIndex, isPersonal: false)
                    .paddingTop(8),
                GestureDetector(
                  onTap: () {
                    if (currentIndex!.toInt() >= 2) {
                      ChooseTopicsScreen().launch(context);
                    } else {
                      pageController.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.linearToEaseOut);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: boxDecorationWithRoundedCornersWidget(
                        borderRadius: radius(defaultRadius),
                        backgroundColor: primaryColor),
                    child: Text(
                        currentIndex!.toInt() >= 2
                            ? "Get Started"
                            : LanguageEn.btnNext,
                        style: primaryTextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
