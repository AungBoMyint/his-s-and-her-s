import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppColor.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/string_extensions.dart';

import '../../utils/AppCommon.dart';

class NewsStoryComponent extends StatefulWidget {
  static String tag = '/NewsStoryComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;

  NewsStoryComponent(this.mPost, {this.onCall});

  @override
  NewsStoryComponentState createState() => NewsStoryComponentState();
}

class NewsStoryComponentState extends State<NewsStoryComponent> {
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
                border: Border.all(width: 2, color: primaryColor)),
            child: commonCacheImageWidget(widget.mPost.image.validate(),
                    fit: BoxFit.cover)
                .cornerRadiusWithClipRRect(18))
        .onTap(() {
      widget.onCall!.call();
    });
  }
}
