import 'package:flutter/material.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/Fitness/FitnessDetailScreen.dart';
import '../../utils/Extensions/Colors.dart';
import '../../utils/Extensions/Commons.dart';

class FitnessSuggestForYouComponent extends StatefulWidget {
  static String tag = '/FitnessSuggestForYouComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isEven;
  final bool? isConfig;

  FitnessSuggestForYouComponent(this.mPost,
      {this.onCall, this.isEven, this.isConfig = false});

  @override
  FitnessSuggestForYouComponentState createState() =>
      FitnessSuggestForYouComponentState();
}

class FitnessSuggestForYouComponentState
    extends State<FitnessSuggestForYouComponent> {
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
        widget.mPost.postType == postVideoType
            ? VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!)
                .launch(context)
            : FitnessDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Container(
        width: context.width() * 0.9,
        height: 170,
        child: widget.isEven == true
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.mPost.postTitle!,
                          style: boldTextStyle(size: 18),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      8.height,
                      Text(parseHtmlString(widget.mPost.postContent!),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: secondaryTextStyle()),
                      12.height,
                      Row(
                        children: [
                          Icon(Icons.add,
                              size: 12,
                              color: textSecondaryColor.withOpacity(0.6)),
                          4.width,
                          Text("Explore",
                              style: secondaryTextStyle(
                                  color: textSecondaryColor.withOpacity(0.6))),
                        ],
                      )
                    ],
                  ).paddingOnly(right: 8, left: 16).expand(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 170,
                        width: 170,
                        decoration: boxDecorationWithShadowWidget(
                            border: Border.all(color: Colors.white, width: 2)),
                        child: commonCacheImageWidget(widget.mPost.image!,
                            fit: BoxFit.cover),
                      ),
                      Icon(Icons.play_circle_outline,
                              color: Colors.white, size: 40)
                          .visible(widget.mPost.postType == postVideoType),
                    ],
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 170,
                        width: 170,
                        decoration: boxDecorationWithShadowWidget(
                            border: Border.all(color: Colors.white, width: 2)),
                        child: commonCacheImageWidget(widget.mPost.image!,
                            fit: BoxFit.cover),
                      ),
                      Icon(Icons.play_circle_outline,
                              color: Colors.white, size: 40)
                          .visible(widget.mPost.postType == postVideoType),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.mPost.postTitle!,
                          style: boldTextStyle(size: 18),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      8.height,
                      Text(parseHtmlString(widget.mPost.postContent!),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: secondaryTextStyle()),
                      12.height,
                      Row(
                        children: [
                          Icon(Icons.add,
                              size: 12,
                              color: textSecondaryColor.withOpacity(0.6)),
                          4.width,
                          Text("Explore",
                              style: secondaryTextStyle(
                                  color: textSecondaryColor.withOpacity(0.6))),
                        ],
                      )
                    ],
                  ).paddingOnly(right: 8, left: 10).expand(),
                ],
              ),
      ).paddingBottom(widget.isConfig == true ? 8 : 0),
    );
  }
}
