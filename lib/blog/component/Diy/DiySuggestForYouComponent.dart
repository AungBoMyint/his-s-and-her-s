import 'package:flutter/material.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/Diy/DiyDetailScreen.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../utils/Extensions/Colors.dart';
import '../../utils/Extensions/Commons.dart';

class DiySuggestForYouComponent extends StatefulWidget {
  static String tag = '/FitnessSuggestForYouComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;

  DiySuggestForYouComponent(this.mPost, {this.onCall});

  @override
  DiySuggestForYouComponentState createState() =>
      DiySuggestForYouComponentState();
}

class DiySuggestForYouComponentState extends State<DiySuggestForYouComponent> {
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
            : DiyDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        decoration: boxDecorationWithShadowWidget(
            backgroundColor: context.cardColor, blurRadius: 10),
        child: Row(
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
                    maxLines: 4,
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
            ).paddingOnly(right: 8, left: 16).expand(),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: context.width() * 0.5,
                  height: context.height() * 0.34,
                  padding: EdgeInsets.all(4),
                  decoration: boxDecorationWithShadowWidget(
                      border: Border.all(color: Colors.white, width: 2)),
                  child: commonCacheImageWidget(widget.mPost.image!,
                      fit: BoxFit.cover),
                ),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 40)
                    .visible(widget.mPost.postType == postVideoType),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
