import 'package:flutter/material.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/News/NewsDetailScreen.dart';
import '../AppWidget.dart';

class NewsBlogItemWidget extends StatefulWidget {
  static String tag = '/DiyBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;

  NewsBlogItemWidget(this.mPost, {this.onCall});

  @override
  NewsBlogItemWidgetState createState() => NewsBlogItemWidgetState();
}

class NewsBlogItemWidgetState extends State<NewsBlogItemWidget> {
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
            : NewsDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Container(
        width: context.width() * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                commonCacheImageWidget(widget.mPost.image.toString(),
                        fit: BoxFit.cover,
                        height: 180,
                        width: context.width() * 0.7)
                    .cornerRadiusWithClipRRect(16),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                    .visible(widget.mPost.postType == postVideoType),
                Positioned(
                    top: 8,
                    right: 8,
                    child: bookMarkComponent(widget.mPost, context)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.height,
                Text(widget.mPost.humanTimeDiff!, style: secondaryTextStyle()),
                Text(widget.mPost.postTitle.validate(),
                    style: primaryTextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ).paddingLeft(4),
          ],
        ),
      ),
    );
  }
}
