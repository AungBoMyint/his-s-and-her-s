import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/Default/DefaultDetailScreen.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../utils/Extensions/context_extensions.dart';

import '../AppWidget.dart';
import '../VideoPlayDialog.dart';

class DefaultFeaturedComponent extends StatefulWidget {
  static String tag = '/DefaultFeaturedComponent';
  final DefaultPostResponse mPost;

  DefaultFeaturedComponent(this.mPost);

  @override
  DefaultFeaturedComponentState createState() =>
      DefaultFeaturedComponentState();
}

class DefaultFeaturedComponentState extends State<DefaultFeaturedComponent> {
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
    var width = context.width() * 0.8;
    return SizedBox(
      width: width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          widget.mPost.postType == postVideoType
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      children: [
                        commonCacheImageWidget(widget.mPost.image.validate(),
                                width: width, height: 250, fit: BoxFit.fill)
                            .cornerRadiusWithClipRRect(16),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: boxDecorationWithRoundedCornersWidget(
                                borderRadius: radiusWidget(10),
                                backgroundColor: context.cardColor),
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(8),
                            child: bookMarkComponent(widget.mPost, context),
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.play_circle_outline,
                            color: Colors.white, size: 50)
                        .center(),
                    Container(
                      width: width,
                      height: 250,
                      decoration: boxDecorationWithRoundedCornersWidget(
                          borderRadius: radius(16),
                          backgroundColor: Colors.black45),
                    )
                  ],
                )
              : Stack(
                  children: [
                    commonCacheImageWidget(widget.mPost.image.validate(),
                            width: width, height: 250, fit: BoxFit.fill)
                        .cornerRadiusWithClipRRect(16),
                    Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: boxDecorationWithRoundedCornersWidget(
                              backgroundColor: context.cardColor,
                              borderRadius: radiusWidget(10)),
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.all(8),
                          child: bookMarkComponent(widget.mPost, context),
                        )),
                  ],
                ),
          10.width,
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(10),
            decoration: boxDecorationWithRoundedCornersWidget(
                borderRadius: radiusWidget(16),
                backgroundColor: context.cardColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                2.height,
                Text(parseHtmlString(widget.mPost.postTitle.validate()),
                    maxLines: 2,
                    style: boldTextStyle(),
                    overflow: TextOverflow.ellipsis),
                6.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: secondaryTextStyle(size: 12),
                        children: [
                          WidgetSpan(
                            child: Icon(
                                    MaterialCommunityIcons
                                        .clock_time_three_outline,
                                    size: 14,
                                    color: textSecondaryColorGlobal)
                                .paddingRight(4),
                          ),
                          TextSpan(text: widget.mPost.humanTimeDiff.validate()),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: secondaryTextStyle(size: 12),
                        children: [
                          WidgetSpan(
                              child: Icon(FontAwesome.commenting_o,
                                      size: 14, color: textSecondaryColorGlobal)
                                  .paddingRight(4)),
                          TextSpan(text: widget.mPost.noOfComments.validate()),
                        ],
                      ),
                    ).visible(widget.mPost.noOfComments != "0"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ).paddingOnly(right: 8),
    ).onTap(() {
      widget.mPost.postType == postVideoType
          ? VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!)
              .launch(context)
          : DefaultDetailScreen(postId: widget.mPost.iD).launch(context);
    });
  }
}
