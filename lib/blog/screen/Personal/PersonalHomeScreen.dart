import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kzn/blog/language/language.dart';
import '../../component/Personal/PersonalQuickReadWidget.dart';
import '../../model/DefaultResponse.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../component/AppWidget.dart';
import '../../component/Personal/PersonalBlogItemWidget.dart';
import '../../component/Personal/PersonalFeatureComponent.dart';
import '../../component/Personal/PersonalStoryComponent.dart';
import '../../component/Personal/PersonalSuggestForYouComponent.dart';

import '../../model/DefaultPostResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../StoryViewScreen.dart';
import '../ViewAllScreen.dart';

class PersonalHomeScreen extends StatefulWidget {
  static String tag = '/PersonalHomeScreen';

  @override
  PersonalHomeScreenState createState() => PersonalHomeScreenState();
}

class PersonalHomeScreenState extends State<PersonalHomeScreen>
    with SingleTickerProviderStateMixin {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  List<DefaultPostResponse> blogList = [];
  Future<DefaultResponse>? mGetData;
  int? currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    mGetData = getDefaultDashboard();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mHeading(String? title, String? viewAll, {String? data}) {
    return Container(
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GradientText(
            title.validate().toUpperCase(),
            style: GoogleFonts.unna(
                color: textPrimaryColorGlobal, letterSpacing: 2, fontSize: 50),
            gradient: LinearGradient(
              colors: [
                Colors.black12.withOpacity(.07),
                Colors.black26.withOpacity(.05),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title.validate().toUpperCase(),
                  style: GoogleFonts.unna(
                      color: textPrimaryColorGlobal,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontSize: 26)),
              Text("More",
                      style: GoogleFonts.unna(
                          color: textSecondaryColorGlobal,
                          fontWeight: FontWeight.normal,
                          fontSize: 18))
                  .onTap(() {
                ViewAllScreen(
                        name: viewAll,
                        catData: data,
                        text:
                            data.validate().isNotEmpty ? "Suggest For you" : "")
                    .launch(context);
              })
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        await Future.delayed(Duration(seconds: 2));
      },
      child: FutureBuilder<DefaultResponse>(
        future: mGetData!,
        builder: (context, snap) {
          if (snap.hasData) {
            blogList.clear();
            snap.data!.category!.forEach((element) {
              Iterable it = element.blog!;
              it.map((e) => blogList.add(e)).toList();
            });
            log(blogList.toString());
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      HorizontalList(
                          itemCount: snap.data!.storyPost!.length,
                          padding: EdgeInsets.only(left: 16),
                          itemBuilder: (_, index) {
                            return PersonalStoryComponent(
                              snap.data!.storyPost![index],
                              onCall: () {
                                StoryViewScreen(list: snap.data!.storyPost!)
                                    .launch(context);
                              },
                            );
                          }),
                    ],
                  ).visible(snap.data!.storyPost != null &&
                      snap.data!.storyPost!.isNotEmpty),
                  Column(
                    children: [
                      16.height,
                      mHeading(LanguageEn.lblSuggestForYou, 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(ic_personal_bg,
                              width: context.width(),
                              height: context.height() * 0.38,
                              fit: BoxFit.fitWidth),
                          SizedBox(
                            height: context.height() * 0.44,
                            child: PageView.builder(
                              itemCount: blogList.length,
                              controller: pageController,
                              itemBuilder: (context, i) {
                                return PersonalSuggestForYouComponent(
                                    blogList[i]);
                              },
                              onPageChanged: (int i) {
                                currentIndex = i;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      dotIndicator(blogList, currentIndex, isPersonal: true)
                          .paddingTop(0),
                    ],
                  ).visible(snap.data!.category != null &&
                      snap.data!.category!.isNotEmpty),
                  PersonalQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading(LanguageEn.lblRecentBlog, "recent"),
                      HorizontalList(
                              itemCount: snap.data!.recentPost!.length,
                              padding: EdgeInsets.all(16),
                              itemBuilder: (_, index) {
                                return PersonalBlogItemWidget(
                                    snap.data!.recentPost![index]);
                              })
                          .visible(snap.data!.recentPost!.isNotEmpty &&
                              snap.data!.recentPost != null),
                    ],
                  ).visible(snap.data!.recentPost != null &&
                      snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      16.height,
                      mHeading(LanguageEn.lblFeaturedBlog, "feature"),
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snap.data!.featurePost!.length,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          itemBuilder: (_, index) {
                            if (index % 2 == 0)
                              return PersonalFeatureComponent(
                                  snap.data!.featurePost![index],
                                  isSlider: false,
                                  isEven: true);
                            else
                              return PersonalFeatureComponent(
                                  snap.data!.featurePost![index],
                                  isSlider: false,
                                  isEven: false);
                          }),
                    ],
                  ).visible(snap.data!.featurePost != null &&
                      snap.data!.featurePost!.isNotEmpty),
                  16.height,
                ],
              ),
            );
          }
          if (snap.hasError) {
            apiErrorComponent(snap.error, context);
          }
          return snapWidgetHelper(snap, loadingWidget: Loader().center());
        },
      ),
    );
  }
}
