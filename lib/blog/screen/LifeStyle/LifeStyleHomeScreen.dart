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
import '../../component/LifeStyle/LifeStyleBlogItemWidget.dart';
import '../../component/LifeStyle/LifeStyleFeatureComponent.dart';
import '../../component/LifeStyle/LifeStyleQuickReadWidget.dart';
import '../../component/LifeStyle/LifeStyleStoryComponent.dart';
import '../../component/LifeStyle/LifeStyleSuggestForYouComponent.dart';
import 'package:kzn/main.dart';
import '../../model/DefaultPostResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../StoryViewScreen.dart';
import '../ViewAllScreen.dart';

class LifeStyleHomeScreen extends StatefulWidget {
  static String tag = '/LifeStyleHomeScreen';

  @override
  LifeStyleHomeScreenState createState() => LifeStyleHomeScreenState();
}

class LifeStyleHomeScreenState extends State<LifeStyleHomeScreen>
    with SingleTickerProviderStateMixin {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  List<DefaultPostResponse> blogList = [];
  List<Widget> tabs = [];
  int? currentIndex = 0;
  PageController pageController = PageController();
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
            style: GoogleFonts.poppins(
                color: textPrimaryColorGlobal,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        IconButton(
          onPressed: () {
            ViewAllScreen(
              name: viewAll,
              catData: data,
              text: data.validate().isNotEmpty ? "Suggest For you" : "",
            ).launch(context);
          },
          icon: Icon(Icons.keyboard_arrow_right, size: 18),
        )
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
            blogList.clear();
            snap.data!.category!.forEach((element) {
              Iterable it = element.blog!;
              it.map((e) => blogList.add(e)).toList();
            });
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
                            return LifeStyleStoryComponent(
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
                  16.height.visible(snap.data!.storyPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading("Suggest For You", 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.asset(ic_lifeStyleBg,
                              height: context.height() * 0.30,
                              width: context.width(),
                              fit: BoxFit.cover),
                          SizedBox(
                            height: context.height() * 0.4,
                            child: PageView.builder(
                              itemCount: blogList.length,
                              controller: pageController,
                              itemBuilder: (context, i) {
                                return LifeStyleSuggestForYouComponent(
                                        blogList[i])
                                    .paddingSymmetric(horizontal: 30);
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
                          .paddingTop(8),
                    ],
                  ).visible(snap.data!.category!.isNotEmpty &&
                      snap.data!.category != null),
                  LifeStyleQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      16.height,
                      mHeading("Featured Blog", "feature"),
                      HorizontalList(
                          itemCount: snap.data!.featurePost!.length,
                          padding:
                              EdgeInsets.only(left: 16, right: 8, bottom: 8),
                          itemBuilder: (_, index) {
                            return LifeStyleFeatureComponent(
                                snap.data!.featurePost![index],
                                isSlider: true);
                          }),
                    ],
                  ).visible(snap.data!.featurePost!.isNotEmpty &&
                      snap.data!.featurePost != null),
                  Column(
                    children: [
                      mHeading("Recent Blog", "recent"),
                      HorizontalList(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: snap.data!.recentPost!.length,
                          itemBuilder: (_, index) {
                            return LifeStyleBlogItemWidget(
                                snap.data!.recentPost![index]);
                          }),
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
