import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../utils/AppImages.dart';

class FashionCustomVideoComponent extends StatefulWidget {
  static String tag = '/FashionCustomVideoComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  FashionCustomVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  FashionCustomVideoComponentState createState() =>
      FashionCustomVideoComponentState();
}

class FashionCustomVideoComponentState
    extends State<FashionCustomVideoComponent> {
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
        ? context.width() * 0.75
        : (context.width() - 40) / 2;
    double mHeight = 200;
    return GestureDetector(
      onTap: () {
        widget.onCall!();
      },
      child: Container(
        decoration: boxDecorationWithShadowWidget(
            decorationImage: DecorationImage(
                image: AssetImage(ic_fashionVideo), fit: BoxFit.fill)),
        width: width,
        height: 270,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                commonCacheImageWidget(widget.mPost.image.validate(),
                    width: width, height: mHeight, fit: BoxFit.cover),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                    .center(),
              ],
            ).paddingOnly(right: 12, left: 12, top: 12),
            Text(widget.mPost.postTitle.validate(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: boldTextStyle(color: Colors.white))
                .paddingSymmetric(horizontal: 8, vertical: 6)
                .expand(),
          ],
        ),
      ),
    );
  }
}
