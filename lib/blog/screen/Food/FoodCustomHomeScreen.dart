import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';

import '../../component/AppWidget.dart';
import '../../component/Food/FoodCustomCategoryComponent.dart';
import '../../component/Food/FoodCustomVideoComponent.dart';
import '../../component/Food/FoodFeatureComponent.dart';
import 'package:kzn/main.dart';
import '../../utils/AppColor.dart';
import '../ViewAllScreen.dart';

class FoodCustomHomeScreen extends StatefulWidget {
  @override
  _FoodCustomHomeScreenState createState() => _FoodCustomHomeScreenState();
}

class _FoodCustomHomeScreenState extends State<FoodCustomHomeScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  Widget mHeading(String? title, {bool? isViewAll = true, int? id}) {
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
                    fontSize: 24))
            .expand(),
        TextButton(
                onPressed: () {
                  ViewAllScreen(name: title, customId: id).launch(context);
                },
                child: Text('More',
                    style:
                        GoogleFonts.notoSerif(color: textSecondaryColorGlobal)))
            .visible(isViewAll == true)
      ],
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
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
                        16.height,
                        if (data.type == postType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  itemBuilder: (_, index1) {
                                    return FoodFeatureComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return FoodFeatureComponent(
                                          data!.data![index],
                                          isSlider: false);
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16),
                        if (data.type == postVideoType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  itemBuilder: (_, i) {
                                    return FoodCustomVideoComponent(
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
                                      return FoodCustomVideoComponent(
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
                                    return FoodCustomCategoryComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 18,
                                  spacing: 14,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return FoodCustomCategoryComponent(
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
