import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/DefaultResponse.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Fitness/FitnessBlogItemWidget.dart';
import '../../component/Fitness/FitnessFeatureComponent.dart';
import '../../component/Fitness/FitnessStoryComponent.dart';
import '../../component/Fitness/FitnessSuggestForYouComponent.dart';
import '../../component/Fitness/FitnessQuickReadWidget.dart';
import 'package:kzn/main.dart';
import '../../model/DefaultPostResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../StoryViewScreen.dart';
import '../ViewAllScreen.dart';

class FitnessHomeScreen extends StatefulWidget {
  static String tag = '/LifeStyleHomeScreen';

  @override
  FitnessHomeScreenState createState() => FitnessHomeScreenState();
}

class FitnessHomeScreenState extends State<FitnessHomeScreen>
    with SingleTickerProviderStateMixin {
  List<DefaultPostResponse> blogList = [];
  Future<DefaultResponse>? mGetData;

  PageController pageController = PageController();

  int? currentIndex = 0;

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.validate(),
            style: GoogleFonts.playfairDisplay(
                color: textPrimaryColorGlobal,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        IconButton(
          onPressed: () {
            ViewAllScreen(
                    name: viewAll,
                    catData: data,
                    text: data.validate().isNotEmpty ? "Suggest For you" : "")
                .launch(context);
          },
          icon: Icon(Entypo.chevron_right, size: 18, color: context.iconColor),
        )
      ],
    ).paddingOnly(left: 16, bottom: 8);
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
                children: [
                  Column(
                    children: [
                      16.height,
                      HorizontalList(
                          itemCount: snap.data!.storyPost!.length,
                          padding: EdgeInsets.only(left: 16),
                          itemBuilder: (_, index) {
                            return FitnessStoryComponent(
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
                  Column(
                    children: [
                      16.height.visible(snap.data!.storyPost != null &&
                          snap.data!.storyPost!.isNotEmpty),
                      mHeading("Featured Blog", "feature"),
                      SizedBox(
                        height: context.height() * 0.4,
                        child: PageView.builder(
                          itemCount: snap.data!.featurePost!.length,
                          controller: pageController,
                          itemBuilder: (context, i) {
                            return FitnessFeatureComponent(
                              snap.data!.featurePost![i],
                              onCall: () {
                                pageController.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.linearToEaseOut);
                              },
                            );
                          },
                          onPageChanged: (int i) {
                            currentIndex = i;
                            setState(() {});
                          },
                        ),
                      ),
                      dotIndicator(snap.data!.featurePost!, currentIndex,
                              isPersonal: true)
                          .paddingTop(8),
                      16.height,
                    ],
                  ).visible(snap.data!.featurePost != null &&
                      snap.data!.featurePost!.isNotEmpty),
                  FitnessQuickReadWidget(snap.data!.recentPost!).visible(
                      snap.data!.recentPost != null &&
                          snap.data!.recentPost!.isNotEmpty),
                  Column(
                    children: [
                      mHeading("Recent Blog", "recent"),
                      HorizontalList(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          itemCount: snap.data!.recentPost!.length,
                          itemBuilder: (_, index) {
                            return FitnessBlogItemWidget(
                                snap.data!.recentPost![index]);
                          }),
                      16.height,
                    ],
                  ).visible(snap.data!.recentPost!.isNotEmpty &&
                      snap.data!.recentPost != null),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mHeading("Suggest For You", 'by_category',
                          data: getStringListAsync(chooseTopicList).toString()),
                      Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          blogList.length,
                          (index) {
                            if (index % 2 == 0)
                              return FitnessSuggestForYouComponent(
                                  blogList[index],
                                  isEven: true);
                            else
                              return FitnessSuggestForYouComponent(
                                  blogList[index],
                                  isEven: false);
                          },
                        ),
                      ).paddingSymmetric(horizontal: 16),
                      16.height,
                    ],
                  ).visible(blogList.isNotEmpty),
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
