import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../component/Fashion/FashionFeatureComponent.dart';
import '../../component/Fashion/FashionRecentComponent.dart';
import '../../component/Fashion/FashionSuggestForYouComponent.dart';
import '../../model/DefaultPostResponse.dart';
import '../../model/DefaultResponse.dart';
import '../../network/RestApi.dart';
import '../../screen/StoryViewScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Fashion/FashionQuickReadWidget.dart';
import '../../component/Fashion/FashionStoryComponent.dart';
import 'package:kzn/main.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../ViewAllScreen.dart';

class FashionHomeScreen extends StatefulWidget {
  static String tag = '/FashionHomeScreen';

  @override
  FashionHomeScreenState createState() => FashionHomeScreenState();
}

class FashionHomeScreenState extends State<FashionHomeScreen> {
  List<DefaultPostResponse> blogList = [];
  int? currentIndex = 0;
  Future<DefaultResponse>? mGetData;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ic_fashionHeading1,
            width: context.width() / 4,
            color: appStore.isDarkMode ? Colors.white : primaryColor),
        Column(
          children: [
            Text(title.validate().capitalizeFirstLetter(),
                style: GoogleFonts.redressed(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            Text("+ " + "Explore",
                    style: GoogleFonts.redressed(
                        fontSize: 16, color: textPrimaryColorGlobal))
                .onTap(() {
              ViewAllScreen(
                      name: viewAll,
                      catData: data,
                      text: data.validate().isNotEmpty ? "Suggest For you" : "")
                  .launch(context);
            }),
          ],
        ).paddingOnly(left: 16, right: 16, bottom: 8, top: 8),
        Image.asset(ic_fashionHeading2,
            width: context.width() / 4,
            color: appStore.isDarkMode ? Colors.white : primaryColor),
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
            blogList.clear();
            snap.data!.category!.forEach((element) {
              Iterable it = element.blog!;
              element.blog!.map((e) => blogList.add(e)).toList();
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
                            return FashionStoryComponent(
                              snap.data!.storyPost![index],
                              onCall: () {
                                StoryViewScreen(list: snap.data!.storyPost!)
                                    .launch(context);
                              },
                            );
                          }),
                    ],
                  ).visible(snap.data!.storyPost!.isNotEmpty &&
                      snap.data!.storyPost != null),
                  Column(
                    children: [
                      16.height,
                      mHeading("Suggest For You", 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      8.height,
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            height: context.height() * 0.4,
                            width: context.width(),
                            child: PageView.builder(
                              itemCount: blogList.length,
                              controller: pageController,
                              itemBuilder: (context, i) {
                                return FashionSuggestForYouComponent(
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
                  ).visible(snap.data!.category != null &&
                      snap.data!.category!.isNotEmpty),
                  FashionQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading("Featured Blog", "feature"),
                      8.height,
                      HorizontalList(
                          itemCount: snap.data!.featurePost!.length,
                          padding: EdgeInsets.only(left: 16),
                          itemBuilder: (_, index) {
                            return FashionFeatureComponent(
                                snap.data!.featurePost![index]);
                          }),
                    ],
                  ).visible(snap.data!.featurePost!.isNotEmpty &&
                      snap.data!.featurePost != null),
                  Stack(
                    children: [
                      Column(
                        children: [
                          20.height,
                          mHeading("Recent Blog", "recent"),
                          HorizontalList(
                              itemCount: snap.data!.recentPost!.length,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              itemBuilder: (_, index) {
                                return FashionRecentComponent(
                                    snap.data!.recentPost![index]);
                              }),
                          16.height,
                        ],
                      ).visible(snap.data!.recentPost!.isNotEmpty &&
                          snap.data!.recentPost != null),
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
