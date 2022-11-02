import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../language/language.dart';
import '../../model/DefaultResponse.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../component/AppWidget.dart';
import '../../component/Travel/TravelBlogItemWidget.dart';
import '../../component/Travel/TravelFeaturedComponent.dart';
import '../../component/Travel/TravelQuickReadWidget.dart';
import '../../component/Travel/TravelSuggestForYouComponent.dart';
import '../../component/Travel/TravelStoryComponent.dart';
import 'package:kzn/main.dart';
import '../../model/DefaultPostResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppConstant.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../StoryViewScreen.dart';
import '../ViewAllScreen.dart';

class TravelHomeScreen extends StatefulWidget {
  static String tag = '/TravelHomeScreen';

  @override
  TravelHomeScreenState createState() => TravelHomeScreenState();
}

class TravelHomeScreenState extends State<TravelHomeScreen> {
  List<DefaultPostResponse> blogList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mHeading(String? title, String? viewAll, {String? data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ic_travel2,
            width: context.width() * 0.25,
            color: appStore.isDarkMode ? Colors.white : primaryColor),
        Column(
          children: [
            Text(title.validate().capitalizeFirstLetter(),
                style: GoogleFonts.robotoSlab(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                textAlign: TextAlign.center),
            Text(LanguageEn.btnMore, style: secondaryTextStyle(size: 16))
                .onTap(() {
              ViewAllScreen(
                      name: viewAll,
                      catData: data,
                      text: data.validate().isNotEmpty ? "Suggest For you" : "")
                  .launch(context);
            }),
          ],
        ).paddingOnly(bottom: 8).expand(),
        Image.asset(ic_travel3,
                width: context.width() * 0.25,
                color: appStore.isDarkMode ? Colors.white : primaryColor)
            .paddingLeft(4),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        await Future.delayed(Duration(seconds: 2));
      },
      child: FutureBuilder<DefaultResponse>(
        future: getDefaultDashboard(),
        builder: (context, snap) {
          if (snap.hasData) {
            DefaultResponse data = snap.data!;
            blogList.clear();
            data.category!.forEach((element) {
              Iterable it = element.blog!;
              it.map((e) => blogList.add(e)).toList();
            });
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      16.height,
                      HorizontalList(
                          itemCount: snap.data!.storyPost!.length,
                          padding: EdgeInsets.only(left: 16, bottom: 8),
                          itemBuilder: (_, index) {
                            return TravelStoryComponent(
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
                  16.height.visible(snap.data!.storyPost!.isEmpty),
                  Column(
                    children: [
                      mHeading(LanguageEn.lblFeaturedBlog, "feature"),
                      HorizontalList(
                          itemCount: data.featurePost!.length,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemBuilder: (_, index) {
                            return TravelFeaturedComponent(
                                data.featurePost![index],
                                isSlider: true);
                          }),
                    ],
                  ).visible(snap.data!.featurePost != null &&
                      snap.data!.featurePost!.isNotEmpty),
                  TravelQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      20.height,
                      mHeading(LanguageEn.lblRecentBlog, "recent"),
                      HorizontalList(
                          itemCount: data.recentPost!.length,
                          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                          itemBuilder: (_, index) {
                            return TravelBlogItemWidget(
                                data.recentPost![index]);
                          }),
                    ],
                  ).visible(snap.data!.recentPost!.isNotEmpty &&
                      snap.data!.recentPost != null),
                  Column(
                    children: [
                      25.height,
                      mHeading(LanguageEn.lblSuggestForYou, 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: blogList.length,
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 16),
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                TravelSuggestForYouComponent(blogList[index]),
                                Divider(height: 15, thickness: 1)
                                    .visible(index != blogList.length - 1),
                              ],
                            );
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
