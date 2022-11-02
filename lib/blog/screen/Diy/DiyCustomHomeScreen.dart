import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Diy/DiyCustomCategoryComponent.dart';
import '../../component/Diy/DiyFeaturedComponent.dart';
import '../../component/Diy/DiyVideoComponent.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../ViewAllScreen.dart';

class DiyCustomHomeScreen extends StatefulWidget {
  static String tag = '/DiyCustomHomeScreen';

  @override
  DiyCustomHomeScreenState createState() => DiyCustomHomeScreenState();
}

class DiyCustomHomeScreenState extends State<DiyCustomHomeScreen> {
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
            Text(title.validate().capitalizeFirstLetter(),
                    style: GoogleFonts.cormorantGaramond(
                        color: textPrimaryColorGlobal,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 28))
                .center(),
          ],
        ),
        Text("More",
                style: GoogleFonts.cormorantGaramond(
                    fontSize: 18, color: textSecondaryColorGlobal))
            .onTap(() {
          ViewAllScreen(name: title, customId: id).launch(context);
        }).visible(isViewAll == true)
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
      child: FutureBuilder<List<CustomDashboardResponse>>(
        future: getCustomDashboard(),
        builder: (context, snap) {
          if (snap.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              ? HorizontalList(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  itemCount: data.data!.length,
                                  itemBuilder: (_, index) {
                                    return DiyFeaturedComponent(
                                        data!.data![index],
                                        isSlider: true,
                                        isEven: false);
                                  })
                              : ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: data.data!.length,
                                  itemBuilder: (context, index) {
                                    if (index % 2 == 0)
                                      return DiyFeaturedComponent(
                                          data!.data![index],
                                          isSlider: false,
                                          isEven: true);
                                    else
                                      return DiyFeaturedComponent(
                                          data!.data![index],
                                          isSlider: false,
                                          isEven: false);
                                  }).paddingSymmetric(horizontal: 16),
                        if (data.type == postVideoType)
                          data.displayOption == "slider"
                              ? CarouselSlider.builder(
                                  itemCount: data.data!.length,
                                  itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) =>
                                      DiyVideoComponent(data!.data![itemIndex],
                                          isSlider: true),
                                  options: CarouselOptions(
                                    autoPlay: false,
                                    reverse: false,
                                    enableInfiniteScroll: false,
                                    enlargeCenterPage: true,
                                    initialPage: 1,
                                    height: 280.0,
                                    viewportFraction: 0.5,
                                    aspectRatio: 1.2,
                                  ),
                                )
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return DiyVideoComponent(
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
                                      left: 16, right: 16, top: 8),
                                  itemBuilder: (_, index1) {
                                    return DiyCustomCategoryComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return DiyCustomCategoryComponent(
                                          data!.data![index],
                                          isSlider: false);
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16, vertical: 8),
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
