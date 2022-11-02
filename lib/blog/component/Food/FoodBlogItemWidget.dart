import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

class FoodBlogItemWidget extends StatefulWidget {
  static String tag = '/DefaultBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;

  FoodBlogItemWidget(this.mPost, {this.onCall});

  @override
  FoodBlogItemWidgetState createState() => FoodBlogItemWidgetState();
}

class FoodBlogItemWidgetState extends State<FoodBlogItemWidget> {
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
    double imgHeight = 110;
    double imgWidth = 120;
    return GestureDetector(
      onTap: () {
        if (widget.mPost.postType == postVideoType) {
          VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!)
              .launch(context);
        } else {
          widget.onCall!.call();
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.mPost.postType == postVideoType
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    commonCacheImageWidget(widget.mPost.image.validate(),
                        width: imgWidth, height: imgHeight, fit: BoxFit.cover),
                    Icon(Icons.play_circle_outline,
                            color: Colors.white, size: 50)
                        .center(),
                  ],
                )
              : commonCacheImageWidget(widget.mPost.image.validate(),
                  width: imgWidth, height: imgHeight, fit: BoxFit.cover),
          10.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(MaterialCommunityIcons.timer_outline,
                          size: 14, color: textPrimaryColorGlobal)
                      .paddingRight(2),
                  Text(widget.mPost.humanTimeDiff!,
                      style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                ],
              ),
              Text(parseHtmlString(widget.mPost.postTitle.validate()),
                  maxLines: 2,
                  style: boldTextStyle(size: 18),
                  overflow: TextOverflow.ellipsis),
            ],
          ).expand(),
        ],
      ).paddingOnly(bottom: 16),
    );
  }
}
