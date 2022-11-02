import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/Extensions/Colors.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';

import '../../utils/AppColor.dart';
import '../../utils/Extensions/decorations.dart';

class SportStoryComponent extends StatefulWidget {
  static String tag = '/FitnessStoryComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;

  SportStoryComponent(this.mPost, {this.onCall});

  @override
  SportStoryComponentState createState() => SportStoryComponentState();
}

class SportStoryComponentState extends State<SportStoryComponent> {
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
      width: 80,
      height: 80,
      margin: EdgeInsets.only(right: 6),
      decoration: boxDecorationWithRoundedCornersWidget(
          boxShape: BoxShape.circle,
          border: Border.all(width: 3, color: primaryColor.withOpacity(0.6))),
      child: CircleAvatar(
              backgroundColor: whiteColor,
              backgroundImage: NetworkImage(widget.mPost.image!.validate()))
          .cornerRadiusWithClipRRect(85)
          .paddingAll(2),
    ).onTap(() {
      widget.onCall!.call();
    });
  }
}
