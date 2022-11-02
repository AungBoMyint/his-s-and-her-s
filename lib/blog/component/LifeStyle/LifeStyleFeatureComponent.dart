import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/AppWidget.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import 'package:share_plus/share_plus.dart';
import '../../screen/LifeStyle/LifeStyleDetailScreen.dart';
import '../VideoPlayDialog.dart';

class LifeStyleFeatureComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;
  final bool? isSlider;

  LifeStyleFeatureComponent(this.featureData, {this.isSlider});

  @override
  _LifeStyleFeatureComponentState createState() =>
      _LifeStyleFeatureComponentState();
}

class _LifeStyleFeatureComponentState extends State<LifeStyleFeatureComponent> {
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
              : LifeStyleDetailScreen(postId: widget.featureData!.iD)
                  .launch(context);
        },
        child: Stack(
          children: [
            Container(
              height: 300,
              width: context.width() * 0.8,
              child: commonCacheImageWidget(
                      widget.featureData!.image.toString(),
                      fit: BoxFit.cover)
                  .cornerRadiusWithClipRRect(16),
            ),
            Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                .visible(widget.featureData!.postType == postVideoType),
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: glassBoxDecoration(),
                child: bookMarkComponent(widget.featureData!, context),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 16,
              right: 16,
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                width: context.width() * 0.65,
                padding: EdgeInsets.all(8),
                decoration: glassBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.featureData!.postTitle!,
                        style: boldTextStyle(color: Colors.black),
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
                            Text(
                                'By ' +
                                    widget.featureData!.postAuthorName
                                        .validate(),
                                style: primaryTextStyle(color: Colors.black)),
                            4.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(MaterialCommunityIcons.timer_outline,
                                        size: 14, color: Colors.black)
                                    .paddingRight(4),
                                Text(widget.featureData!.humanTimeDiff!,
                                    style: secondaryTextStyle(
                                        color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox().expand(),
                        IconButton(
                          onPressed: () {
                            Share.share(
                                'Share ${widget.featureData!.postTitle} app\n$playStoreBaseURL${widget.featureData!.shareUrl}');
                          },
                          icon: Icon(Icons.share,
                              size: 18, color: context.iconColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
