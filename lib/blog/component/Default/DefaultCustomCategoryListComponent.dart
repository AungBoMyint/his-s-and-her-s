import 'package:flutter/material.dart';
import '../../model/CategoryResponse.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import '../../screen/SubCategoryScreen.dart';

class DefaultCustomCategoryListComponent extends StatefulWidget {
  static String tag = '/DefaultCustomCategoryListComponent';
  final CategoryResponse mPost;
  final Function? onCall;

  DefaultCustomCategoryListComponent(this.mPost, {this.onCall});

  @override
  DefaultCustomCategoryListComponentState createState() =>
      DefaultCustomCategoryListComponentState();
}

class DefaultCustomCategoryListComponentState
    extends State<DefaultCustomCategoryListComponent> {
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
      child: Container(
        height: 130,
        decoration: boxDecorationWithShadowWidget(
            borderRadius: radius(16),
            border: Border.all(color: primaryColor.withOpacity(0.2)),
            backgroundColor: context.cardColor),
        child: Column(
          children: [
            4.height,
            Container(
              width: context.width() * .26,
              height: 80,
              margin: EdgeInsets.all(6),
              child: widget.mPost.image != null
                  ? CircleAvatar(
                      backgroundColor: context.cardColor,
                      backgroundImage:
                          NetworkImage(widget.mPost.image.validate()))
                  : CircleAvatar(
                      backgroundColor: context.cardColor,
                      backgroundImage: AssetImage(ic_placeHolder)),
            ),
            4.height,
            Container(
              width: context.width() * 0.20,
              child: Text(parseHtmlString(widget.mPost.name),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: primaryTextStyle()),
            ),
          ],
        ),
      ).paddingOnly(left: 12),
    );
  }
}
