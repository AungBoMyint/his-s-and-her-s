import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blog/../main.dart';
import '../../blog/component/Diy/DiyQuickReadWidget.dart';
import '../../blog/model/DefaultResponse.dart';
import '../../blog/utils/Extensions/Constants.dart';
import '../../blog/utils/Extensions/HorizontalList.dart';
import '../../blog/utils/Extensions/Loader.dart';
import '../../blog/utils/Extensions/Widget_extensions.dart';
import '../../blog/utils/Extensions/context_extensions.dart';
import '../../blog/utils/Extensions/int_extensions.dart';
import '../../blog/utils/Extensions/string_extensions.dart';
import '../../blog/utils/Extensions/text_styles.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../blog/component/AppWidget.dart';
import '../../blog/component/Diy/DiyBlogItemWidget.dart';
import '../../blog/component/Diy/DiyFeaturedComponent.dart';
import '../../blog/component/Diy/DiySuggestForYouComponent.dart';
import '../../blog/component/Diy/DiyStoryComponent.dart';
import '../../blog/model/DefaultPostResponse.dart';
import '../../blog/network/RestApi.dart';
import '../../blog/utils/AppColor.dart';
import '../../blog/utils/AppCommon.dart';
import '../../blog/utils/AppConstant.dart';
import '../../blog/utils/AppImages.dart';
import '../../blog/utils/Extensions/Commons.dart';
import '../../blog/utils/Extensions/shared_pref.dart';
import '../blog/screen/StoryViewScreen.dart';
import '../blog/screen/ViewAllScreen.dart';

class DefaultHomeScreen extends StatefulWidget {
  static String tag = '/DefaultHomeScreen';

  @override
  DefaultHomeScreenState createState() => DefaultHomeScreenState();
}

class DefaultHomeScreenState extends State<DefaultHomeScreen>
    with SingleTickerProviderStateMixin {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  List<DefaultPostResponse> blogList = [];
  List<Widget> tabs = [];
  int? currentIndex = 0;
  PageController? pageController;
  Future<DefaultResponse>? mGetData;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ic_diyHeading,
                width: 30,
                height: 30,
                color: appStore.isDarkMode ? Colors.white : primaryColor),
            2.width,
            Text(title.validate().toUpperCase(),
                style: GoogleFonts.cormorantGaramond(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 26)),
          ],
        ),
        Text("More",
                style: GoogleFonts.cormorantGaramond(
                    fontSize: 18, color: textSecondaryColorGlobal))
            .onTap(() {
          ViewAllScreen(
                  name: viewAll,
                  catData: data,
                  text: data.validate().isNotEmpty ? "Suggest For you" : "")
              .launch(context);
        })
      ],
    ).paddingOnly(left: 16, right: 8);
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
                  child: Text(
                    parseHtmlString(
                        snap.data!.category![i].catName.toString().validate()),
                    style: primaryTextStyle(),
                  ),
                ),
              );
            }
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
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 8),
                          itemBuilder: (_, index) {
                            return DiyStoryComponent(
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
                      16.height,
                      mHeading("Suggest For You", 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      SizedBox(
                        height: context.height() * 0.34,
                        width: context.width(),
                        child: PageView.builder(
                          itemCount: blogList.length,
                          controller: pageController,
                          itemBuilder: (context, i) {
                            return DiySuggestForYouComponent(blogList[i]);
                          },
                          onPageChanged: (int i) {
                            currentIndex = i;
                            setState(() {});
                          },
                        ),
                      ),
                      dotIndicator(blogList, currentIndex, isPersonal: true)
                          .paddingTop(8),
                    ],
                  ).visible(snap.data!.category != null &&
                      snap.data!.category!.isNotEmpty),
                  DiyQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading("Recent Blog", "recent"),
                      HorizontalList(
                          itemCount: snap.data!.recentPost!.length,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemBuilder: (_, index) {
                            return DiyBlogItemWidget(
                                snap.data!.recentPost![index]);
                          }),
                      16.height,
                    ],
                  ).visible(snap.data!.recentPost != null &&
                      snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      Divider(height: 30),
                      mHeading("Featured Blog", "feature"),
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snap.data!.featurePost!.length,
                          itemBuilder: (context, index) {
                            if (index % 2 == 0)
                              return DiyFeaturedComponent(
                                  snap.data!.featurePost![index],
                                  isSlider: false,
                                  isEven: true);
                            else
                              return DiyFeaturedComponent(
                                  snap.data!.featurePost![index],
                                  isSlider: false,
                                  isEven: false);
                          }).paddingSymmetric(horizontal: 16)
                    ],
                  ).visible(snap.data!.featurePost != null &&
                      snap.data!.featurePost!.isNotEmpty),
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
