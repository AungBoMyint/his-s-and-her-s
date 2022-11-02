import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

class FinanceVideoComponent extends StatefulWidget {
  static String tag = '/FitnessVideoComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  FinanceVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  FinanceVideoComponentState createState() => FinanceVideoComponentState();
}

class FinanceVideoComponentState extends State<FinanceVideoComponent> {
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
        padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
        width: widget.isSlider == true
            ? context.width() * 0.7
            : (context.width() - 40) / 2,
        margin: EdgeInsets.only(bottom: 8, top: 8),
        decoration: boxDecorationWithShadowWidget(
            backgroundColor: context.cardColor, border: Border.all(width: 0.2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                commonCacheImageWidget(widget.mPost.image.validate(),
                    height: 180,
                    width: widget.isSlider == true
                        ? context.width() * 0.7
                        : context.width() * 0.52 - 28,
                    fit: BoxFit.cover),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
              ],
            ),
            8.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.mPost.postTitle.validate(),
                    style: boldTextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                Text(parseHtmlString(widget.mPost.postContent.validate()),
                    style: secondaryTextStyle(color: textSecondaryColorGlobal),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
