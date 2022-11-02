import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/Travel/TravelDetailScreen.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../VideoPlayDialog.dart';

class TravelSuggestForYouComponent extends StatefulWidget {
  final DefaultPostResponse? blogResponse;

  TravelSuggestForYouComponent(this.blogResponse);

  @override
  _TravelSuggestForYouComponentState createState() =>
      _TravelSuggestForYouComponentState();
}

class _TravelSuggestForYouComponentState
    extends State<TravelSuggestForYouComponent> {
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
              : TravelDetailScreen(postId: widget.blogResponse!.iD)
                  .launch(context);
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                commonCacheImageWidget(
                        widget.blogResponse!.image.toString().validate(),
                        fit: BoxFit.fill,
                        height: 200,
                        width: context.width())
                    .cornerRadiusWithClipRRect(16),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                    .visible(widget.blogResponse!.postType == postVideoType),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.blogResponse!.postTitle.validate(),
                    style: primaryTextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                4.height,
                Row(
                  children: [
                    Text(widget.blogResponse!.humanTimeDiff!,
                            style: secondaryTextStyle())
                        .expand(),
                    8.width,
                    Row(
                      children: [
                        Icon(FontAwesome.commenting_o, size: 18),
                        2.width,
                        Text(
                            widget.blogResponse!.noOfComments!
                                .validate()
                                .toString(),
                            style: primaryTextStyle()),
                      ],
                    )
                  ],
                )
              ],
            ).paddingAll(4),
          ],
        ));
  }
}
