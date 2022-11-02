import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/Default/DefaultDetailScreen.dart';

class DefaultBlogItemWidget extends StatefulWidget {
  static String tag = '/DefaultBlogItemWidget';
  final DefaultPostResponse mPost;

  DefaultBlogItemWidget(this.mPost);

  @override
  DefaultBlogItemWidgetState createState() => DefaultBlogItemWidgetState();
}

class DefaultBlogItemWidgetState extends State<DefaultBlogItemWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //setDynamicStatusBarColor();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double imgHeight = 110;
    double imgWidth = 120;
    return GestureDetector(
      onTap: () {
        widget.mPost.postType == postVideoType
            ? VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!)
                .launch(context)
            : DefaultDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.mPost.postType == postVideoType
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    commonCacheImageWidget(widget.mPost.image.validate(),
                            width: imgWidth,
                            height: imgHeight,
                            fit: BoxFit.cover)
                        .cornerRadiusWithClipRRect(16),
                    Container(
                      width: imgWidth,
                      height: imgHeight,
                      decoration: boxDecorationWithRoundedCornersWidget(
                          borderRadius: radius(16),
                          backgroundColor: Colors.black26),
                    ),
                    Icon(Icons.play_circle_outline,
                            color: Colors.white, size: 40)
                        .center(),
                  ],
                )
              : commonCacheImageWidget(widget.mPost.image.validate(),
                      width: imgWidth, height: imgHeight, fit: BoxFit.cover)
                  .cornerRadiusWithClipRRect(16),
          10.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              2.height,
              Text(parseHtmlString(widget.mPost.postTitle.validate()),
                  maxLines: 2,
                  style: boldTextStyle(size: 18),
                  overflow: TextOverflow.ellipsis),
              4.height,
              Text(parseHtmlString(widget.mPost.postContent.validate()),
                  maxLines: 1,
                  style: secondaryTextStyle(),
                  overflow: TextOverflow.ellipsis),
              14.height,
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
                                .paddingRight(4)),
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
          ).expand(),
        ],
      ).paddingOnly(bottom: 16),
    );
  }
}
