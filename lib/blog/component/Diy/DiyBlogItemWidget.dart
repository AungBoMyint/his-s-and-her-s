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
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/Diy/DiyDetailScreen.dart';
import '../../utils/Extensions/Commons.dart';
import '../AppWidget.dart';

class DiyBlogItemWidget extends StatefulWidget {
  static String tag = '/DiyBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;

  DiyBlogItemWidget(this.mPost, {this.onCall});

  @override
  DiyBlogItemWidgetState createState() => DiyBlogItemWidgetState();
}

class DiyBlogItemWidgetState extends State<DiyBlogItemWidget> {
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
        child: SizedBox(
          width: context.width() * 0.5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              commonCacheImageWidget(widget.mPost.image.validate(),
                  height: 250, width: context.width() * 0.5, fit: BoxFit.cover),
              Positioned(
                bottom: 10,
                right: 8,
                left: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 4,
                        width: 40,
                        margin: EdgeInsets.only(bottom: 8),
                        color: primaryColor),
                    Text(parseHtmlString(widget.mPost.postTitle.validate()),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: boldTextStyle(color: Colors.white)),
                    6.height,
                    Row(
                      children: [
                        Icon(MaterialCommunityIcons.timer_outline,
                            size: 14, color: Colors.white),
                        4.width,
                        Text(widget.mPost.humanTimeDiff!,
                            style: secondaryTextStyle(color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
              Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                  .visible(widget.mPost.postType == postVideoType),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCornersWidget(
                      backgroundColor: context.cardColor.withOpacity(0.5)),
                  child: bookMarkComponent(widget.mPost, context),
                ),
              ),
            ],
          ),
        ));
  }
}
