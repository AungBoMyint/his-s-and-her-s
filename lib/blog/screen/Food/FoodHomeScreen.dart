import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/DefaultPostResponse.dart';
import '../../model/DefaultResponse.dart';
import '../../network/RestApi.dart';
import '../../screen/Food/FoodDetailScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Food/FoodBlogItemWidget.dart';
import '../../component/Food/FoodFeatureComponent.dart';
import '../../component/Food/FoodQuickReadWidget.dart';
import '../../component/Food/FoodStoryComponent.dart';
import '../../component/Food/FoodSuggestForYouComponent.dart';
import 'package:kzn/main.dart';
import '../StoryViewScreen.dart';
import '../ViewAllScreen.dart';

class FoodHomeScreen extends StatefulWidget {
  static String tag = '/FashionHomeScreen';

  @override
  FoodHomeScreenState createState() => FoodHomeScreenState();
}

class FoodHomeScreenState extends State<FoodHomeScreen> {
  TextEditingController searchCon = TextEditingController();
  PageController pageController = PageController();
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
      children: [
        Container(
            height: 30,
            width: 40,
            color: appStore.isDarkMode ? context.cardColor : primaryColor,
            margin: EdgeInsets.only(right: 6)),
        Text(title.validate().capitalizeFirstLetter(),
                style: GoogleFonts.notoSerif(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 20))
            .expand(),
        TextButton(
            onPressed: () {
              ViewAllScreen(
                name: viewAll,
                catData: data,
                text: data.validate().isNotEmpty ? "Suggest For you" : "",
              ).launch(context);
            },
            child: Text("More",
                style: GoogleFonts.notoSerif(color: textSecondaryColorGlobal)))
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HorizontalList(
                      itemCount: snap.data!.storyPost!.length,
                      padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                      itemBuilder: (_, index) {
                        return FoodStoryComponent(
                          snap.data!.storyPost![index],
                          onCall: () {
                            StoryViewScreen(list: snap.data!.storyPost!)
                                .launch(context);
                          },
                        );
                      }).visible(snap
                          .data!.storyPost!.isNotEmpty &&
                      snap.data!.storyPost != null),
                  Column(
                    children: [
                      16.height.visible(snap.data!.storyPost!.isNotEmpty &&
                          snap.data!.storyPost != null),
                      mHeading("Featured Blog", "feature"),
                      8.height,
                      HorizontalList(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          itemCount: data.featurePost!.length,
                          itemBuilder: (_, index) {
                            return FoodFeatureComponent(
                                data.featurePost![index],
                                isSlider: true);
                          }),
                    ],
                  ).visible(snap.data!.featurePost!.isNotEmpty &&
                      snap.data!.featurePost != null),
                  FoodQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading("Suggest For You", 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      8.height,
                      HorizontalList(
                          itemCount: blogList.length,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          itemBuilder: (_, index) {
                            return FoodSuggestForYouComponent(blogList[index]);
                          }),
                    ],
                  ).visible(snap.data!.recentPost!.isNotEmpty &&
                      snap.data!.recentPost != null),
                  Column(
                    children: [
                      16.height,
                      mHeading("Recent Blog", "recent"),
                      8.height,
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          itemCount: data.recentPost!.length,
                          itemBuilder: (_, index) {
                            return FoodBlogItemWidget(
                              data.recentPost![index],
                              onCall: () {
                                FoodDetailScreen(
                                        postId: data.recentPost![index].iD)
                                    .launch(context);
                              },
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
