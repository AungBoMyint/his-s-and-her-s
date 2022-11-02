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
import '../../screen/Fitness/FitnessDetailScreen.dart';
import '../VideoPlayDialog.dart';

class FitnessFeatureComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;
  final bool? isSlider;
  final Function? onCall;

  FitnessFeatureComponent(this.featureData, {this.isSlider, this.onCall});

  @override
  _FitnessFeatureComponentState createState() =>
      _FitnessFeatureComponentState();
}

class _FitnessFeatureComponentState extends State<FitnessFeatureComponent> {
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
            : FitnessDetailScreen(postId: widget.featureData!.iD)
                .launch(context);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          commonCacheImageWidget(widget.featureData!.image.toString(),
              height: context.height() * 0.4,
              fit: BoxFit.fill,
              width: context.width()),
          Container(
            decoration: boxDecorationWithShadowWidget(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter)),
            width: context.width(),
          ),
          Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
              .center()
              .visible(widget.featureData!.postType == postVideoType),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              margin: EdgeInsets.all(8),
              width: widget.isSlider == true
                  ? context.width() * 0.58
                  : (context.width() - 40) / 2,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(MaterialCommunityIcons.timer_outline,
                                  size: 14, color: Colors.white)
                              .paddingRight(4),
                          Text(widget.featureData!.humanTimeDiff!,
                                  style:
                                      secondaryTextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1)
                              .expand(),
                        ],
                      ).expand(),
                      8.width,
                      Container(
                          padding: EdgeInsets.all(2),
                          decoration: boxDecorationWithRoundedCornersWidget(
                              backgroundColor:
                                  context.cardColor.withOpacity(0.5)),
                          child:
                              bookMarkComponent(widget.featureData!, context)),
                    ],
                  ),
                  Text(widget.featureData!.postTitle!,
                      style: boldTextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "by" +
                              ' ' +
                              widget.featureData!.postAuthorName
                                  .validate()
                                  .capitalizeFirstLetter(),
                          style: secondaryTextStyle(color: Colors.white60)),
                      Icon(AntDesign.rightcircleo, color: Colors.white60)
                          .onTap(() {
                        widget.onCall!();
                      })
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
