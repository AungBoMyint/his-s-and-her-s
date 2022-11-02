import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../utils/AppImages.dart';

class NewsVideoComponent extends StatefulWidget {
  static String tag = '/NewsVideoComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  NewsVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  NewsVideoComponentState createState() => NewsVideoComponentState();
}

class NewsVideoComponentState extends State<NewsVideoComponent> {
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
        widget.onCall!();
      },
      child: widget.isSlider == true
          ? Container(
              height: 200,
              margin: EdgeInsets.only(bottom: 8),
              width: context.width() * 0.8,
              child: Stack(
                children: [
                  widget.mPost.image != null
                      ? commonCacheImageWidget(widget.mPost.image.validate(),
                              height: 200,
                              width: context.width() * 0.8,
                              fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(16)
                      : Image.asset(ic_placeHolder,
                              height: 200,
                              width: context.width() * 0.8,
                              fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(16),
                  Container(
                    height: 200,
                    width: context.width() * 0.8,
                    decoration: boxDecorationWithShadowWidget(
                        backgroundColor: Colors.black12,
                        blurRadius: 5,
                        borderRadius: radius()),
                  ),
                  Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                      .center(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(widget.mPost.postTitle.validate(),
                          style: boldTextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Text(parseHtmlString(widget.mPost.postContent.validate()),
                          style: secondaryTextStyle(color: Colors.white70),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ).paddingAll(8),
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.only(bottom: 8),
              height: 120,
              width: context.width(),
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: context.cardColor,
                  blurRadius: 5,
                  borderRadius: radius()),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.mPost.postTitle.validate(),
                          style: boldTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Text(parseHtmlString(widget.mPost.postContent.validate()),
                          style: secondaryTextStyle(
                              color: textSecondaryColorGlobal),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ).paddingAll(8).expand(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      widget.mPost.image != null
                          ? commonCacheImageWidget(
                                  widget.mPost.image.validate(),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16)
                          : Image.asset(ic_placeHolder,
                                  height: 120, width: 120, fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16),
                      8.width,
                      Container(
                        height: 120,
                        width: 120,
                        decoration: boxDecorationWithShadowWidget(
                            backgroundColor: Colors.black12,
                            blurRadius: 5,
                            borderRadius: radius()),
                      ),
                      Icon(Icons.play_circle_outline,
                          color: Colors.white, size: 50),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
