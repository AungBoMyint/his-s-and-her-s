import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';

import '../../model/DefaultPostResponse.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

class TravelCustomVideoComponent extends StatefulWidget {
  static String tag = '/TravelCustomVideoComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  TravelCustomVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  TravelCustomVideoComponentState createState() =>
      TravelCustomVideoComponentState();
}

class TravelCustomVideoComponentState
    extends State<TravelCustomVideoComponent> {
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
    return widget.isSlider == true
        ? Stack(
            alignment: Alignment.center,
            children: [
              commonCacheImageWidget(widget.mPost.image.validate(),
                      height: 300,
                      width: context.width() * 0.6,
                      fit: BoxFit.cover)
                  .cornerRadiusWithClipRRect(16),
              Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: boxDecorationRoundedWithShadowWidget(16,
                          backgroundColor: primaryColor.withOpacity(0.2)),
                      child: Text(
                          parseHtmlString(widget.mPost.postTitle.validate()),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: boldTextStyle(color: Colors.white)))),
            ],
          )
        : Container(
            padding: EdgeInsets.all(8),
            decoration: boxDecorationRoundedWithShadowWidget(16,
                backgroundColor: context.cardColor, blurRadius: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    commonCacheImageWidget(widget.mPost.image.validate(),
                            width: context.width() * 0.4,
                            height: 120,
                            fit: BoxFit.fill)
                        .cornerRadiusWithClipRRect(16),
                    Container(
                      width: context.width() * 0.4,
                      height: 120,
                      decoration: boxDecorationWithRoundedCornersWidget(
                          borderRadius: radius(16),
                          backgroundColor: Colors.black12),
                    ),
                    Icon(Icons.play_circle_outline,
                            color: Colors.white, size: 50)
                        .center(),
                  ],
                ),
                10.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    2.height,
                    Text(parseHtmlString(widget.mPost.postTitle.validate()),
                        maxLines: 2,
                        style: boldTextStyle(size: 18),
                        overflow: TextOverflow.ellipsis),
                    4.height,
                    Text(parseHtmlString(widget.mPost.postContent.validate()),
                        maxLines: 2,
                        style: secondaryTextStyle(),
                        overflow: TextOverflow.ellipsis),
                    30.height,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RichText(
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
                            TextSpan(
                                text: widget.mPost.humanTimeDiff.validate()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).expand(),
              ],
            ),
          );
  }
}
