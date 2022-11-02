import 'package:flutter/material.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/Music/MusicDetailScreen.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../AppWidget.dart';

class MusicBlogItemWidget extends StatefulWidget {
  static String tag = '/MusicBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;

  MusicBlogItemWidget(this.mPost, {this.onCall});

  @override
  MusicBlogItemWidgetState createState() => MusicBlogItemWidgetState();
}

class MusicBlogItemWidgetState extends State<MusicBlogItemWidget> {
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
            : MusicDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: widget.mPost.postType == postVideoType
          ? Container(
              decoration: boxDecorationRoundedWithShadowWidget(16,
                  blurRadius: 5, backgroundColor: context.cardColor),
              width: context.width() * 0.5,
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      commonCacheImageWidget(widget.mPost.image.toString(),
                              fit: BoxFit.cover,
                              height: 180,
                              width: context.width() * 0.7)
                          .cornerRadiusWithClipRRect(16),
                      Icon(Icons.play_circle_outline,
                          color: Colors.white, size: 50),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.height,
                      Text(widget.mPost.postTitle.validate(),
                          style: primaryTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      8.height,
                      Row(
                        children: [
                          Text(widget.mPost.humanTimeDiff!,
                                  style: secondaryTextStyle())
                              .expand(),
                          Align(
                              alignment: Alignment.topRight,
                              child: bookMarkComponent(widget.mPost, context)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          : Container(
              decoration: boxDecorationRoundedWithShadowWidget(16,
                  blurRadius: 5, backgroundColor: context.cardColor),
              width: context.width() * 0.5,
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  commonCacheImageWidget(widget.mPost.image.toString(),
                          fit: BoxFit.cover,
                          height: 180,
                          width: context.width() * 0.7)
                      .cornerRadiusWithClipRRect(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.height,
                      Text(widget.mPost.postTitle.validate(),
                          style: primaryTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      8.height,
                      Row(
                        children: [
                          Text(widget.mPost.humanTimeDiff!,
                                  style: secondaryTextStyle())
                              .expand(),
                          Align(
                              alignment: Alignment.topRight,
                              child: bookMarkComponent(widget.mPost, context)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
