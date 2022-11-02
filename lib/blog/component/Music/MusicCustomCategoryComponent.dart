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

class MusicCustomCategoryComponent extends StatefulWidget {
  static String tag = '/MusicCustomCategoryComponent';
  final CategoryResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  MusicCustomCategoryComponent(this.mPost,
      {this.onCall, this.isSlider = false});

  @override
  MusicCustomCategoryComponentState createState() =>
      MusicCustomCategoryComponentState();
}

class MusicCustomCategoryComponentState
    extends State<MusicCustomCategoryComponent> {
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
      child: widget.isSlider == false
          ? Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 80,
                  width: context.width() / 2 - 24,
                  decoration: boxDecorationWithShadowWidget(
                      backgroundColor: context.cardColor,
                      blurRadius: 5,
                      borderRadius: radius()),
                ),
                Positioned(
                  top: -20,
                  left: 8,
                  right: 8,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      widget.mPost.image != null &&
                              widget.mPost.image!.isNotEmpty
                          ? commonCacheImageWidget(
                                  widget.mPost.image.validate(),
                                  height: 85,
                                  width: 85,
                                  fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16)
                          : Image.asset(ic_placeHolder,
                                  height: 85, width: 85, fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16),
                      8.width,
                      Text(
                        widget.mPost.catName.validate(),
                        style: primaryTextStyle(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).paddingTop(16).expand(),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(top: 20, bottom: 8)
          : Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 110,
                  width: 130,
                  decoration: boxDecorationWithShadowWidget(
                      backgroundColor: context.cardColor,
                      blurRadius: 5,
                      borderRadius: radius()),
                ),
                Positioned(
                  top: -20,
                  left: 8,
                  right: 8,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      widget.mPost.image != null
                          ? commonCacheImageWidget(
                                  widget.mPost.image.validate(),
                                  height: 85,
                                  width: 85,
                                  fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16)
                          : Image.asset(ic_placeHolder,
                                  height: 85, width: 85, fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(16),
                      6.height,
                      Text(
                        widget.mPost.catName.validate(),
                        style: primaryTextStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(top: 20, right: 8, bottom: 8),
    );
  }
}
