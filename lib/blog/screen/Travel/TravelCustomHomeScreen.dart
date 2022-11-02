import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Travel/TravelCustomCategoryComponent.dart';
import '../../component/Travel/TravelCustomVideoComponent.dart';
import '../../component/Travel/TravelFeaturedComponent.dart';
import '../../component/VideoPlayDialog.dart';
import 'package:kzn/main.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppConstant.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../ViewAllScreen.dart';

class TravelCustomHomeScreen extends StatefulWidget {
  static String tag = '/TravelCustomHomeScreen';

  @override
  TravelCustomHomeScreenState createState() => TravelCustomHomeScreenState();
}

class TravelCustomHomeScreenState extends State<TravelCustomHomeScreen> {
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ic_travel2,
            width: context.width() * 0.25,
            color: appStore.isDarkMode ? Colors.white : primaryColor),
        Column(
          children: [
            Text(title.validate().capitalizeFirstLetter(),
                style: GoogleFonts.notoSerif(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            GestureDetector(
                    onTap: () {
                      ViewAllScreen(name: title, customId: id).launch(context);
                    },
                    child: Text('More',
                        style: GoogleFonts.notoSerif(
                            color: textSecondaryColorGlobal)))
                .visible(isViewAll == true),
          ],
        ).paddingOnly(bottom: 8),
        Image.asset(ic_travel3,
                width: context.width() * 0.25,
                color: appStore.isDarkMode ? Colors.white : primaryColor)
            .paddingLeft(4),
      ],
    ).paddingLeft(16);
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
                        16.height,
                        mHeading(data.title.validate(),
                            isViewAll: data.viewAll, id: index),
                        8.height,
                        if (data.type == postType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(
                                      left: 16, bottom: 8, top: 8),
                                  itemBuilder: (_, index1) {
                                    return TravelFeaturedComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return TravelFeaturedComponent(
                                          data!.data![index],
                                          isSlider: false);
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16),
                        if (data.type == postVideoType)
                          data.displayOption == "slider"
                              ? CarouselSlider.builder(
                                  itemCount: data.data!.length,
                                  itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) =>
                                      TravelCustomVideoComponent(
                                    data!.data![itemIndex],
                                    isSlider: true,
                                    onCall: () {
                                      VideoPlayDialog(
                                              data!.data![index].videoType!,
                                              data.data![index].videoUrl!)
                                          .launch(context);
                                    },
                                  ),
                                  options: CarouselOptions(
                                    autoPlay: false,
                                    reverse: false,
                                    enableInfiniteScroll: false,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.6,
                                    height: 300.0,
                                    aspectRatio: 1.5,
                                  ),
                                )
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return TravelCustomVideoComponent(
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
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 8),
                                  itemBuilder: (_, index1) {
                                    return TravelCustomCategoryComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return TravelCustomCategoryComponent(
                                              data!.data![index],
                                              isSlider: false)
                                          .paddingTop(8);
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
