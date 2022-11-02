import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/CategoryResponse.dart';
import '../../utils/AppImages.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/string_extensions.dart';

import '../../screen/SubCategoryScreen.dart';

class PersonalCustomCategoryComponent extends StatefulWidget {
  static String tag = '/FitnessCustomCategoryComponent';
  final CategoryResponse mPost;
  final Function? onCall;
  final bool? isSlider;

  PersonalCustomCategoryComponent(this.mPost,
      {this.onCall, this.isSlider = false});

  @override
  PersonalCustomCategoryComponentState createState() =>
      PersonalCustomCategoryComponentState();
}

class PersonalCustomCategoryComponentState
    extends State<PersonalCustomCategoryComponent> {
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
        width: 110,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: boxDecorationWithShadowWidget(
          backgroundColor: context.cardColor,
          borderRadius: radius(55),
          decorationImage: DecorationImage(
              image: AssetImage(ic_personalCategory), fit: BoxFit.fitWidth),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1.5, 0), // changes position of shadow
            ),
          ],
        ),
        child: Text(widget.mPost.catName.validate(),
            style:
                GoogleFonts.amiri(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
