import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/Finance/FinanceDetailScreen.dart';
import '../../utils/Extensions/Commons.dart';
import '../AppWidget.dart';

class FinanceBlogItemWidget extends StatefulWidget {
  static String tag = '/FitnessBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;

  FinanceBlogItemWidget(this.mPost, {this.onCall});

  @override
  FinanceBlogItemWidgetState createState() => FinanceBlogItemWidgetState();
}

class FinanceBlogItemWidgetState extends State<FinanceBlogItemWidget> {
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
            : FinanceDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          commonCacheImageWidget(widget.mPost.image.validate(),
              height: 300, width: context.width() * 0.8, fit: BoxFit.cover),
          Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
              .visible(widget.mPost.postType == postVideoType),
          Positioned(
            bottom: 10,
            left: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: context.cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(MaterialCommunityIcons.timer_outline,
                          size: 14, color: textSecondaryColorGlobal),
                      4.width,
                      Text(widget.mPost.humanTimeDiff!,
                              style: secondaryTextStyle())
                          .expand(),
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: boxDecorationWithRoundedCornersWidget(
                            backgroundColor:
                                context.cardColor.withOpacity(0.5)),
                        child: bookMarkComponent(widget.mPost, context),
                      ),
                    ],
                  ),
                  Text(parseHtmlString(widget.mPost.postTitle.validate()),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: boldTextStyle()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
