import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/Diy/DiyDetailScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Colors.dart';
import '../../utils/Extensions/Commons.dart';
import '../AppWidget.dart';
import '../VideoPlayDialog.dart';

class DiyFeaturedComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;
  final bool? isSlider;
  final bool? isEven;

  DiyFeaturedComponent(this.featureData, {this.isSlider, this.isEven});

  @override
  _DiyFeaturedComponentState createState() => _DiyFeaturedComponentState();
}

class _DiyFeaturedComponentState extends State<DiyFeaturedComponent> {
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
    return GestureDetector(
      onTap: () {
        widget.featureData!.postType == postVideoType
            ? VideoPlayDialog(widget.featureData!.videoType!,
                    widget.featureData!.videoUrl!)
                .launch(context)
            : DiyDetailScreen(postId: widget.featureData!.iD).launch(context);
      },
      child: Container(
        width:
            widget.isSlider == true ? context.width() * 0.88 : context.width(),
        height: 210,
        margin: EdgeInsets.only(
            top: 8, bottom: 8, right: widget.isSlider == true ? 8 : 0),
        decoration: boxDecorationWithShadowWidget(
            backgroundColor: context.cardColor, blurRadius: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(ic_diyBorder, height: 210)
                .visible(widget.isEven == true),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: context.width() * 0.5,
                    height: 100,
                    color: primaryColor),
                Container(
                  margin: EdgeInsets.all(12),
                  height: 190,
                  width: context.width() * 0.45,
                  decoration: boxDecorationWithShadowWidget(
                      border: Border.all(color: Colors.white, width: 2)),
                  child: commonCacheImageWidget(
                      widget.featureData!.image.validate(),
                      fit: BoxFit.cover),
                ),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 40)
                    .visible(widget.featureData!.postType == postVideoType),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: boxDecorationWithRoundedCornersWidget(
                        backgroundColor: context.cardColor.withOpacity(0.5)),
                    child: bookMarkComponent(widget.featureData!, context),
                  ),
                ),
              ],
            ).visible(widget.isEven != true),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.featureData!.postTitle!,
                    style: boldTextStyle(size: 18),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                8.height,
                Text(parseHtmlString(widget.featureData!.postContent!),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: secondaryTextStyle()),
                12.height,
                Row(
                  children: [
                    Icon(Icons.add,
                        size: 12, color: textSecondaryColor.withOpacity(0.6)),
                    4.width,
                    Text("Explore",
                        style: secondaryTextStyle(
                            color: textSecondaryColor.withOpacity(0.6))),
                  ],
                )
              ],
            ).paddingOnly(right: 8, left: 8).expand(),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: context.width() * 0.5,
                    height: 100,
                    color: primaryColor),
                Container(
                  margin: EdgeInsets.all(12),
                  height: 190,
                  width: context.width() * 0.45,
                  decoration: boxDecorationWithShadowWidget(
                      border: Border.all(color: Colors.white, width: 2)),
                  child: commonCacheImageWidget(
                      widget.featureData!.image.validate(),
                      fit: BoxFit.cover),
                ),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 40)
                    .visible(widget.featureData!.postType == postVideoType),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: boxDecorationWithRoundedCornersWidget(
                        backgroundColor: context.cardColor.withOpacity(0.5)),
                    child: bookMarkComponent(widget.featureData!, context),
                  ),
                ),
              ],
            ).visible(widget.isEven == true),
            Image.asset(ic_diyBorder, height: 210)
                .visible(widget.isEven != true),
          ],
        ),
      ),
    );
  }
}
