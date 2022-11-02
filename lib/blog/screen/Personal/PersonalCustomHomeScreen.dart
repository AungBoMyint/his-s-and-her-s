import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/Personal/PersonalCustomCategoryComponent.dart';
import '../../component/Personal/PersonalFeatureComponent.dart';
import '../../component/Personal/PersonalVideoComponent.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../ViewAllScreen.dart';

class PersonalCustomHomeScreen extends StatefulWidget {
  static String tag = '/PersonalCustomHomeScreen';

  @override
  PersonalCustomHomeScreenState createState() =>
      PersonalCustomHomeScreenState();
}

class PersonalCustomHomeScreenState extends State<PersonalCustomHomeScreen> {
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
    return Container(
      height: 65,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GradientText(
            title.validate().toUpperCase(),
            style: GoogleFonts.unna(
                color: textPrimaryColorGlobal, letterSpacing: 2, fontSize: 50),
            gradient: LinearGradient(
              colors: [
                Colors.black12.withOpacity(.05),
                Colors.black26.withOpacity(.05),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title.validate().toUpperCase(),
                  style: GoogleFonts.unna(
                      color: textPrimaryColorGlobal,
                      fontWeight: FontWeight.bold,
                      fontSize: 26)),
              Text("More",
                      style: GoogleFonts.unna(
                          color: textPrimaryColorGlobal,
                          fontWeight: FontWeight.normal,
                          fontSize: 18))
                  .onTap(() {
                ViewAllScreen(name: title, customId: id).launch(context);
              }).visible(isViewAll == true)
            ],
          ),
        ],
      ),
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
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  itemBuilder: (_, index) {
                                    return PersonalFeatureComponent(
                                        data!.data![index],
                                        isSlider: true);
                                  })
                              : ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  itemBuilder: (_, index) {
                                    if (index % 2 == 0)
                                      return PersonalFeatureComponent(
                                          data!.data![index],
                                          isSlider: false,
                                          isEven: true);
                                    else
                                      return PersonalFeatureComponent(
                                          data!.data![index],
                                          isSlider: false,
                                          isEven: false);
                                  }),
                        if (data.type == postVideoType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.all(16),
                                  itemBuilder: (_, i) {
                                    return PersonalVideoComponent(
                                        data!.data![i],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 16,
                                  spacing: 8,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return PersonalVideoComponent(
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
                                      left: 16, right: 16, bottom: 8, top: 8),
                                  itemBuilder: (_, index1) {
                                    return PersonalCustomCategoryComponent(
                                        data!.data![index1],
                                        isSlider: true);
                                  })
                              : Wrap(
                                  runSpacing: 18,
                                  spacing: 14,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return PersonalCustomCategoryComponent(
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
