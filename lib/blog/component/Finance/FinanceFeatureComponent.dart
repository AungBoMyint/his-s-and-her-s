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
import '../../screen/Finance/FinanceDetailScreen.dart';
import '../VideoPlayDialog.dart';

class FinanceFeatureComponent extends StatefulWidget {
  final DefaultPostResponse? featureData;
  final bool? isSlider;

  FinanceFeatureComponent(this.featureData, {this.isSlider});

  @override
  _FinanceFeatureComponentState createState() =>
      _FinanceFeatureComponentState();
}

class _FinanceFeatureComponentState extends State<FinanceFeatureComponent> {
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
            : FinanceDetailScreen(postId: widget.featureData!.iD)
                .launch(context);
      },
      child: Container(
        height: widget.isSlider == true ? 290 : 250,
        width: widget.isSlider == true
            ? context.width() * 0.64
            : (context.width() - 40) / 2,
        decoration: boxDecorationWithShadowWidget(
            backgroundColor: context.cardColor, border: Border.all(width: 0.2)),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                commonCacheImageWidget(
                  widget.featureData!.image.toString(),
                  fit: BoxFit.cover,
                  height: widget.isSlider == true ? 200 : 160,
                  width: widget.isSlider == true
                      ? context.width() * 0.64
                      : context.width() * 0.52 - 28,
                ),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                    .visible(widget.featureData!.postType == postVideoType),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: boxDecorationWithRoundedCornersWidget(
                          backgroundColor: context.cardColor.withOpacity(0.5)),
                      child: bookMarkComponent(widget.featureData!, context)),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(8),
              color: context.cardColor,
              width: widget.isSlider == true
                  ? context.width() * 0.58
                  : context.width() * 0.46 - 22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.featureData!.postTitle!,
                      style: boldTextStyle(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                  4.height,
                  Row(
                    children: [
                      Icon(Entypo.dot_single, size: 18),
                      Text(widget.featureData!.humanTimeDiff.validate(),
                          style: secondaryTextStyle()),
                    ],
                  )
                ],
              ),
            ).expand()
          ],
        ),
      ),
    );
  }
}
