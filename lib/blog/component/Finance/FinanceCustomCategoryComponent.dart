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

class FinanceCustomCategoryComponent extends StatefulWidget {
  static String tag = '/FitnessCustomCategoryComponent';
  final CategoryResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  FinanceCustomCategoryComponent(this.mPost,
      {this.onCall, this.isSlider = false});

  @override
  FinanceCustomCategoryComponentState createState() =>
      FinanceCustomCategoryComponentState();
}

class FinanceCustomCategoryComponentState
    extends State<FinanceCustomCategoryComponent> {
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
    double mHeight = widget.isSlider == true
        ? (context.width() - 48) / 3
        : (context.width() - 48) / 3;
    double mWidth = widget.isSlider == true
        ? (context.width() - 48) / 3
        : (context.width() - 48) / 3;
    return GestureDetector(
      onTap: () {
        SubCategoryScreen(
                catName: widget.mPost.catName, catId: widget.mPost.catID)
            .launch(context);
      },
      child: Container(
        width: mWidth,
        padding: EdgeInsets.all(8),
        decoration: boxDecorationWithShadowWidget(
            backgroundColor: context.cardColor, border: Border.all(width: 0.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            commonCacheImageWidget(widget.mPost.image.validate(),
                height: mHeight, width: mWidth, fit: BoxFit.cover),
            4.width,
            Text(parseHtmlString(widget.mPost.name),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: primaryTextStyle()),
          ],
        ),
      ),
    );
  }
}
