import 'package:flutter/material.dart';
import '../../component/AppWidget.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/Fashion/FashionDetailScreen.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

import '../VideoPlayDialog.dart';

class FashionRecentComponent extends StatefulWidget {
  final DefaultPostResponse? recentData;
  final bool? isSlider;

  FashionRecentComponent(this.recentData, {this.isSlider});

  @override
  _FashionRecentComponentState createState() => _FashionRecentComponentState();
}

class _FashionRecentComponentState extends State<FashionRecentComponent> {
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
        widget.recentData!.postType == postVideoType
            ? VideoPlayDialog(
                    widget.recentData!.videoType!, widget.recentData!.videoUrl!)
                .launch(context)
            : FashionDetailScreen(postId: widget.recentData!.iD)
                .launch(context);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              Image.asset(ic_fashionRecent,
                  height: 265,
                  fit: BoxFit.fill,
                  width: widget.isSlider == true
                      ? context.width() / 2
                      : (context.width() - 40) / 2),
              Container(
                width: widget.isSlider == true
                    ? context.width() / 2
                    : (context.width() - 40) / 2,
                padding: EdgeInsets.all(8),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    commonCacheImageWidget(widget.recentData!.image.toString(),
                        fit: BoxFit.cover, height: 250, width: 200),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: boxDecorationWithShadowWidget(
                          backgroundColor: context.cardColor),
                      padding: EdgeInsets.fromLTRB(10, 8, 8, 4),
                      child: Text(widget.recentData!.postTitle.validate(),
                          style: primaryTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: boxDecorationWithShadowWidget(),
                        child: bookMarkComponent(widget.recentData!, context),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
              .visible(widget.recentData!.postType == postVideoType),
        ],
      ),
    );
  }
}
