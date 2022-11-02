import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../component/Fitness/FitnessSuggestForYouComponent.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Fitness/FitnessCustomCategoryComponent.dart';
import '../../component/Fitness/FitnessVideoComponent.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../ViewAllScreen.dart';

class FitnessCustomHomeScreen extends StatefulWidget {
  static String tag = '/FitnessCustomHomeScreen';

  @override
  FitnessCustomHomeScreenState createState() => FitnessCustomHomeScreenState();
}

class FitnessCustomHomeScreenState extends State<FitnessCustomHomeScreen> {
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
        Text(title.validate().capitalizeFirstLetter(),
            style: GoogleFonts.playfairDisplay(
                color: textPrimaryColorGlobal,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        IconButton(
          onPressed: () {
            ViewAllScreen(name: title, customId: id).launch(context);
          },
          icon: Icon(Icons.arrow_forward_ios, size: 18),
        ).visible(isViewAll == true)
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
                        mHeading(data.title.validate(),
                            isViewAll: data.viewAll, id: index),
                        8.height,
                        if (data.type == postType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(left: 16, right: 8),
                                  itemBuilder: (_, index) {
                                    return FitnessSuggestForYouComponent(
                                        data!.data![index],
                                        isEven: false);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      if (index % 2 == 0)
                                        return FitnessSuggestForYouComponent(
                                          data!.data![index],
                                          isEven: true,
                                        );
                                      else
                                        return FitnessSuggestForYouComponent(
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
                                    return FitnessVideoComponent(
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
                              : ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: data.data!.length,
                                  itemBuilder: (context, i) {
                                    return FitnessVideoComponent(
                                      data!.data![i],
                                      onCall: () {
                                        VideoPlayDialog(
                                                data!.data![i].videoType!,
                                                data.data![i].videoUrl!)
                                            .launch(context);
                                      },
                                    );
                                  }).paddingSymmetric(horizontal: 16),
                        if (data.type == postCategoryType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 2, bottom: 8),
                                  itemBuilder: (_, index1) {
                                    return FitnessCustomCategoryComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 18,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return FitnessCustomCategoryComponent(
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
