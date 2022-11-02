import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/AppWidget.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/Fashion/FashionDetailScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../VideoPlayDialog.dart';

class FashionFeatureComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;

  FashionFeatureComponent(this.featureData);

  @override
  _FashionFeatureComponentState createState() =>
      _FashionFeatureComponentState();
}

class _FashionFeatureComponentState extends State<FashionFeatureComponent> {
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
        widget.featureData!.postType == postVideoType
            ? VideoPlayDialog(widget.featureData!.videoType!,
                    widget.featureData!.videoUrl!)
                .launch(context)
            : FashionDetailScreen(postId: widget.featureData!.iD)
                .launch(context);
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration:
                boxDecorationWithShadowWidget(backgroundColor: primaryColor),
            child: Container(
              width: context.width() * 0.5,
              height: 275,
              padding: EdgeInsets.all(8),
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: context.cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  4.height,
                  Text(widget.featureData!.postTitle!,
                      style: boldTextStyle(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                  4.height,
                  Row(
                    children: [
                      Icon(MaterialCommunityIcons.timer_outline,
                              size: 14, color: textSecondaryColorGlobal)
                          .paddingRight(4),
                      Text(widget.featureData!.humanTimeDiff!,
                              style: secondaryTextStyle())
                          .expand(),
                      bookMarkComponent(widget.featureData!, context)
                    ],
                  )
                ],
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              commonCacheImageWidget(widget.featureData!.image.toString(),
                  fit: BoxFit.cover, height: 200, width: 165),
              Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                  .visible(widget.featureData!.postType == postVideoType),
            ],
          ),
        ],
      ),
    );
  }
}
