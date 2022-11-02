import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/AppWidget.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/Music/MusicDetailScreen.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../VideoPlayDialog.dart';

class MusicFeatureComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;
  final bool? isSlider;

  MusicFeatureComponent(this.featureData, {this.isSlider});

  @override
  _MusicFeatureComponentState createState() => _MusicFeatureComponentState();
}

class _MusicFeatureComponentState extends State<MusicFeatureComponent> {
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
              : MusicDetailScreen(postId: widget.featureData!.iD)
                  .launch(context);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            commonCacheImageWidget(widget.featureData!.image.validate(),
                    height: 300,
                    width: context.width() * 0.8,
                    fit: BoxFit.cover)
                .cornerRadiusWithClipRRect(16),
            Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                .visible(widget.featureData!.postType == postVideoType),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithShadowWidget(
                    backgroundColor: context.cardColor, borderRadius: radius()),
                width: context.width() * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(MaterialCommunityIcons.timer_outline,
                            size: 16, color: textSecondaryColorGlobal),
                        4.width,
                        Text(widget.featureData!.humanTimeDiff!,
                                style: secondaryTextStyle())
                            .expand(),
                        bookMarkComponent(widget.featureData!, context)
                      ],
                    ),
                    6.height,
                    Text(
                        parseHtmlString(
                            widget.featureData!.postTitle.validate()),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: boldTextStyle()),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
