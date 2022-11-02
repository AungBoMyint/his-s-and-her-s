import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../utils/AppImages.dart';

class LifeStyleVideoComponent extends StatefulWidget {
  static String tag = '/LifeStyleVideoSliderComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  LifeStyleVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  LifeStyleVideoComponentState createState() => LifeStyleVideoComponentState();
}

class LifeStyleVideoComponentState extends State<LifeStyleVideoComponent> {
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
              height: 240,
              width: context.width() * 0.7,
              decoration: boxDecorationWithShadowWidget(
                  border: Border.all(width: 1),
                  backgroundColor: context.cardColor,
                  blurRadius: 5,
                  borderRadius: radius()),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      widget.mPost.image != null
                          ? commonCacheImageWidget(
                                  widget.mPost.image.validate(),
                                  height: 150,
                                  width: context.width() * 0.7,
                                  fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16)
                          : Image.asset(ic_placeHolder,
                                  height: 150,
                                  width: context.width() * 0.7,
                                  fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16),
                      Icon(Icons.play_circle_outline,
                              color: Colors.white, size: 50)
                          .center(),
                    ],
                  ),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.mPost.postTitle.validate(),
                          style: boldTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Text(parseHtmlString(widget.mPost.postContent.validate()),
                          style: secondaryTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ).paddingAll(8).expand(),
                ],
              ),
            )
          : Container(
              height: 225,
              width: context.width() / 2 - 20,
              decoration: boxDecorationWithShadowWidget(
                  border: Border.all(width: 1),
                  backgroundColor: context.cardColor,
                  blurRadius: 5,
                  borderRadius: radius()),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      widget.mPost.image != null
                          ? commonCacheImageWidget(
                                  widget.mPost.image.validate(),
                                  height: 140,
                                  width: context.width() / 2 - 20,
                                  fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16)
                          : Image.asset(ic_placeHolder,
                                  height: 140,
                                  width: context.width() / 2 - 20,
                                  fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16),
                      Icon(Icons.play_circle_outline,
                              color: Colors.white, size: 50)
                          .center(),
                    ],
                  ),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.mPost.postTitle.validate(),
                          style: boldTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Text(parseHtmlString(widget.mPost.postContent.validate()),
                          style: secondaryTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ).paddingAll(8).expand(),
                ],
              ),
            ),
    );
  }
}
