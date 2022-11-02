import 'package:flutter/material.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/Sport/SportDetailScreen.dart';
import '../../utils/AppColor.dart';
import '../AppWidget.dart';

class SportSuggestForYouComponent extends StatefulWidget {
  static String tag = '/FitnessSuggestForYouComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;

  SportSuggestForYouComponent(this.mPost, {this.onCall});

  @override
  SportSuggestForYouComponentState createState() =>
      SportSuggestForYouComponentState();
}

class SportSuggestForYouComponentState
    extends State<SportSuggestForYouComponent> {
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
    var width = (context.width() - 40) / 2;
    var height = 250;
    return GestureDetector(
      onTap: () {
        widget.mPost.postType == postVideoType
            ? VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!)
                .launch(context)
            : SportDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Container(
        width: width,
        child: Stack(
          children: [
            Container(
                height: 200,
                color: primaryColor.withOpacity(0.6),
                width: width),
            Stack(
              alignment: Alignment.center,
              children: [
                commonCacheImageWidget(widget.mPost.image.toString(),
                    fit: BoxFit.cover, height: height.toDouble(), width: width),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                    .visible(widget.mPost.postType == postVideoType),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: width,
                    decoration: boxDecorationWithShadowWidget(
                        backgroundColor: primaryColor.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.mPost.postTitle.validate(),
                            style: primaryTextStyle(color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        8.height,
                        Text(widget.mPost.humanTimeDiff!,
                            style: secondaryTextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: boxDecorationWithRoundedCornersWidget(
                        backgroundColor: context.cardColor.withOpacity(0.5)),
                    child: bookMarkComponent(widget.mPost, context),
                  ),
                ),
              ],
            ).paddingOnly(left: 8, right: 8, top: 8, bottom: 10),
          ],
        ),
      ),
    );
  }
}
