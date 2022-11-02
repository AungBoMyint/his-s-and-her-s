import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';

import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/decorations.dart';

class FinanceStoryComponent extends StatefulWidget {
  static String tag = '/FitnessStoryComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;

  FinanceStoryComponent(this.mPost, {this.onCall});

  @override
  FinanceStoryComponentState createState() => FinanceStoryComponentState();
}

class FinanceStoryComponentState extends State<FinanceStoryComponent> {
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
    return Container(
            width: 85,
            height: 85,
            decoration: boxDecorationWithShadowWidget(
                borderRadius: radius(20),
                backgroundColor: context.cardColor,
                border: Border.all(width: 1, color: primaryColor)),
            child: commonCacheImageWidget(widget.mPost.image.validate(),
                    fit: BoxFit.cover)
                .cornerRadiusWithClipRRect(20))
        .onTap(() {
      widget.onCall!.call();
    });
  }
}
