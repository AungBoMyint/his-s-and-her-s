import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../component/Fashion/FashionCustomCategoryComponent.dart';
import '../../component/Fashion/FashionCustomVideoComponent.dart';
import '../../component/Fashion/FashionFeatureComponent.dart';
import '../../component/Fashion/FashionRecentComponent.dart';
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
import '../../utils/AppColor.dart';
import '../../utils/AppImages.dart';
import '../ViewAllScreen.dart';
import 'package:kzn/main.dart';

class FashionCustomHomeScreen extends StatefulWidget {
  @override
  _FashionCustomHomeScreenState createState() =>
      _FashionCustomHomeScreenState();
}

class _FashionCustomHomeScreenState extends State<FashionCustomHomeScreen> {
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ic_fashionHeading1,
            width: context.width() / 4,
            color: appStore.isDarkMode ? Colors.white : primaryColor),
        Column(
          children: [
            Text(title.validate().capitalizeFirstLetter(),
                style: GoogleFonts.redressed(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            Text("+ Explore",
                    style: GoogleFonts.redressed(
                        fontSize: 16, color: textPrimaryColorGlobal))
                .onTap(() {
              ViewAllScreen(name: title, customId: id).launch(context);
            }).visible(isViewAll == true),
          ],
        ).paddingOnly(left: 16, right: 16, bottom: 8, top: 8),
        Image.asset(ic_fashionHeading1,
            width: context.width() / 4,
            color: appStore.isDarkMode ? Colors.white : primaryColor),
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
                    return Container(
                      color: data.type == "category"
                          ? catBgColor
                          : context.scaffoldBackgroundColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.height,
                          mHeading(data.title.validate(),
                              isViewAll: data.viewAll, id: index),
                          8.height,
                          if (data.type == postType)
                            data.displayOption == "slider"
                                ? HorizontalList(
                                    itemCount: data.data!.length,
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    itemBuilder: (_, index1) {
                                      return FashionFeatureComponent(
                                          data!.data![index1]);
                                    })
                                : Wrap(
                                    runSpacing: 8,
                                    spacing: 8,
                                    children: List.generate(
                                      data.data!.length,
                                      (index) {
                                        return FashionRecentComponent(
                                            data!.data![index],
                                            isSlider: false);
                                      },
                                    ),
                                  ).paddingSymmetric(horizontal: 16),
                          if (data.type == postVideoType)
                            data.displayOption == "slider"
                                ? HorizontalList(
                                    itemCount: data.data!.length,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    itemBuilder: (_, i) {
                                      return FashionCustomVideoComponent(
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
                                        return FashionCustomVideoComponent(
                                          data!.data![index],
                                          isSlider: false,
                                          onCall: () {
                                            VideoPlayDialog(
                                                    data!.data![index]
                                                        .videoType!,
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
                                    padding:
                                        EdgeInsets.only(left: 16, bottom: 16),
                                    itemBuilder: (_, index1) {
                                      return FashionCustomCategoryComponent(
                                        data!.data![index1],
                                      );
                                    })
                                : Wrap(
                                    runSpacing: 18,
                                    spacing: 12,
                                    children: List.generate(
                                      data.data!.length,
                                      (index) {
                                        return FashionCustomCategoryComponent(
                                          data!.data![index],
                                        );
                                      },
                                    ),
                                  ).paddingSymmetric(horizontal: 16),
                        ],
                      ).paddingOnly(bottom: 16),
                    );
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
