import 'package:flutter/material.dart';
import '../../model/CategoryResponse.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/SubCategoryScreen.dart';

class FitnessCustomCategoryComponent extends StatefulWidget {
  static String tag = '/FitnessCustomCategoryComponent';
  final CategoryResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  FitnessCustomCategoryComponent(this.mPost,
      {this.onCall, this.isSlider = false});

  @override
  FitnessCustomCategoryComponentState createState() =>
      FitnessCustomCategoryComponentState();
}

class FitnessCustomCategoryComponentState
    extends State<FitnessCustomCategoryComponent> {
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
        height: 100,
        alignment: Alignment.center,
        width: (context.width() - 48) / 3,
        padding: EdgeInsets.all(8),
        decoration: boxDecorationWithShadowWidget(
          backgroundColor: context.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1.5, 0), // changes position of shadow
            ),
          ],
        ),
        child: Text(parseHtmlString(widget.mPost.name),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: boldTextStyle()),
      ),
    );
  }
}
