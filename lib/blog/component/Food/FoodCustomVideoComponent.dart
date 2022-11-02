import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

class FoodCustomVideoComponent extends StatefulWidget {
  static String tag = '/FoodCustomVideoComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  FoodCustomVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  FoodCustomVideoComponentState createState() =>
      FoodCustomVideoComponentState();
}

class FoodCustomVideoComponentState extends State<FoodCustomVideoComponent> {
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
    var width = widget.isSlider == true
        ? context.width() * 0.8
        : (context.width() - 40) / 2;
    double mHeight = widget.isSlider == true ? 230 : 230;
    return GestureDetector(
      onTap: () {
        widget.onCall!();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          commonCacheImageWidget(widget.mPost.image.validate(),
              width: width, height: mHeight, fit: BoxFit.cover),
          Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
          4.height,
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: primaryColor.withOpacity(0.2)),
              width: width,
              child: Column(
                children: [
                  Text(parseHtmlString(widget.mPost.postTitle.validate()),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: boldTextStyle(color: Colors.white)),
                  4.height,
                  Text(parseHtmlString(widget.mPost.postContent.validate()),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: secondaryTextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
