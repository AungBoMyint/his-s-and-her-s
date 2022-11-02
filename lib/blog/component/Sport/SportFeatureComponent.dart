import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/Sport/SportDetailScreen.dart';
import '../../utils/AppColor.dart';
import '../VideoPlayDialog.dart';

class SportFeatureComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;
  final bool? isSlider;
  final Function? onCall;

  SportFeatureComponent(this.featureData, {this.isSlider, this.onCall});

  @override
  _SportFeatureComponentState createState() => _SportFeatureComponentState();
}

class _SportFeatureComponentState extends State<SportFeatureComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width();

    return GestureDetector(
      onTap: () {
        widget.featureData!.postType == postVideoType
            ? VideoPlayDialog(widget.featureData!.videoType!,
                    widget.featureData!.videoUrl!)
                .launch(context)
            : SportDetailScreen(postId: widget.featureData!.iD).launch(context);
        widget.onCall!.call();
      },
      child: Stack(
        children: [
          Container(color: primaryColor.withOpacity(0.6), width: width)
              .paddingOnly(top: 20, bottom: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  commonCacheImageWidget(widget.featureData!.image.toString(),
                      fit: BoxFit.cover,
                      height: context.height() * 0.3,
                      width: context.height() * 0.25),
                  Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                      .visible(widget.featureData!.postType == postVideoType),
                ],
              ).paddingOnly(left: 20, right: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.featureData!.postTitle.validate(),
                      style: primaryTextStyle(color: Colors.white, size: 18),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                  8.height,
                  Text(widget.featureData!.humanTimeDiff!,
                      style: secondaryTextStyle(color: Colors.white54)),
                  10.height,
                  Container(
                      color: Colors.white54,
                      height: 2,
                      margin: EdgeInsets.only(left: 80)),
                  10.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.add, color: Colors.white54, size: 16),
                      4.width,
                      Text("More",
                          style: secondaryTextStyle(color: Colors.white54)),
                    ],
                  ),
                ],
              ).expand()
            ],
          ),
        ],
      ),
    );
  }
}
