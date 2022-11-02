import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../screen/LifeStyle/LifeStyleDetailScreen.dart';
import '../../utils/Extensions/text_styles.dart';
import '../VideoPlayDialog.dart';

class LifeStyleSuggestForYouComponent extends StatefulWidget {
  final DefaultPostResponse? blogResponse;

  LifeStyleSuggestForYouComponent(this.blogResponse);

  @override
  _LifeStyleSuggestForYouComponentState createState() =>
      _LifeStyleSuggestForYouComponentState();
}

class _LifeStyleSuggestForYouComponentState
    extends State<LifeStyleSuggestForYouComponent> {
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
    var width = context.width() * 0.5;
    var height = context.height() * 0.27;
    return GestureDetector(
      onTap: () {
        widget.blogResponse!.postType == postVideoType
            ? VideoPlayDialog(widget.blogResponse!.videoType!,
                    widget.blogResponse!.videoUrl!)
                .launch(context)
            : LifeStyleDetailScreen(postId: widget.blogResponse!.iD)
                .launch(context);
      },
      child: SizedBox(
        height: context.height() * 0.47,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: width,
                height: height,
                margin: EdgeInsets.only(top: 16, right: 10),
                decoration: boxDecorationWithShadowWidget(
                    border: Border.all(width: 4, color: primaryColor),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    commonCacheImageWidget(
                            widget.blogResponse!.image.toString(),
                            fit: BoxFit.cover,
                            height: height,
                            width: width)
                        .cornerRadiusWithClipRRectOnly(
                            bottomLeft: 16, topRight: 16),
                    Icon(Icons.play_circle_outline,
                            color: Colors.white, size: 50)
                        .center()
                        .visible(
                            widget.blogResponse!.postType == postVideoType),
                    Container(
                      width: width,
                      height: height,
                      decoration: boxDecorationWithRoundedCornersWidget(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          backgroundColor: Colors.black45),
                    ).visible(widget.blogResponse!.postType == postVideoType),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                8.height,
                Text(widget.blogResponse!.postTitle.validate(),
                    style: boldTextStyle(color: Colors.black), maxLines: 2),
                8.height,
                Text(
                    parseHtmlString(widget.blogResponse!.postContent)
                        .validate(),
                    style: primaryTextStyle(color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
