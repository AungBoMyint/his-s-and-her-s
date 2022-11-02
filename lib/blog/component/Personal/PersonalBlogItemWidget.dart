import 'package:flutter/material.dart';
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
import '../../screen/Personal/PersonalDetailScreen.dart';
import '../../utils/Extensions/Commons.dart';
import '../AppWidget.dart';

class PersonalBlogItemWidget extends StatefulWidget {
  static String tag = '/FitnessBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;

  PersonalBlogItemWidget(this.mPost, {this.onCall});

  @override
  PersonalBlogItemWidgetState createState() => PersonalBlogItemWidgetState();
}

class PersonalBlogItemWidgetState extends State<PersonalBlogItemWidget> {
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
        widget.mPost.postType == postVideoType ? VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!).launch(context) : PersonalDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Container(
        width: context.width() * 0.5,
        padding: EdgeInsets.only(top: 8,right: 8,left: 8),
        height: 300,
        decoration: boxDecorationWithShadowWidget(backgroundColor: context.cardColor, blurRadius: 5),
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    commonCacheImageWidget(widget.mPost.image.validate(), height: 220, width: context.width() * 0.45, fit: BoxFit.cover),
                    Icon(Icons.play_circle_outline, color: Colors.white, size: 50).visible(widget.mPost.postType == postVideoType),
                  ],
                ),
                8.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(parseHtmlString(widget.mPost.postTitle.validate()), maxLines: 2, overflow: TextOverflow.ellipsis, style: boldTextStyle()).paddingAll(4).expand(),
                    6.width,
                    bookMarkComponent(widget.mPost, context),
                  ],
                ),
              ],
            ).expand(),
            Container(alignment: Alignment.bottomCenter, height: 5, width: context.width() * 0.15, color: primaryColor),
          ],
        ),
      ),
    );
  }
}
