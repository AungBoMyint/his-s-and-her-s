import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import '../../component/Sport/SportSuggestForYouComponent.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Sport/SportBlogItemWidget.dart';
import '../../component/Sport/SportCustomCategoryComponent.dart';
import '../../component/Sport/SportVideoComponent.dart';

import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../ViewAllScreen.dart';

class SportCustomHomeScreen extends StatefulWidget {
  static String tag = '/FitnessCustomHomeScreen';

  @override
  SportCustomHomeScreenState createState() => SportCustomHomeScreenState();
}

class SportCustomHomeScreenState extends State<SportCustomHomeScreen> {
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
      children: [
        Image.asset(ic_sports,
            height: 20,
            width: 20,
            color: appStore.isDarkMode ? Colors.white : primaryColor),
        6.width,
        Text(title.validate(),
                style: GoogleFonts.poppins(
                    color: data == 'category'
                        ? Colors.white
                        : textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    fontSize: 24))
            .expand(),
        IconButton(
          onPressed: () {
            ViewAllScreen(name: title, customId: id).launch(context);
          },
          icon: Icon(Icons.arrow_forward, size: 18),
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
                    return Container(
                      margin: EdgeInsets.only(
                          left: data.type == "category" ? 16 : 0,
                          bottom: data.type == "category" ? 16 : 0),
                      decoration: data.type == "category"
                          ? boxDecorationWithShadowWidget(
                              backgroundColor: primaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)))
                          : BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mHeading(data.title.validate(),
                              isViewAll: data.viewAll,
                              id: index,
                              data: data.type),
                          8.height,
                          if (data.type == postType)
                            data.displayOption == "slider"
                                ? HorizontalList(
                                    itemCount: data.data!.length,
                                    padding:
                                        EdgeInsets.only(left: 16, right: 8),
                                    itemBuilder: (_, index) {
                                      return SportBlogItemWidget(
                                          data!.data![index]);
                                    })
                                : Wrap(
                                    runSpacing: 8,
                                    spacing: 8,
                                    children: List.generate(
                                      data.data!.length,
                                      (index) {
                                        return SportSuggestForYouComponent(
                                            data!.data![index]);
                                      },
                                    ),
                                  ).paddingSymmetric(horizontal: 16),
                          if (data.type == postVideoType)
                            data.displayOption == "slider"
                                ? HorizontalList(
                                    itemCount: data.data!.length,
                                    padding:
                                        EdgeInsets.only(right: 16, left: 16),
                                    itemBuilder: (_, i) {
                                      return SportVideoComponent(data!.data![i],
                                          isSlider: true);
                                    })
                                : Wrap(
                                    runSpacing: 8,
                                    spacing: 8,
                                    children: List.generate(
                                      data.data!.length,
                                      (index) {
                                        return SportVideoComponent(
                                            data!.data![index],
                                            isSlider: false);
                                      },
                                    ),
                                  ).paddingSymmetric(horizontal: 16),
                          if (data.type == postCategoryType)
                            data.displayOption == "slider"
                                ? HorizontalList(
                                    itemCount: data.data!.length,
                                    padding: EdgeInsets.only(
                                        left: 16, right: 16, bottom: 8),
                                    itemBuilder: (_, index1) {
                                      return SportCustomCategoryComponent(
                                          data!.data![index1],
                                          isSlider: true);
                                    })
                                : Wrap(
                                    runSpacing: 8,
                                    spacing: 8,
                                    children: List.generate(
                                      data.data!.length,
                                      (index) {
                                        return SportCustomCategoryComponent(
                                            data!.data![index],
                                            isSlider: false);
                                      },
                                    ),
                                  ).paddingSymmetric(
                                    horizontal: 16, vertical: 8),
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
