import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/string_extensions.dart';

import '../../utils/AppImages.dart';
import '../VideoPlayDialog.dart';

class SportVideoComponent extends StatefulWidget {
  static String tag = '/FitnessVideoComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  SportVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  SportVideoComponentState createState() => SportVideoComponentState();
}

class SportVideoComponentState extends State<SportVideoComponent> {
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
        VideoPlayDialog(
                widget.mPost.videoType.validate(), widget.mPost.videoUrl!)
            .launch(context);
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.only(bottom: 8),
        width: widget.isSlider == true
            ? context.width() * 0.7
            : (context.width() - 40) * 0.5,
        decoration: boxDecorationWithShadowWidget(
            backgroundColor: context.cardColor,
            blurRadius: 5,
            borderRadius: radius()),
        child: Stack(
          children: [
            widget.mPost.image != null
                ? commonCacheImageWidget(widget.mPost.image.validate(),
                        height: 200,
                        width: widget.isSlider == true
                            ? context.width() * 0.7
                            : context.width() * 52 - 28,
                        fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(16)
                : Image.asset(ic_placeHolder,
                        height: 200,
                        width: widget.isSlider == true
                            ? context.width() * 0.7
                            : context.width() * 52 - 28,
                        fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(16),
            Container(
              height: 200,
              width: widget.isSlider == true
                  ? context.width() * 0.7
                  : context.width() * 52 - 28,
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: Colors.black12,
                  blurRadius: 5,
                  borderRadius: radius()),
            ),
            Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                .center(),
          ],
        ),
      ),
    );
  }
}
