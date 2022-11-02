import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

class DiyVideoComponent extends StatefulWidget {
  static String tag = '/FitnessVideoComponent';

  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  DiyVideoComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  DiyVideoComponentState createState() => DiyVideoComponentState();
}

class DiyVideoComponentState extends State<DiyVideoComponent> {
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          commonCacheImageWidget(widget.mPost.image.toString(),
                  fit: BoxFit.cover,
                  height: widget.isSlider == true ? 280 : 250,
                  width: widget.isSlider == true
                      ? context.width() * 0.7
                      : (context.width() - 40) * 0.5)
              .cornerRadiusWithClipRRect(16),
          Container(
            padding: EdgeInsets.all(8),
            height: widget.isSlider == true ? 280 : 250,
            width: widget.isSlider == true
                ? context.width() * 0.7
                : (context.width() - 40) * 0.5,
            alignment: Alignment.bottomCenter,
            decoration: boxDecorationWithShadowWidget(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black
                  ],
                ),
                borderRadius: radius(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.play_circle_outline, color: Colors.white, size: 30),
                8.height,
                Text(widget.mPost.postTitle.validate(),
                    style: primaryTextStyle(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                8.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('By ' + widget.mPost.postAuthorName!,
                            style: secondaryTextStyle(color: Colors.white))
                        .expand(),
                    Row(
                      children: [
                        Icon(Entypo.dot_single, color: Colors.white),
                        Text(
                                widget.mPost.humanTimeDiff! +
                                    widget.mPost.humanTimeDiff!,
                                style: secondaryTextStyle(color: Colors.white),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis)
                            .expand(),
                      ],
                    ).expand(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
