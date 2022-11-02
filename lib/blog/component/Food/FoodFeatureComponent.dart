import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:share_plus/share_plus.dart';
import '../../component/AppWidget.dart';
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

import '../../screen/Food/FoodDetailScreen.dart';
import '../VideoPlayDialog.dart';

class FoodFeatureComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;
  final bool? isSlider;

  FoodFeatureComponent(this.featureData, {this.isSlider});

  @override
  _FoodFeatureComponentState createState() => _FoodFeatureComponentState();
}

class _FoodFeatureComponentState extends State<FoodFeatureComponent> {
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
            : FoodDetailScreen(postId: widget.featureData!.iD).launch(context);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 300,
            width: widget.isSlider == true
                ? context.width() * 0.8
                : (context.width() - 40) / 2,
            child: commonCacheImageWidget(widget.featureData!.image.toString(),
                fit: BoxFit.cover),
          ),
          Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
              .visible(widget.featureData!.postType == postVideoType),
          Positioned(
            bottom: 0,
            child: Container(
              margin: EdgeInsets.all(8),
              width: widget.isSlider == true
                  ? context.width() * 0.76
                  : (context.width() - 60) / 2,
              padding: EdgeInsets.all(8),
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: context.cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.featureData!.postTitle!,
                      style: boldTextStyle(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(MaterialCommunityIcons.timer_outline,
                                      size: 14, color: textSecondaryColorGlobal)
                                  .paddingRight(4),
                              Text(widget.featureData!.humanTimeDiff!,
                                      style: secondaryTextStyle(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2)
                                  .expand(),
                            ],
                          ),
                          Text(
                              'By  ' +
                                  widget.featureData!.postAuthorName
                                      .validate()
                                      .capitalizeFirstLetter(),
                              style: secondaryTextStyle(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                        ],
                      ).expand(),
                      Icon(Icons.share, size: 18, color: context.iconColor)
                          .onTap(() {
                        Share.share(
                            'Share ${widget.featureData!.postTitle} app\n$playStoreBaseURL${widget.featureData!.shareUrl}');
                      }),
                      6.width,
                      bookMarkComponent(widget.featureData!, context)
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
