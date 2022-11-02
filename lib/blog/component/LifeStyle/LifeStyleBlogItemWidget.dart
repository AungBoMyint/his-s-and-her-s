import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/LifeStyle/LifeStyleDetailScreen.dart';
import '../AppWidget.dart';

class LifeStyleBlogItemWidget extends StatefulWidget {
  static String tag = '/LifeStyleBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;
  final bool? isSlider;
  final bool? isConfig;

  LifeStyleBlogItemWidget(this.mPost,
      {this.onCall, this.isSlider = false, this.isConfig = false});

  @override
  LifeStyleBlogItemWidgetState createState() => LifeStyleBlogItemWidgetState();
}

class LifeStyleBlogItemWidgetState extends State<LifeStyleBlogItemWidget> {
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
        widget.mPost.postType == postVideoType
            ? VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!)
                .launch(context)
            : LifeStyleDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: boxDecorationRoundedWithShadowWidget(16,
                blurRadius: 5, backgroundColor: context.cardColor),
            width: widget.isSlider == true
                ? context.width() * 0.5
                : (context.width() - 40) / 2,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    commonCacheImageWidget(widget.mPost.image.toString(),
                            fit: BoxFit.cover,
                            height: 160,
                            width: context.width() * 0.5)
                        .cornerRadiusWithClipRRect(16),
                    Icon(Icons.play_circle_outline,
                            color: Colors.white, size: 50)
                        .visible(widget.mPost.postType == postVideoType),
                  ],
                ),
                8.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    4.height,
                    Text(widget.mPost.postTitle.validate(),
                        style: boldTextStyle(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    4.height,
                    Row(
                      children: [
                        Text(widget.mPost.humanTimeDiff!,
                                style: secondaryTextStyle())
                            .expand(),
                        bookMarkComponent(widget.mPost, context)
                      ],
                    ),
                  ],
                ).paddingAll(6),
                8.height
              ],
            ),
          ),
          Positioned(bottom: 5, child: Icon(AntDesign.rightcircle))
        ],
      ),
    );
  }
}
