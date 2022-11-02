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
import '../../screen/Fitness/FitnessDetailScreen.dart';

class FitnessBlogItemWidget extends StatefulWidget {
  static String tag = '/FitnessBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;

  FitnessBlogItemWidget(this.mPost, {this.onCall});

  @override
  FitnessBlogItemWidgetState createState() => FitnessBlogItemWidgetState();
}

class FitnessBlogItemWidgetState extends State<FitnessBlogItemWidget> {
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
        decoration: boxDecorationWithShadowWidget(
            border: Border.all(width: 0.1), backgroundColor: context.cardColor),
        width: context.width() * 0.55,
        height: 300,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: primaryColor.withOpacity(0.5)),
              width: context.width() * 0.45,
              height: 250,
              padding: EdgeInsets.only(bottom: 8, left: 10, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.mPost.postTitle.validate(),
                      style: primaryTextStyle(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  4.height,
                  Container(
                      height: 5,
                      width: context.width() * 0.1,
                      color: Colors.black)
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  commonCacheImageWidget(widget.mPost.image.toString(),
                      fit: BoxFit.fill,
                      width: context.width() * 0.47,
                      height: 220),
                  Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                      .visible(widget.mPost.postType == postVideoType),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
