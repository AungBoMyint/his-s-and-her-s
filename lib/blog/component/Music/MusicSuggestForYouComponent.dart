import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/Music/MusicDetailScreen.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';
import '../VideoPlayDialog.dart';

class MusicSuggestForYouComponent extends StatefulWidget {
  final DefaultPostResponse? blogResponse;
  final bool? isEven;

  MusicSuggestForYouComponent(this.blogResponse, {this.isEven});

  @override
  _MusicSuggestForYouComponentState createState() =>
      _MusicSuggestForYouComponentState();
}

class _MusicSuggestForYouComponentState
    extends State<MusicSuggestForYouComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
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
        widget.blogResponse!.postType == postVideoType
            ? VideoPlayDialog(widget.blogResponse!.videoType!,
                    widget.blogResponse!.videoUrl!)
                .launch(context)
            : MusicDetailScreen(postId: widget.blogResponse!.iD)
                .launch(context);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 8),
        decoration: boxDecorationRoundedWithShadowWidget(16,
            backgroundColor: context.cardColor, blurRadius: 5),
        width: context.width(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                commonCacheImageWidget(widget.blogResponse!.image.toString(),
                        fit: BoxFit.cover,
                        height: 120,
                        width: context.width() * 0.3)
                    .cornerRadiusWithClipRRect(16),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                    .visible(widget.blogResponse!.postType == postVideoType),
              ],
            ).visible(widget.isEven != true),
            4.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.blogResponse!.postTitle.validate(),
                    style: primaryTextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                8.height,
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(MaterialCommunityIcons.timer_outline,
                            size: 14, color: textSecondaryColorGlobal),
                        2.width,
                        Text(widget.blogResponse!.humanTimeDiff!,
                            style: secondaryTextStyle()),
                      ],
                    ).expand(),
                    8.width,
                    Row(
                      children: [
                        Icon(FontAwesome.commenting_o,
                            size: 14, color: textSecondaryColorGlobal),
                        2.width,
                        Text(
                            widget.blogResponse!.noOfComments!
                                .validate()
                                .toString(),
                            style: secondaryTextStyle()),
                      ],
                    )
                  ],
                )
              ],
            ).paddingAll(4).expand(),
            Stack(
              alignment: Alignment.center,
              children: [
                commonCacheImageWidget(widget.blogResponse!.image.toString(),
                        fit: BoxFit.cover,
                        height: 120,
                        width: context.width() * 0.3)
                    .cornerRadiusWithClipRRect(16),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                    .visible(widget.blogResponse!.postType == postVideoType),
              ],
            ).visible(widget.isEven == true),
          ],
        ),
      ),
    );
  }
}
