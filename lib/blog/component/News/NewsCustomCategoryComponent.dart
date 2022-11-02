import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/CategoryResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/SubCategoryScreen.dart';

class NewsCustomCategoryComponent extends StatefulWidget {
  static String tag = '/DiyCustomCategoryComponent';
  final CategoryResponse mPost;
  final bool? isSlider;

  NewsCustomCategoryComponent(this.mPost, {this.isSlider = false});

  @override
  NewsCustomCategoryComponentState createState() =>
      NewsCustomCategoryComponentState();
}

class NewsCustomCategoryComponentState
    extends State<NewsCustomCategoryComponent> {
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          commonCacheImageWidget(widget.mPost.image.validate(),
                  height: widget.isSlider == false ? 90 : 120,
                  width: widget.isSlider == false
                      ? (context.width() - 40) / 4
                      : 120,
                  fit: BoxFit.cover)
              .cornerRadiusWithClipRRect(16),
          Container(
            height: widget.isSlider == false ? 80 : 100,
            width: widget.isSlider == false
                ? (context.width() - 40) / 4
                : context.width() * 0.3,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 8, right: 8),
            decoration: boxDecorationWithShadowWidget(
                backgroundColor: context.cardColor,
                blurRadius: 5,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            child: Text(widget.mPost.catName.validate(),
                style: primaryTextStyle(),
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
