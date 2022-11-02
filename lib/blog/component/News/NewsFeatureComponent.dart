import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../screen/News/NewsDetailScreen.dart';
import '../AppWidget.dart';
import '../VideoPlayDialog.dart';

class NewsFeaturedComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;
  final bool? isSlider;

  NewsFeaturedComponent(this.featureData, {this.isSlider});

  @override
  NewsFeaturedComponentState createState() => NewsFeaturedComponentState();
}

class NewsFeaturedComponentState extends State<NewsFeaturedComponent> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.featureData!.postType == postVideoType
            ? VideoPlayDialog(widget.featureData!.videoType!,
                    widget.featureData!.videoUrl!)
                .launch(context)
            : NewsDetailScreen(postId: widget.featureData!.iD).launch(context);
      },
      child: Container(
        decoration: boxDecorationWithShadowWidget(
            backgroundColor: context.cardColor,
            borderRadius: radius(16),
            blurRadius: 5),
        width:
            widget.isSlider == true ? context.width() * 0.7 : context.width(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.featureData!.postType == postVideoType
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      commonCacheImageWidget(
                        widget.featureData!.image.toString(),
                        fit: BoxFit.cover,
                        width: widget.isSlider == true
                            ? context.width() * 0.7
                            : context.width(),
                        height: 200,
                      ).cornerRadiusWithClipRRectOnly(
                          topLeft: 16, topRight: 16),
                      Icon(Icons.play_circle_outline,
                              color: Colors.white, size: 50)
                          .center(),
                    ],
                  )
                : commonCacheImageWidget(
                    widget.featureData!.image.toString(),
                    fit: BoxFit.cover,
                    width: widget.isSlider == true
                        ? context.width() * 0.7
                        : context.width(),
                    height: 200,
                  ).cornerRadiusWithClipRRectOnly(topLeft: 16, topRight: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                4.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.featureData!.humanTimeDiff!,
                        style: secondaryTextStyle()),
                    bookMarkComponent(widget.featureData!, context),
                  ],
                ),
                Text(widget.featureData!.postTitle!,
                    style: boldTextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                4.height,
              ],
            ).paddingAll(8),
          ],
        ),
      ),
    );
  }
}
