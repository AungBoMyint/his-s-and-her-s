import 'package:flutter/material.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/Finance/FinanceDetailScreen.dart';

class FinanceSuggestForYouComponent extends StatefulWidget {
  static String tag = '/FitnessSuggestForYouComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;

  FinanceSuggestForYouComponent(this.mPost, {this.onCall});

  @override
  FinanceSuggestForYouComponentState createState() =>
      FinanceSuggestForYouComponentState();
}

class FinanceSuggestForYouComponentState
    extends State<FinanceSuggestForYouComponent> {
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
      child: SizedBox(
        width: context.width() * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonCacheImageWidget(widget.mPost.image.toString(),
                fit: BoxFit.cover, height: 150, width: context.width() * 0.4),
            4.height,
            Text(widget.mPost.postTitle.validate(),
                style: primaryTextStyle(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            8.height,
            Text(widget.mPost.humanTimeDiff!, style: secondaryTextStyle()),
          ],
        ).paddingRight(8),
      ),
    );
  }
}
