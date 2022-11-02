import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/News/NewsCustomCategoryComponent.dart';
import '../../component/News/NewsFeatureComponent.dart';
import '../../component/News/NewsVideoComponent.dart';
import 'package:kzn/main.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../ViewAllScreen.dart';

class NewsCustomHomeScreen extends StatefulWidget {
  static String tag = '/NewsCustomHomeScreen';

  @override
  NewsCustomHomeScreenState createState() => NewsCustomHomeScreenState();
}

class NewsCustomHomeScreenState extends State<NewsCustomHomeScreen> {
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

  Widget mHeading(String? title, {bool? isViewAll = true, int? id, var data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.validate().capitalizeFirstLetter(),
                style: GoogleFonts.abrilFatface(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 24))
            .center(),
        Text("More",
                style: GoogleFonts.abrilFatface(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    fontSize: 14))
            .onTap(() {
          ViewAllScreen(name: title, customId: id).launch(context);
        }).visible(isViewAll == true)
      ],
    ).paddingSymmetric(horizontal: 16, vertical: 8);
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
                        16.height,
                        mHeading(data.title.validate(),
                            isViewAll: data.viewAll,
                            id: index,
                            data: data.type),
                        8.height,
                        if (data.type == "post")
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  itemBuilder: (_, index) {
                                    return NewsFeaturedComponent(
                                        data!.data![index],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return NewsFeaturedComponent(
                                          data!.data![index],
                                          isSlider: false);
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16),
                        if (data.type == postVideoType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  itemBuilder: (_, i) {
                                    return NewsVideoComponent(data!.data![i],
                                        isSlider: true);
                                  })
                              : ListView.builder(
                                  itemCount: data.data!.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  itemBuilder: (_, i) {
                                    return NewsVideoComponent(data!.data![i],
                                        isSlider: false);
                                  }),
                        if (data.type == "category")
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, bottom: 8),
                                  itemBuilder: (_, index1) {
                                    return NewsCustomCategoryComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return NewsCustomCategoryComponent(
                                          data!.data![index],
                                          isSlider: false);
                                    },
                                  ),
                                ).paddingLeft(16),
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
