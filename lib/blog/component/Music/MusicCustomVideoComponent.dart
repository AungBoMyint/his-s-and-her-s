import 'package:flutter/material.dart';
import '../../utils/AppColor.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

class MusicCustomVideoComponent extends StatefulWidget {
  static String tag = '/MusicCustomVideoComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  MusicCustomVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  MusicCustomVideoComponentState createState() =>
      MusicCustomVideoComponentState();
}

class MusicCustomVideoComponentState extends State<MusicCustomVideoComponent> {
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
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 210,
          width: widget.isSlider == true
              ? context.width() / 2
              : (context.width() - 40) / 2,
          decoration: boxDecorationWithShadowWidget(
              border:
                  Border.all(width: 0.5, color: primaryColor.withOpacity(0.2)),
              backgroundColor: context.cardColor,
              blurRadius: 5,
              borderRadius: radius()),
        ),
        Positioned(
          top: -30,
          left: 8,
          right: 8,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  widget.mPost.image != null
                      ? commonCacheImageWidget(widget.mPost.image.validate(),
                              height: 200,
                              width: widget.isSlider == true
                                  ? context.width() / 2
                                  : (context.width() - 40) / 2,
                              fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(16)
                      : Image.asset(ic_placeHolder,
                              height: 200,
                              width: widget.isSlider == true
                                  ? context.width() / 2
                                  : (context.width() - 40) / 2,
                              fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(16),
                  Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                      .center(),
                ],
              ),
              Text(widget.mPost.postTitle.validate(),
                      style: primaryTextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)
                  .paddingOnly(bottom: 16, top: 8),
            ],
          ),
        ),
      ],
    ).paddingOnly(top: 30, bottom: 8);
  }
}
