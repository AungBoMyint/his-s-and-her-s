import 'package:flutter/material.dart';
import '../../model/CategoryResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/SubCategoryScreen.dart';

class LifeStyleCustomCategoryComponent extends StatefulWidget {
  static String tag = '/LifeStyleCustomCategoryComponent';
  final CategoryResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  LifeStyleCustomCategoryComponent(this.mPost,
      {this.onCall, this.isSlider = false});

  @override
  LifeStyleCustomCategoryComponentState createState() =>
      LifeStyleCustomCategoryComponentState();
}

class LifeStyleCustomCategoryComponentState
    extends State<LifeStyleCustomCategoryComponent> {
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
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            widget.mPost.image != null
                ? commonCacheImageWidget(widget.mPost.image.validate(),
                        height: 110,
                        width: (context.width() - 48) / 3,
                        fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(16)
                : Image.asset(ic_placeHolder,
                        height: 110,
                        width: (context.width() - 48) / 3,
                        fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(16),
            8.width,
            Container(
                height: 110,
                width: (context.width() - 48) / 3,
                alignment: Alignment.center,
                decoration: boxDecorationWithShadowWidget(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    borderRadius: radius()),
                child: Text(widget.mPost.catName.validate(),
                    style: boldTextStyle(color: Colors.white, size: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)),
          ],
        ));
  }
}
