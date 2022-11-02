import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/DefaultResponse.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../component/AppWidget.dart';
import '../../component/Music/MusicBlogItemWidget.dart';
import '../../component/Music/MusicFeatureComponent.dart';
import '../../component/Music/MusicQuickReadWidget.dart';
import '../../component/Music/MusicStoryComponent.dart';
import '../../component/Music/MusicSuggestForYouComponent.dart';
import '../../component/NoDataWidget.dart';
import 'package:kzn/main.dart';
import '../../model/DefaultPostResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../StoryViewScreen.dart';
import '../SubCategoryScreen.dart';
import '../ViewAllScreen.dart';

class MusicHomeScreen extends StatefulWidget {
  static String tag = '/MusicHomeScreen';

  @override
  MusicHomeScreenState createState() => MusicHomeScreenState();
}

class MusicHomeScreenState extends State<MusicHomeScreen>
    with SingleTickerProviderStateMixin {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  List<DefaultPostResponse> blogList = [];
  List<Widget> tabs = [];
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(ic_musicHeading1, width: context.width() / 4),
        Column(
          children: [
            Text(title.validate().capitalizeFirstLetter(),
                style: GoogleFonts.poppins(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                textAlign: TextAlign.center),
            Text("Explore",
                    style: GoogleFonts.poppins(color: textSecondaryColorGlobal))
                .onTap(() {
              ViewAllScreen(name: viewAll).launch(context);
            }),
          ],
        ).paddingOnly(bottom: 8).expand(),
        Image.asset(ic_musicHeading2, width: context.width() / 4),
      ],
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
            tabs.clear();
            for (int i = 0; i < snap.data!.category!.length; i++) {
              tabs.add(
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        parseHtmlString(snap.data!.category![i].catName
                            .toString()
                            .validate()),
                        style: primaryTextStyle(),
                      ),
                    ),
                    Container(
                      height: 7,
                      width: 7,
                      decoration: boxDecorationWithShadowWidget(
                          boxShape: BoxShape.circle,
                          backgroundColor: currentIndex != i
                              ? context.scaffoldBackgroundColor
                              : context.iconColor),
                    )
                  ],
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
                  if (snap.data!.storyPost != null &&
                      snap.data!.storyPost!.isNotEmpty)
                    Column(
                      children: [
                        16.height,
                        HorizontalList(
                            itemCount: snap.data!.storyPost!.length,
                            padding:
                                EdgeInsets.only(left: 16, right: 16, bottom: 8),
                            itemBuilder: (_, index) {
                              return MusicStoryComponent(
                                snap.data!.storyPost![index],
                                onCall: () {
                                  StoryViewScreen(list: snap.data!.storyPost!)
                                      .launch(context);
                                },
                              );
                            }),
                      ],
                    ),
                  Column(
                    children: [
                      16.height,
                      mHeading("Featured Blog", "feature"),
                      8.height,
                      CarouselSlider.builder(
                        itemCount: snap.data!.featurePost!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            MusicFeatureComponent(
                                snap.data!.featurePost![itemIndex],
                                isSlider: true),
                        options: CarouselOptions(
                          autoPlay: false,
                          reverse: false,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          initialPage: 1,
                          height: 300.0,
                          viewportFraction: 0.6,
                          aspectRatio: 1.2,
                        ),
                      )
                    ],
                  ).visible(snap.data!.featurePost!.isNotEmpty &&
                      snap.data!.featurePost != null),
                  16.height,
                  MusicQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading("Recent Blog", "recent"),
                      HorizontalList(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: snap.data!.recentPost!.length,
                          itemBuilder: (_, index) {
                            return MusicBlogItemWidget(
                                snap.data!.recentPost![index]);
                          }),
                    ],
                  ).visible(snap.data!.recentPost!.isNotEmpty &&
                      snap.data!.recentPost != null),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      30.height,
                      mHeading("Suggest For You", 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      8.height,
                      TabBar(
                        controller: tabController,
                        isScrollable: true,
                        padding: EdgeInsets.only(left: 16),
                        labelPadding: EdgeInsets.all(0),
                        indicator: BoxDecoration(),
                        indicatorColor: context.scaffoldBackgroundColor,
                        tabs: tabs,
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
                      ),
                      IndexedStack(
                          index: currentIndex,
                          children: List.generate(tabs.length, (index) {
                            return blogList.isNotEmpty
                                ? Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: blogList.length,
                                        padding: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 16,
                                            bottom: 8),
                                        itemBuilder: (_, index) {
                                          return MusicSuggestForYouComponent(
                                            blogList[index],
                                          );
                                        },
                                      ),
                                      RoundedLoadingButton(
                                        successIcon: Icons.done,
                                        failedIcon: Icons.close,
                                        borderRadius: defaultRadius,
                                        child: Text("More",
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
                                      ).paddingSymmetric(horizontal: 16),
                                      16.height,
                                    ],
                                  )
                                : SizedBox(
                                    height: 150,
                                    child: NoDataWidget("No Blog Available")
                                        .paddingTop(20));
                          }).toList())
                    ],
                  ).visible(snap.data!.recentPost!.isNotEmpty &&
                      snap.data!.recentPost != null),
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
