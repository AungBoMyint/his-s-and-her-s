import 'package:flutter/material.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/string_extensions.dart';

class MusicStoryComponent extends StatefulWidget {
  static String tag = '/MusicStoryComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;

  MusicStoryComponent(this.mPost, {this.onCall});

  @override
  MusicStoryComponentState createState() => MusicStoryComponentState();
}

class MusicStoryComponentState extends State<MusicStoryComponent> {
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
                border: Border.all(width: 3, color: primaryColor)),
            child: commonCacheImageWidget(widget.mPost.image.validate(),
                    fit: BoxFit.cover)
                .cornerRadiusWithClipRRect(16))
        .onTap(() {
      widget.onCall!.call();
    });
  }
}
