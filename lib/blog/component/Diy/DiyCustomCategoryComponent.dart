import 'package:flutter/material.dart';
import '../../model/CategoryResponse.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../screen/SubCategoryScreen.dart';

class DiyCustomCategoryComponent extends StatefulWidget {
  static String tag = '/FitnessCustomCategoryComponent';
  final CategoryResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  DiyCustomCategoryComponent(this.mPost, {this.onCall, this.isSlider = false});

  @override
  DiyCustomCategoryComponentState createState() =>
      DiyCustomCategoryComponentState();
}

class DiyCustomCategoryComponentState
    extends State<DiyCustomCategoryComponent> {
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
          height: 110,
          width: (context.width() - 48) / 3,
          alignment: Alignment.center,
          padding: EdgeInsets.all(4),
          decoration: boxDecorationWithShadowWidget(
            borderRadius: radius(55),
            gradient: LinearGradient(
              colors: [
                primaryColor.withOpacity(0.3),
                primaryColor,
              ],
            ),
          ),
          child: commonCacheImageWidget(widget.mPost.image.validate(),
                  height: 110,
                  width: (context.width() - 48) / 3,
                  fit: BoxFit.cover)
              .cornerRadiusWithClipRRect(55)),
    );
  }
}
