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

class FashionCustomCategoryComponent extends StatefulWidget {
  static String tag = '/DefaultCustomCategoryListComponent';
  final CategoryResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  FashionCustomCategoryComponent(this.mPost,
      {this.onCall, this.isSlider = false});

  @override
  FashionCustomCategoryComponentState createState() =>
      FashionCustomCategoryComponentState();
}

class FashionCustomCategoryComponentState
    extends State<FashionCustomCategoryComponent> {
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
          catName: widget.mPost.catName,
          catId: widget.mPost.catID,
        ).launch(context);
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                  decoration: boxDecorationWithShadowWidget(
                    decorationImage: DecorationImage(
                        image: AssetImage("assets/frame03fill.png"),
                        fit: BoxFit.cover),
                  ),
                  padding: EdgeInsets.all(6),
                  child: commonCacheImageWidget(widget.mPost.image.validate(),
                      height: 140,
                      width: context.width() / 3 - 32,
                      fit: BoxFit.cover)),
              Positioned(
                bottom: -20,
                right: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: boxDecorationWithShadowWidget(
                      backgroundColor: context.cardColor, blurRadius: 5),
                  margin: EdgeInsets.only(bottom: 4, top: 4),
                  child: Text(
                    parseHtmlString(widget.mPost.name),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: primaryTextStyle(),
                  ),
                ),
              ),
            ],
          ),
          8.height,
        ],
      ),
    );
  }
}
