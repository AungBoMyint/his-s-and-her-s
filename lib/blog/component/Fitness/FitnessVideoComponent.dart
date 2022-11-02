import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../utils/AppImages.dart';

class FitnessVideoComponent extends StatefulWidget {
  static String tag = '/FitnessVideoComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  FitnessVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  FitnessVideoComponentState createState() => FitnessVideoComponentState();
}

class FitnessVideoComponentState extends State<FitnessVideoComponent> {
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
        widget.onCall!();
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.only(bottom: 8),
        width:
            widget.isSlider == true ? context.width() * 0.7 : context.width(),
        decoration: boxDecorationWithShadowWidget(
            backgroundColor: context.cardColor, blurRadius: 5),
        child: Stack(
          children: [
            widget.mPost.image != null
                ? commonCacheImageWidget(widget.mPost.image.validate(),
                    height: 200,
                    width: widget.isSlider == true
                        ? context.width() * 0.7
                        : context.width(),
                    fit: BoxFit.cover)
                : Image.asset(ic_placeHolder,
                        height: 200,
                        width: widget.isSlider == true
                            ? context.width() * 0.7
                            : context.width(),
                        fit: BoxFit.fill)
                    .cornerRadiusWithClipRRect(16),
            Container(
              height: 200,
              width: widget.isSlider == true
                  ? context.width() * 0.7
                  : context.width(),
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: Colors.black12, blurRadius: 5),
            ),
            Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                .center(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.mPost.postTitle.validate(),
                    style: boldTextStyle(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                Text(parseHtmlString(widget.mPost.postContent.validate()),
                    style: secondaryTextStyle(color: Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ).paddingAll(8),
          ],
        ),
      ),
    );
  }
}
