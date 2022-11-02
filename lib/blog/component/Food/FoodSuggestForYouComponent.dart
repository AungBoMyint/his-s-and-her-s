import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/Food/FoodDetailScreen.dart';
import '../../utils/Extensions/Constants.dart';
import '../VideoPlayDialog.dart';

class FoodSuggestForYouComponent extends StatefulWidget {
  final DefaultPostResponse? blogResponse;

  FoodSuggestForYouComponent(this.blogResponse);

  @override
  _FoodSuggestForYouComponentState createState() =>
      _FoodSuggestForYouComponentState();
}

class _FoodSuggestForYouComponentState
    extends State<FoodSuggestForYouComponent> {
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
            : FoodDetailScreen(postId: widget.blogResponse!.iD).launch(context);
      },
      child: Container(
        decoration:
            boxDecorationWithShadowWidget(backgroundColor: primaryColor),
        padding: EdgeInsets.all(4),
        child: Stack(
          alignment: Alignment.center,
          children: [
            commonCacheImageWidget(widget.blogResponse!.image.toString(),
                fit: BoxFit.cover, height: 280, width: context.width() * 0.6),
            Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                .visible(widget.blogResponse!.postType == postVideoType),
            Positioned(
              top: 10,
              left: 0,
              child: Container(
                decoration: boxDecorationWithShadowWidget(
                    backgroundColor: context.cardColor),
                margin: EdgeInsets.only(top: 20),
                width: context.width() * 0.5,
                padding: EdgeInsets.all(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(MaterialCommunityIcons.timer_outline,
                                size: 14, color: textSecondaryColorGlobal)
                            .paddingRight(4),
                        Text(widget.blogResponse!.humanTimeDiff!,
                            style: secondaryTextStyle()),
                      ],
                    ),
                    Text(widget.blogResponse!.postTitle.validate(),
                        style: boldTextStyle(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
