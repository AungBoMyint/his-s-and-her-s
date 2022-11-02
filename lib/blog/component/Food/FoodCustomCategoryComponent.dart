import 'package:flutter/material.dart';
import '../../model/CategoryResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/SubCategoryScreen.dart';

class FoodCustomCategoryComponent extends StatefulWidget {
  static String tag = '/FoodCustomCategoryComponent';
  final CategoryResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  FoodCustomCategoryComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  FoodCustomCategoryComponentState createState() =>
      FoodCustomCategoryComponentState();
}

class FoodCustomCategoryComponentState
    extends State<FoodCustomCategoryComponent> {
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
      child: Column(
        children: [
          widget.mPost.image != null
              ? commonCacheImageWidget(widget.mPost.image.validate(),
                  height: 150,
                  width: widget.isSlider == false
                      ? context.width() / 2 - 24
                      : context.width() / 2,
                  fit: BoxFit.cover)
              : Image.asset(ic_placeHolder,
                  height: 150,
                  fit: BoxFit.cover,
                  width: widget.isSlider == false
                      ? context.width() / 2 - 24
                      : context.width() / 2),
          Text(parseHtmlString(widget.mPost.name),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: primaryTextStyle()),
        ],
      ),
    );
  }
}
