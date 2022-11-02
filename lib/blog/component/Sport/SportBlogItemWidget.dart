import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/Sport/SportDetailScreen.dart';
import '../../utils/Extensions/Constants.dart';
import '../AppWidget.dart';

class SportBlogItemWidget extends StatefulWidget {
  static String tag = '/FitnessBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;

  SportBlogItemWidget(this.mPost, {this.onCall});

  @override
  SportBlogItemWidgetState createState() => SportBlogItemWidgetState();
}

class SportBlogItemWidgetState extends State<SportBlogItemWidget> {
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
    var width = context.width() * 0.55;
    return GestureDetector(
      onTap: () {
        widget.mPost.postType == postVideoType
            ? VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!)
                .launch(context)
            : SportDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Container(
        height: 330,
        width: width,
        child: Stack(
          children: [
            Container(height: 200, color: primaryColor.withOpacity(0.6)),
            Container(
              decoration: boxDecorationRoundedWithShadowWidget(0,
                  blurRadius: 5, backgroundColor: context.cardColor),
              margin: EdgeInsets.all(14),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      commonCacheImageWidget(widget.mPost.image.toString(),
                          fit: BoxFit.cover, height: 200, width: width),
                      Icon(Icons.play_circle_outline,
                              color: Colors.white, size: 50)
                          .visible(widget.mPost.postType == postVideoType),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.mPost.postTitle!,
                          style: boldTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                      4.height,
                      Row(
                        children: [
                          Icon(MaterialCommunityIcons.timer_outline,
                                  size: 14, color: textSecondaryColorGlobal)
                              .paddingRight(4),
                          Text(widget.mPost.humanTimeDiff!,
                                  style: secondaryTextStyle())
                              .expand(),
                          bookMarkComponent(widget.mPost, context),
                        ],
                      ),
                    ],
                  ).paddingAll(10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
