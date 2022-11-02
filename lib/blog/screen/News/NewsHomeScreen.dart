import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../component/Default/DefaultCustomCategorySliderComponent.dart';
import '../../component/News/NewsCustomCategoryComponent.dart';
import '../../model/CategoryResponse.dart';
import '../../model/DefaultResponse.dart';
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
import '../../component/News/NewsBlogItemWidget.dart';
import '../../component/News/NewsFeatureComponent.dart';
import '../../component/News/NewsQuickReadWidget.dart';
import '../../component/News/NewsStoryComponent.dart';
import '../../component/News/NewsSuggestForYouComponent.dart';
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

class NewsHomeScreen extends StatefulWidget {
  static String tag = '/NewsHomeScreen';

  @override
  NewsHomeScreenState createState() => NewsHomeScreenState();
}

class NewsHomeScreenState extends State<NewsHomeScreen>
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
        Text(title.validate(),
            style: GoogleFonts.libreBaskerville(
                color: textPrimaryColorGlobal,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        Text(viewAll ?? "",
                style: GoogleFonts.libreBaskerville(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    fontSize: 14))
            .onTap(() {
          ViewAllScreen(name: viewAll).launch(context);
        }).visible(data.validate().isEmpty)
      ],
    ).paddingSymmetric(horizontal: 16, vertical: 8);
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width() * 0.37;
    double height = 190;
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
                  child: Text(
                    parseHtmlString(
                        snap.data!.category![i].catName.toString().validate()),
                    style: primaryTextStyle(),
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
                  mHeading("Categories", ""),
                  FutureBuilder<List<CategoryResponse>>(
                      future: getCategory(0),
                      builder: (context, snap2) {
                        if (snap2.hasData) {
                          return HorizontalList(
                              itemCount: snap2.data!.length,
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 8),
                              itemBuilder: (_, index1) {
                                log("Image: ${snap2.data![index1].image}");
                                return DefaultCustomCategorySliderComponent(
                                  snap2.data![index1],
                                );
                              });
                        }
                        return HorizontalList(
                            itemCount: 3,
                            padding:
                                EdgeInsets.only(left: 16, right: 16, bottom: 8),
                            itemBuilder: (_, index1) {
                              return Image.asset(ic_placeHolder,
                                      height: height,
                                      width: width,
                                      fit: BoxFit.fill)
                                  .cornerRadiusWithClipRRect(16);
                            });
                      }),
                  Column(
                    children: [
                      16.height,
                      HorizontalList(
                          itemCount: snap.data!.storyPost!.length,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          itemBuilder: (_, index) {
                            return NewsStoryComponent(
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
                  16.height,
                  Column(
                    children: [
                      mHeading("Featured Blog", "See All"),
                      HorizontalList(
                          itemCount: snap.data!.featurePost!.length,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemBuilder: (_, index) {
                            return NewsFeaturedComponent(
                                snap.data!.featurePost![index],
                                isSlider: true);
                          }),
                    ],
                  ).visible(snap.data!.featurePost!.isNotEmpty &&
                      snap.data!.featurePost != null),
                  NewsQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading("Recent Blog", "See All"),
                      HorizontalList(
                          itemCount: snap.data!.recentPost!.length,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemBuilder: (_, index) {
                            return NewsBlogItemWidget(
                                snap.data!.recentPost![index]);
                          }).visible(snap
                              .data!.recentPost!.isNotEmpty &&
                          snap.data!.recentPost != null),
                    ],
                  ).visible(snap.data!.recentPost!.isNotEmpty &&
                      snap.data!.recentPost != null),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      mHeading("Suggest For You", 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      8.height,
                      TabBar(
                        controller: tabController,
                        isScrollable: true,
                        padding: EdgeInsets.only(left: 16),
                        labelPadding: EdgeInsets.all(0),
                        indicatorColor: primaryColor,
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
                                        padding: EdgeInsets.all(16),
                                        itemBuilder: (_, index) {
                                          return NewsSuggestForYouComponent(
                                              blogList[index]);
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
                                      )
                                          .paddingSymmetric(horizontal: 16)
                                          .visible(blogList.length >= 8),
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
