import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../../component/Finance/FinanceBlogItemWidget.dart';
import '../../component/Finance/FinanceFeatureComponent.dart';
import '../../component/Finance/FinanceQuickReadWidget.dart';
import '../../component/Finance/FinanceStoryComponent.dart';
import '../../component/Finance/FinanceSuggestForYouComponent.dart';
import '../../component/NoDataWidget.dart';
import 'package:kzn/main.dart';
import '../../model/DefaultPostResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../../utils/Extensions/text_styles.dart';
import '../StoryViewScreen.dart';
import '../SubCategoryScreen.dart';
import '../ViewAllScreen.dart';

class FinanceHomeScreen extends StatefulWidget {
  static String tag = '/LifeStyleHomeScreen';

  @override
  FinanceHomeScreenState createState() => FinanceHomeScreenState();
}

class FinanceHomeScreenState extends State<FinanceHomeScreen>
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
    return Column(
      children: [
        Text(title.validate().capitalizeFirstLetter(),
            style: GoogleFonts.bebasNeue(
                color: textPrimaryColorGlobal,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("More",
                style: GoogleFonts.bebasNeue(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    fontSize: 14)),
            Icon(Icons.keyboard_arrow_right,
                size: 18, color: context.iconColor),
          ],
        ).onTap(() {
          ViewAllScreen(
                  name: viewAll,
                  catData: data,
                  text: data.validate().isNotEmpty ? "Suggest For you" : "")
              .launch(context);
        }).visible(data == null)
      ],
    ).paddingOnly(left: 8, bottom: 8);
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
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Text(
                    parseHtmlString(
                        snap.data!.category![i].catName.toString().validate()),
                    style: primaryTextStyle(
                        color: currentIndex == i
                            ? textPrimaryColorGlobal
                            : textPrimaryColorGlobal),
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
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 8),
                          itemBuilder: (_, index) {
                            return FinanceStoryComponent(
                              snap.data!.storyPost![index],
                              onCall: () {
                                StoryViewScreen(list: snap.data!.storyPost!)
                                    .launch(context);
                              },
                            );
                          }).expand(),
                    ],
                  ).visible(snap.data!.storyPost != null &&
                      snap.data!.storyPost!.isNotEmpty),
                  16.height,
                  Column(
                    children: [
                      mHeading("Featured Blog", "feature"),
                      HorizontalList(
                          itemCount: snap.data!.featurePost!.length,
                          padding: EdgeInsets.only(left: 16, right: 8),
                          itemBuilder: (_, index) {
                            return FinanceFeatureComponent(
                                snap.data!.featurePost![index],
                                isSlider: true);
                          }),
                    ],
                  ).visible(snap.data!.featurePost!.isNotEmpty &&
                      snap.data!.featurePost != null),
                  FinanceQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  if (snap.data!.recentPost != null &&
                      snap.data!.recentPost!.isNotEmpty)
                    Column(
                      children: [
                        8.height,
                        mHeading("Recent Blog", "recent"),
                        CarouselSlider.builder(
                          itemCount: snap.data!.featurePost!.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              FinanceBlogItemWidget(
                                  snap.data!.recentPost![itemIndex]),
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
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      25.height,
                      mHeading("Suggest For You", 'by_category',
                              data: getStringListAsync(chooseTopicList)
                                  .toString())
                          .center(),
                      16.height,
                      TabBar(
                        controller: tabController,
                        isScrollable: true,
                        labelPadding: EdgeInsets.all(0),
                        tabs: tabs,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)), // Creates border
                            color: primaryColor.withOpacity(0.1)),
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
                      ).paddingLeft(16),
                      IndexedStack(
                          index: currentIndex,
                          children: List.generate(
                            tabs.length,
                            (index) {
                              return blogList.isNotEmpty
                                  ? Column(
                                      children: [
                                        Container(
                                          width: context.width(),
                                          color: primaryColor.withOpacity(0.1),
                                          child: HorizontalList(
                                            itemCount: blogList.length,
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 16,
                                                bottom: 8),
                                            itemBuilder: (_, index) {
                                              return FinanceSuggestForYouComponent(
                                                  blogList[index]);
                                            },
                                          ),
                                        ),
                                        8.height,
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
                                        )
                                            .paddingSymmetric(horizontal: 16)
                                            .visible(blogList.length >= 8),
                                        16.height,
                                      ],
                                    )
                                  : SizedBox(
                                      height: 150,
                                      child: Container(
                                        width: context.width(),
                                        color: Colors.black26,
                                        child:
                                            NoDataWidget("No Blog Available"),
                                      ),
                                    );
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
