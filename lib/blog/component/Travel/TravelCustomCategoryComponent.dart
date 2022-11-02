import 'package:flutter/material.dart';
import '../../model/CategoryResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/SubCategoryScreen.dart';

class TravelCustomCategoryComponent extends StatefulWidget {
  static String tag = '/TravelCustomCategoryComponent';
  final CategoryResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  TravelCustomCategoryComponent(this.mPost,
      {this.onCall, this.isSlider = false});

  @override
  TravelCustomCategoryComponentState createState() =>
      TravelCustomCategoryComponentState();
}

class TravelCustomCategoryComponentState
    extends State<TravelCustomCategoryComponent> {
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
        SubCategoryScreen(
                catName: widget.mPost.catName, catId: widget.mPost.catID)
            .launch(context);
      },
      child: widget.isSlider == true
          ? Column(
              children: [
                commonCacheImageWidget(widget.mPost.image.validate(),
                        height: 90,
                        width: context.width() / 4 - 10,
                        fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(16),
                4.height,
                Text(parseHtmlString(widget.mPost.name),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: primaryTextStyle()),
              ],
            ).paddingRight(4)
          : Container(
              width: context.width() / 2 - 20,
              padding: EdgeInsets.all(8),
              decoration: boxDecorationWithShadowWidget(
                  backgroundColor: context.cardColor,
                  blurRadius: 5,
                  borderRadius: radius()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.mPost.image != null
                      ? commonCacheImageWidget(widget.mPost.image.validate(),
                              height: 85, width: 85, fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(16)
                      : Image.asset(ic_placeHolder,
                              height: 85, width: 85, fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(16),
                  8.width,
                  Text(parseHtmlString(widget.mPost.name),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: primaryTextStyle())
                      .expand(),
                ],
              ),
            ),
    );
  }
}
