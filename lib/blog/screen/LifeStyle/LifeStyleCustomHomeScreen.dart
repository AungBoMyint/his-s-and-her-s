import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../component/LifeStyle/LifeStyleBlogItemWidget.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/LifeStyle/LifeStyleCustomCategoryComponent.dart';
import '../../component/LifeStyle/LifeStyleVideoComponent.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../ViewAllScreen.dart';

class LifeStyleCustomHomeScreen extends StatefulWidget {
  static String tag = '/LifeStyleCustomHomeScreen';

  @override
  LifeStyleCustomHomeScreenState createState() =>
      LifeStyleCustomHomeScreenState();
}

class LifeStyleCustomHomeScreenState extends State<LifeStyleCustomHomeScreen> {
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
            style: GoogleFonts.poppins(
                color: textPrimaryColorGlobal,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        IconButton(
          onPressed: () {
            ViewAllScreen(name: title, customId: id).launch(context);
          },
          icon: Icon(Icons.keyboard_arrow_right, size: 18),
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
                                    return LifeStyleBlogItemWidget(
                                        data!.data![index],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return LifeStyleBlogItemWidget(
                                          data!.data![index],
                                          isSlider: false);
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16),
                        if (data.type == postVideoType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(right: 16, left: 16),
                                  itemBuilder: (_, i) {
                                    return LifeStyleVideoComponent(
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
                                      return LifeStyleVideoComponent(
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
                                    return LifeStyleCustomCategoryComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return LifeStyleCustomCategoryComponent(
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
