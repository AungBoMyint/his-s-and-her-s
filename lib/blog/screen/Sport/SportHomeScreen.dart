import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import '../../language/language.dart';
import '../../model/DefaultResponse.dart';
import '../../screen/StoryViewScreen.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../component/AppWidget.dart';
import '../../component/NoDataWidget.dart';
import '../../component/Sport/SportBlogItemWidget.dart';
import '../../component/Sport/SportFeatureComponent.dart';
import '../../component/Sport/SportQuickReadWidget.dart';
import '../../component/Sport/SportStoryComponent.dart';
import '../../component/Sport/SportSuggestForYouComponent.dart';

import '../../model/DefaultPostResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../../utils/Extensions/text_styles.dart';
import '../StoryViewScreen.dart';
import '../SubCategoryScreen.dart';
import '../ViewAllScreen.dart';

class SportHomeScreen extends StatefulWidget {
  static String tag = '/LifeStyleHomeScreen';

  @override
  SportHomeScreenState createState() => SportHomeScreenState();
}

class SportHomeScreenState extends State<SportHomeScreen>
    with SingleTickerProviderStateMixin {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  PageController pageController = PageController();

  List<DefaultPostResponse> blogList = [];
  List<Widget> tabs = [];
  int? selectIndex = 0;

  int? currentIndex = 0;
  TabController? tabController;
  Future<DefaultResponse>? mGetData;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    tabController = TabController(
        length: getStringListAsync(chooseTopicList)!.length, vsync: this);
    mGetData = getDefaultDashboard();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mHeading(String? title, String? viewAll, {String? data}) {
    return Row(
      children: [
        Image.asset(ic_sports,
            height: 20,
            width: 20,
            color: appStore.isDarkMode ? Colors.white : primaryColor),
        6.width,
        Text(title.validate(),
                style: GoogleFonts.poppins(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    fontSize: 24))
            .expand(),
        IconButton(
          onPressed: () {
            ViewAllScreen(
                    name: viewAll,
                    catData: data,
                    text: data.validate().isNotEmpty ? "Suggest For you" : "")
                .launch(context);
          },
          icon: Icon(Icons.arrow_forward, size: 18, color: context.iconColor),
        ).visible(data == null)
      ],
    ).paddingOnly(left: 16);
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
            tabs.clear();

            for (int i = 0; i < snap.data!.category!.length; i++) {
              tabs.add(
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: BoxDecoration(
                      borderRadius: radius(0), // Creates border
                      color: primaryColor.withOpacity(0.2)),
                  child: Text(
                    parseHtmlString(
                        snap.data!.category![i].catName.toString().validate()),
                    style: primaryTextStyle(
                        color: currentIndex == i ? Colors.white : Colors.white),
                  ),
                ),
              );
            }
            blogList.clear();
            for (int i = 0; i <= snap.data!.category!.length; i++) {
              if (currentIndex == i) {
                blogList.addAll(snap.data!.category![i].blog!);
              }
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      16.height,
                      HorizontalList(
                          itemCount: snap.data!.storyPost!.length,
                          padding: EdgeInsets.only(left: 16),
                          itemBuilder: (_, index) {
                            return SportStoryComponent(
                              snap.data!.storyPost![index],
                              onCall: () {
                                StoryViewScreen(list: snap.data!.storyPost!)
                                    .launch(context);
                              },
                            );
                          }),
                      Divider(height: 30),
                    ],
                  ).visible(snap.data!.storyPost != null &&
                      snap.data!.storyPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading(LanguageEn.lblFeaturedBlog, "feature"),
                      SizedBox(
                        height: context.height() * 0.3,
                        child: PageView.builder(
                          itemCount: snap.data!.featurePost!.length,
                          controller: pageController,
                          itemBuilder: (context, i) {
                            return SportFeatureComponent(
                              snap.data!.featurePost![i],
                              onCall: () {
                                pageController.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.linearToEaseOut);
                              },
                            );
                          },
                          onPageChanged: (int i) {
                            selectIndex = i;
                            setState(() {});
                          },
                        ),
                      ),
                      dotIndicator(snap.data!.featurePost!, selectIndex,
                              isPersonal: true)
                          .paddingTop(8),
                    ],
                  ).visible(snap.data!.featurePost!.isNotEmpty &&
                      snap.data!.featurePost != null),
                  SportQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading(LanguageEn.lblRecentBlog, "recent"),
                      HorizontalList(
                          itemCount: snap.data!.recentPost!.length,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          itemBuilder: (_, index) {
                            return SportBlogItemWidget(
                                snap.data!.recentPost![index]);
                          }),
                    ],
                  ).visible(snap.data!.recentPost!.isNotEmpty &&
                      snap.data!.recentPost != null),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mHeading(LanguageEn.lblSuggestForYou, 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      16.height,
                      TabBar(
                        controller: tabController,
                        isScrollable: true,
                        labelPadding: EdgeInsets.all(0),
                        tabs: tabs,
                        labelColor: Colors.white,
                        indicator: BoxDecoration(
                            borderRadius: radius(0), // Creates border
                            color: primaryColor),
                        onTap: (c) {
                          currentIndex = c;
                          blogList.clear();
                          for (int i = 0;
                              i <= snap.data!.category!.length;
                              i++) {
                            if (currentIndex == i) {
                              blogList.addAll(snap.data!.category![i].blog!);
                            }
                          }
                          setState(() {});
                        },
                      ).paddingOnly(left: 8),
                      IndexedStack(
                          index: currentIndex,
                          children: List.generate(
                            tabs.length,
                            (index) {
                              return blogList.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          runSpacing: 8,
                                          spacing: 8,
                                          children: List.generate(
                                            blogList.length,
                                            (index) {
                                              return SportSuggestForYouComponent(
                                                  snap.data!
                                                      .featurePost![index]);
                                            },
                                          ),
                                        ).paddingSymmetric(
                                            horizontal: 16, vertical: 16),
                                        RoundedLoadingButton(
                                          successIcon: Icons.done,
                                          failedIcon: Icons.close,
                                          borderRadius: defaultRadius,
                                          child: Text(LanguageEn.btnMore,
                                              style: boldTextStyle(
                                                  color: Colors.white)),
                                          controller: btnController,
                                          animateOnTap: false,
                                          resetAfterDuration: true,
                                          width: context.width(),
                                          color: primaryColor,
                                          onPressed: () {
                                            SubCategoryScreen(
                                              catId: snap
                                                  .data!
                                                  .category![
                                                      currentIndex.validate()]
                                                  .catID,
                                              isDashboard: true,
                                              catName: snap
                                                  .data!
                                                  .category![
                                                      currentIndex.validate()]
                                                  .catName,
                                            ).launch(context);
                                          },
                                        )
                                            .paddingSymmetric(horizontal: 16)
                                            .visible(blogList.length >= 8),
                                        16.height,
                                      ],
                                    ).paddingTop(8)
                                  : SizedBox(
                                      height: 150,
                                      child: NoDataWidget(
                                              LanguageEn.lblNoBlogAvailable)
                                          .paddingTop(20));
                            },
                          ).toList())
                    ],
                  ),
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
