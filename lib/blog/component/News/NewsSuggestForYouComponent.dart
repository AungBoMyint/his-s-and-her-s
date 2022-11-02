import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/News/NewsDetailScreen.dart';
import '../VideoPlayDialog.dart';

class NewsSuggestForYouComponent extends StatefulWidget {
  final DefaultPostResponse? blogResponse;

  NewsSuggestForYouComponent(this.blogResponse);

  @override
  _NewsSuggestForYouComponentState createState() =>
      _NewsSuggestForYouComponentState();
}

class _NewsSuggestForYouComponentState
    extends State<NewsSuggestForYouComponent> {
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
            : NewsDetailScreen(postId: widget.blogResponse!.iD).launch(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.blogResponse!.postTitle.validate(),
                  style: primaryTextStyle(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              8.height,
              Row(
                children: [
                  Text(widget.blogResponse!.humanTimeDiff!,
                          style: secondaryTextStyle())
                      .expand(),
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
          8.width,
          widget.blogResponse!.postType == postVideoType
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    commonCacheImageWidget(
                            widget.blogResponse!.image.toString(),
                            fit: BoxFit.cover,
                            height: 100,
                            width: context.width() * 0.3)
                        .cornerRadiusWithClipRRect(16),
                    Icon(Icons.play_circle_outline,
                        color: Colors.white, size: 50),
                  ],
                )
              : commonCacheImageWidget(widget.blogResponse!.image.toString(),
                      fit: BoxFit.cover,
                      height: 100,
                      width: context.width() * 0.3)
                  .cornerRadiusWithClipRRect(16),
        ],
      ).paddingBottom(12),
    );
  }
}
