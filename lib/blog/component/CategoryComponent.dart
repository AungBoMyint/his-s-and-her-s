import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../main.dart';
import '../model/CategoryResponse.dart';
import '../screen/SubCategoryScreen.dart';
import '../utils/AppColor.dart';
import '../utils/AppImages.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';

import '../utils/Extensions/text_styles.dart';

class CategoryComponent extends StatefulWidget {
  final List<CategoryResponse>? data;

  CategoryComponent({this.data});

  @override
  _CategoryComponentState createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Wrap(
        runSpacing: 16,
        spacing: 8,
        children: List.generate(
          widget.data!.length,
          (index) {
            CategoryResponse data = widget.data![index];
            return AnimationConfiguration.staggeredGrid(
              duration: const Duration(milliseconds: 750),
              columnCount: 1,
              position: index,
              child: FlipAnimation(
                curve: Curves.linear,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: (() {
                      SubCategoryScreen(
                        catName: data.catName,
                        catId: data.catID,
                      ).launch(context);
                    }),
                    child: SizedBox(
                      width: (context.width() - 50) / 3,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(1),
                            decoration: boxDecorationWithShadowWidget(
                                backgroundColor: appStore.isDarkMode
                                    ? Colors.white70
                                    : primaryColor,
                                boxShape: BoxShape.circle),
                            child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: boxDecorationWithShadowWidget(
                                    backgroundColor: context.cardColor,
                                    boxShape: BoxShape.circle),
                                child: !data.image.validate().isEmptyOrNull
                                    ? CircleAvatar(
                                        backgroundColor: context.cardColor,
                                        backgroundImage:
                                            NetworkImage(data.image.validate()),
                                        maxRadius: 50)
                                    : CircleAvatar(
                                        backgroundColor: context.cardColor,
                                        backgroundImage:
                                            AssetImage(ic_placeHolder),
                                        maxRadius: 50)),
                          ),
                          4.height,
                          Text(data.name.validate(),
                              style: boldTextStyle(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ).paddingSymmetric(horizontal: 16);
  }
}
