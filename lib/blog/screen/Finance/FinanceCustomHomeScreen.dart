import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Finance/FinanceCustomCategoryComponent.dart';
import '../../component/Finance/FinanceFeatureComponent.dart';
import '../../component/Finance/FinanceVideoComponent.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../ViewAllScreen.dart';

class FinanceCustomHomeScreen extends StatefulWidget {
  static String tag = '/FitnessCustomHomeScreen';

  @override
  FinanceCustomHomeScreenState createState() => FinanceCustomHomeScreenState();
}

class FinanceCustomHomeScreenState extends State<FinanceCustomHomeScreen> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(title.validate().capitalizeFirstLetter(),
            style: GoogleFonts.bebasNeue(
                color: textPrimaryColorGlobal,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("More",
                style: GoogleFonts.bebasNeue(
                    color: textPrimaryColorGlobal,
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    fontSize: 14)),
            Icon(Icons.keyboard_arrow_right,
                size: 18, color: context.iconColor),
          ],
        ).onTap(() {
          ViewAllScreen(name: title, customId: id).launch(context);
        }).visible(isViewAll == true)
      ],
    ).paddingOnly(bottom: 8);
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
                      children: [
                        16.height,
                        mHeading(data.title.validate(),
                            isViewAll: data.viewAll,
                            id: index,
                            data: data.type),
                        8.height,
                        if (data.type == postType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(left: 16, right: 8),
                                  itemBuilder: (_, index) {
                                    return FinanceFeatureComponent(
                                        data!.data![index],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return FinanceFeatureComponent(
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
                                    return FinanceVideoComponent(data!.data![i],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return FinanceVideoComponent(
                                          data!.data![index],
                                          isSlider: false);
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16),
                        if (data.type == "category")
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  itemBuilder: (_, index1) {
                                    return FinanceCustomCategoryComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return FinanceCustomCategoryComponent(
                                          data!.data![index],
                                          isSlider: false);
                                    },
                                  ),
                                ).paddingSymmetric(horizontal: 16),
                      ],
                    );
                  },
                ),
              ).paddingBottom(30),
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
