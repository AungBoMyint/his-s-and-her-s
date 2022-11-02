import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/Travel/TravelDetailScreen.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../AppWidget.dart';
import '../VideoPlayDialog.dart';

class TravelFeaturedComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;
  final bool? isSlider;
  final bool? isCardConfig;

  TravelFeaturedComponent(this.featureData,
      {this.isSlider, this.isCardConfig = false});

  @override
  TravelFeaturedComponentState createState() => TravelFeaturedComponentState();
}

class TravelFeaturedComponentState extends State<TravelFeaturedComponent> {
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
            : TravelDetailScreen(postId: widget.featureData!.iD)
                .launch(context);
      },
      child: widget.featureData!.postType == postVideoType
          ? Stack(
              children: [
                Container(
                  decoration: boxDecorationWithShadowWidget(
                      backgroundColor: context.cardColor,
                      borderRadius: radius(16),
                      blurRadius: 5),
                  padding: EdgeInsets.all(10),
                  width: widget.isCardConfig == true
                      ? context.width()
                      : widget.isSlider == true
                          ? context.width() * 0.7
                          : context.width() * 0.52 - 28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          commonCacheImageWidget(
                            widget.featureData!.image.toString(),
                            fit: BoxFit.cover,
                            width: widget.isCardConfig == true
                                ? context.width()
                                : widget.isSlider == true
                                    ? context.width() * 0.7
                                    : context.width() * 0.52 - 28,
                            height: 200,
                          ).cornerRadiusWithClipRRect(16),
                          Icon(Icons.play_circle_outline,
                                  color: Colors.white, size: 50)
                              .center(),
                          Positioned(
                              right: 0,
                              top: 0,
                              child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: bookMarkComponent(
                                      widget.featureData!, context)))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.height,
                          Text(widget.featureData!.humanTimeDiff!,
                              style: secondaryTextStyle()),
                          Text(widget.featureData!.postTitle!,
                              style: boldTextStyle(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                          4.height,
                          Row(
                            children: [
                              Icon(FontAwesome.user_o,
                                  size: 14, color: textSecondaryColorGlobal),
                              Text(
                                  ' By ' +
                                      widget.featureData!.postAuthorName
                                          .validate()
                                          .capitalizeFirstLetter(),
                                  style: secondaryTextStyle()),
                            ],
                          )
                        ],
                      ).paddingLeft(4),
                    ],
                  ),
                ).paddingOnly(bottom: widget.isCardConfig == true ? 16 : 0),
              ],
            )
          : Container(
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: context.cardColor,
                  borderRadius: radius(16),
                  blurRadius: 5),
              padding: EdgeInsets.all(10),
              width: widget.isCardConfig == true
                  ? context.width()
                  : widget.isSlider == true
                      ? context.width() * 0.7
                      : context.width() * 0.52 - 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      commonCacheImageWidget(
                        widget.featureData!.image.toString(),
                        fit: BoxFit.cover,
                        width: widget.isCardConfig == true
                            ? context.width()
                            : widget.isSlider == true
                                ? context.width() * 0.7
                                : context.width() * 0.52 - 30,
                        height: 200,
                      ).cornerRadiusWithClipRRect(16),
                      Padding(
                          padding: EdgeInsets.all(12),
                          child:
                              bookMarkComponent(widget.featureData!, context))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.height,
                      Text(widget.featureData!.humanTimeDiff!,
                          style: secondaryTextStyle()),
                      Text(widget.featureData!.postTitle!,
                          style: boldTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                      4.height,
                      Row(
                        children: [
                          Icon(FontAwesome.user_o,
                              size: 14, color: textSecondaryColorGlobal),
                          Text(
                              ' By ' +
                                  widget.featureData!.postAuthorName
                                      .validate()
                                      .capitalizeFirstLetter(),
                              style: secondaryTextStyle()),
                        ],
                      )
                    ],
                  ).paddingLeft(4),
                ],
              ),
            ).paddingOnly(bottom: widget.isCardConfig == true ? 16 : 0),
    );
  }
}
