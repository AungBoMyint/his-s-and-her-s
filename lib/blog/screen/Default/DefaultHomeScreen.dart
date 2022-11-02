import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../component/Default/DefaultBlogItemWidget.dart';
import '../../component/Default/DefaultFeaturedComponent.dart';
import '../../model/DefaultPostResponse.dart';
import '../../model/DefaultResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../component/AppWidget.dart';
import '../../component/Default/DefaultQuickReadWidget.dart';
import '../../component/NoDataWidget.dart';
import '../StoryViewScreen.dart';
import '../SubCategoryScreen.dart';
import '../ViewAllScreen.dart';
import '../../component/Default/DefaultStoryComponent.dart';

class DefaultHomeScreen extends StatefulWidget {
  @override
  _DefaultHomeScreenState createState() => _DefaultHomeScreenState();
}

class _DefaultHomeScreenState extends State<DefaultHomeScreen>
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

  void init() async {
    tabController = TabController(
        length: getStringListAsync(chooseTopicList)!.length + 1, vsync: this);
    mGetData = getDefaultDashboard();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mHeading(String? title, String? viewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!, style: boldTextStyle(size: 20)),
        TextButton(
          child: Row(
            children: [
              Text("More", style: secondaryTextStyle(size: 16)),
              Icon(Icons.keyboard_arrow_right,
                  size: 18, color: textSecondaryColorGlobal),
            ],
          ),
          onPressed: () {
            ViewAllScreen(name: viewAll).launch(context);
          },
        ),
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
          log(getStringAsync(BOOKMARK_LIST));

          if (snap.hasData) {
            tabs.clear();
            tabs.add(Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                  borderRadius: radius(defaultRadius), // Creates border
                  color: primaryColor.withOpacity(0.1)),
              child: Text(parseHtmlString("Recent"),
                  style: primaryTextStyle(
                      color: currentIndex == 0
                          ? Colors.white
                          : textPrimaryColorGlobal)),
            ));
            for (int i = 0; i < snap.data!.category!.length; i++) {
              tabs.add(
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                      borderRadius: radius(defaultRadius), // Creates border
                      color: primaryColor.withOpacity(0.1)),
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text(
                    parseHtmlString(
                        snap.data!.category![i].catName.toString().validate()),
                    style: primaryTextStyle(
                        color: currentIndex == i + 1
                            ? Colors.white
                            : textPrimaryColorGlobal),
                  ),
                ),
              );
            }
            if (currentIndex == 0) {
              blogList.clear();
              blogList.addAll(snap.data!.recentPost!);
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      HorizontalList(
                          itemCount: snap.data!.storyPost!.length,
                          padding: EdgeInsets.only(left: 16),
                          itemBuilder: (_, index) {
                            return DefaultStoryComponent(
                              snap.data!.storyPost![index],
                              onCall: () {
                                StoryViewScreen(list: snap.data!.storyPost!)
                                    .launch(context);
                              },
                            );
                          }),
                      8.height,
                    ],
                  ).visible(snap.data!.storyPost!.isNotEmpty &&
                      snap.data!.storyPost != null),
                  Column(
                    children: [
                      mHeading("Featured Blog", "feature"),
                      HorizontalList(
                          itemCount: snap.data!.featurePost!.length,
                          padding: EdgeInsets.only(left: 16, right: 8),
                          itemBuilder: (_, index) {
                            return DefaultFeaturedComponent(
                                snap.data!.featurePost![index]);
                          }),
                    ],
                  ).visible(snap.data!.featurePost!.isNotEmpty &&
                      snap.data!.featurePost != null),
                  // Quick Read
                  DefaultQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  TabBar(
                    controller: tabController,
                    isScrollable: true,
                    padding: EdgeInsets.only(left: 16, top: 8),
                    labelPadding: EdgeInsets.all(0),
                    indicator: BoxDecoration(
                        borderRadius: radius(defaultRadius), // Creates border
                        color: primaryColor),
                    tabs: tabs,
                    onTap: (c) {
                      currentIndex = c;
                      if (currentIndex == 0) {
                        blogList.clear();
                        blogList.addAll(snap.data!.recentPost!);
                      } else {
                        blogList.clear();
                        for (int i = 0; i <= snap.data!.category!.length; i++) {
                          if (currentIndex == i) {
                            blogList.addAll(snap.data!.category![i - 1].blog!);
                          }
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
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                        position: index,
                                        columnCount: 1,
                                        child: SlideAnimation(
                                          horizontalOffset: 50.0,
                                          verticalOffset: 20.0,
                                          child: FadeInAnimation(
                                            child: DefaultBlogItemWidget(
                                                blogList[index]),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  RoundedLoadingButton(
                                    successIcon: Icons.done,
                                    failedIcon: Icons.close,
                                    borderRadius: defaultRadius,
                                    child: Text("More",
                                        style:
                                            boldTextStyle(color: Colors.white)),
                                    controller: btnController,
                                    animateOnTap: false,
                                    resetAfterDuration: true,
                                    width: context.width(),
                                    color: primaryColor,
                                    onPressed: () {
                                      if (currentIndex == 0) {
                                        ViewAllScreen(name: 'recent')
                                            .launch(context);
                                      } else {
                                        log(snap
                                            .data!
                                            .category![
                                                currentIndex.validate() - 1]
                                            .catID!
                                            .toString());
                                        SubCategoryScreen(
                                          catId: snap
                                              .data!
                                              .category![
                                                  currentIndex.validate() - 1]
                                              .catID,
                                          isDashboard: true,
                                          catName: snap
                                              .data!
                                              .category![
                                                  currentIndex.validate() - 1]
                                              .catName,
                                        ).launch(context);
                                      }
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
