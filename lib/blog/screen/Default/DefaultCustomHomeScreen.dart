import 'package:flutter/material.dart';
import '../../component/Default/DefaultBlogItemWidget.dart';
import '../../component/Default/DefaultCustomCategoryListComponent.dart';
import '../../component/Default/DefaultCustomCategorySliderComponent.dart';
import '../../component/Default/DefaultCustomVideoListComponent.dart';
import '../../component/Default/DefaultCustomVideoSliderComponent.dart';
import '../../model/CustomDashboardResponse.dart';
import '../../network/RestApi.dart';
import '../../component/Default/DefaultFeaturedComponent.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../component/AppWidget.dart';
import '../../component/VideoPlayDialog.dart';
import '../ViewAllScreen.dart';

class DefaultCustomHomeScreen extends StatefulWidget {
  static String tag = '/DefaultCustomHomeScreen';

  @override
  DefaultCustomHomeScreenState createState() => DefaultCustomHomeScreenState();
}

class DefaultCustomHomeScreenState extends State<DefaultCustomHomeScreen> {
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
        Text(title!, style: boldTextStyle(size: 20)),
        TextButton(
          child: Row(
            children: [
              Text("More", style: secondaryTextStyle(size: 16)),
              Icon(Icons.keyboard_arrow_right,
                  size: 18, color: textSecondaryColorGlobal),
            ],
          ),
          onPressed: () {
            ViewAllScreen(name: title, customId: id).launch(context);
          },
        ).visible(isViewAll == true),
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
                children: List.generate(
                  snap.data!.length,
                  (index) {
                    CustomDashboardResponse? data;
                    data = snap.data![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mHeading(data.title.validate().capitalizeFirstLetter(),
                            isViewAll: true, id: index),
                        if (data.type == postType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(
                                      left: 16, top: 8, bottom: 16),
                                  itemBuilder: (_, index1) {
                                    return DefaultFeaturedComponent(
                                      data!.data![index],
                                    );
                                  })
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 8),
                                  itemBuilder: (_, index) {
                                    return DefaultBlogItemWidget(
                                        data!.data![index]);
                                  },
                                ),
                        if (data.type == postVideoType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(
                                      left: 16, top: 8, bottom: 16),
                                  itemBuilder: (_, index1) {
                                    return DefaultCustomVideoSliderComponent(
                                      data!.data![index1],
                                      onCall: () {
                                        VideoPlayDialog(
                                                data!.data![index].videoType!,
                                                data.data![index].videoUrl!)
                                            .launch(context);
                                      },
                                    );
                                  })
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(
                                      left: 16, top: 8, right: 16),
                                  itemBuilder: (_, index) {
                                    return DefaultCustomVideoListComponent(
                                      data!.data![index],
                                      onCall: () {
                                        VideoPlayDialog(
                                                data!.data![index].videoType!,
                                                data.data![index].videoUrl!)
                                            .launch(context);
                                      },
                                    );
                                  },
                                ),
                        if (data.type == postCategoryType)
                          data.displayOption == "slider"
                              ? HorizontalList(
                                  itemCount: data.data!.length,
                                  padding: EdgeInsets.only(
                                      left: 16, top: 8, bottom: 16),
                                  itemBuilder: (_, index1) {
                                    return DefaultCustomCategorySliderComponent(
                                        data!.data![index1]);
                                  })
                              : Wrap(
                                  runSpacing: 12,
                                  children: List.generate(
                                    data.data!.length,
                                    (index) {
                                      return DefaultCustomCategoryListComponent(
                                          data!.data![index]);
                                    },
                                  ),
                                ).paddingOnly(top: 8, bottom: 8)
                      ],
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
