import 'package:flutter/material.dart';
import '../../model/CategoryResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/SubCategoryScreen.dart';

class DefaultCustomCategorySliderComponent extends StatefulWidget {
  static String tag = '/DefaultCustomCategorySliderComponent';
  final CategoryResponse mPost;

  DefaultCustomCategorySliderComponent(this.mPost);

  @override
  DefaultCustomCategorySliderComponentState createState() =>
      DefaultCustomCategorySliderComponentState();
}

class DefaultCustomCategorySliderComponentState
    extends State<DefaultCustomCategorySliderComponent> {
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
    var width = context.width() * 0.37;
    double height = 190;

    return GestureDetector(
      onTap: () {
        SubCategoryScreen(
                catName: widget.mPost.catName, catId: widget.mPost.catID)
            .launch(context);
      },
      child: Container(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Stack(
              children: [
                commonCacheImageWidget(
                  widget.mPost.image.validate(),
                  width: width,
                  height: height,
                  fit: BoxFit.fill,
                ).cornerRadiusWithClipRRect(16),
                Container(
                  width: width,
                  height: height,
                  decoration: boxDecorationWithRoundedCornersWidget(
                    borderRadius: radius(16),
                    backgroundColor: Colors.black45,
                  ),
                )
              ],
            ),
            8.height,
            Text(parseHtmlString(widget.mPost.catName!),
                    style: boldTextStyle(color: Colors.white, size: 18),
                    maxLines: 1,
                    overflow: TextOverflow.visible)
                .paddingAll(10)
          ],
        ),
      ),
    ).paddingOnly(right: 8);
  }
}
