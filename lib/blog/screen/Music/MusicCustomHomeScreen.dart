import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Music/MusicCustomCategoryComponent.dart';
import '../../component/Music/MusicCustomVideoComponent.dart';
import '../../component/Music/MusicFeatureComponent.dart';
import '../../component/Music/MusicSuggestForYouComponent.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppConstant.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../ViewAllScreen.dart';

class MusicCustomHomeScreen extends StatefulWidget {
  static String tag = '/MusicCustomHomeScreen';

  @override
  MusicCustomHomeScreenState createState() => MusicCustomHomeScreenState();
}

class MusicCustomHomeScreenState extends State<MusicCustomHomeScreen> {
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

  Widget mHeading(String? title, {bool? isViewAll = true, int? id}) {
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
                    fontSize: 24)),
            Text("Explore",
                    style: GoogleFonts.poppins(color: textSecondaryColorGlobal))
                .onTap(() {
              ViewAllScreen(name: title, customId: id).launch(context);
            }).visible(isViewAll == true),
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
      child: FutureBuilder<List<CustomDashboardResponse>>(
        future: getCustomDashboard(),
        builder: (context, snap) {
          if (snap.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: List.generate(
                  snap.data!.length,
                  (index) {
                    CustomDashboardResponse? data;
                    data = snap.data![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        8.height,
                        mHeading(data.title.validate(),
                            isViewAll: data.viewAll, id: index),
                        8.height,
                        if (data.type == postType)
                          data.displayOption == "slider"
                              ? CarouselSlider.builder(
                                  itemCount: data.data!.length,
                                  itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) =>
                                      MusicFeatureComponent(
                                          data!.data![itemIndex],
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
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      if (index % 2 == 0)
                                        return MusicSuggestForYouComponent(
                                            data!.data![index],
                                            isEven: true);
                                      else
                                        return MusicSuggestForYouComponent(
                                            data!.data![index],
                                            isEven: false);
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16),
                        if (data.type == postVideoType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(right: 16, left: 16),
                                  itemBuilder: (_, i) {
                                    return MusicCustomVideoComponent(
                                      data!.data![i],
                                      isSlider: true,
                                      onCall: () {
                                        VideoPlayDialog(
                                                data!.data![i].videoType!,
                                                data.data![i].videoUrl!)
                                            .launch(context);
                                      },
                                    );
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return MusicCustomVideoComponent(
                                        data!.data![index],
                                        isSlider: false,
                                        onCall: () {
                                          VideoPlayDialog(
                                                  data!.data![index].videoType!,
                                                  data.data![index].videoUrl!)
                                              .launch(context);
                                        },
                                      );
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16),
                        if (data.type == postCategoryType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  itemBuilder: (_, index1) {
                                    return MusicCustomCategoryComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 18,
                                  spacing: 14,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return MusicCustomCategoryComponent(
                                          data!.data![index],
                                          isSlider: false);
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16),
                      ],
                    ).paddingOnly(bottom: 16);
                  },
                ),
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
