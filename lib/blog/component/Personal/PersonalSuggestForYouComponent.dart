import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/AppWidget.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/Personal/PersonalDetailScreen.dart';
import '../../utils/AppImages.dart';

class PersonalSuggestForYouComponent extends StatefulWidget {
  static String tag = '/FitnessSuggestForYouComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;

  PersonalSuggestForYouComponent(this.mPost, {this.onCall});

  @override
  PersonalSuggestForYouComponentState createState() =>
      PersonalSuggestForYouComponentState();
}

class PersonalSuggestForYouComponentState
    extends State<PersonalSuggestForYouComponent> {
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
        widget.mPost.postType == postVideoType
            ? VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!)
                .launch(context)
            : PersonalDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: Container(
        width: context.width(),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 8, top: 8),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: boxDecorationWithShadowWidget(
            backgroundColor: context.cardColor,
            blurRadius: 5,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            decorationImage: DecorationImage(
                image: AssetImage(ic_personal_border), fit: BoxFit.cover),
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              commonCacheImageWidget(widget.mPost.image.toString(),
                      fit: BoxFit.cover,
                      height: context.height() * 0.5,
                      width: context.width())
                  .cornerRadiusWithClipRRectOnly(
                      topRight: 50,
                      topLeft: 16,
                      bottomRight: 16,
                      bottomLeft: 16),
              Icon(Icons.play_circle_outline, color: Colors.white, size: 40)
                  .visible(widget.mPost.postType == postVideoType),
              Positioned(
                bottom: 10,
                left: 8,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.mPost.postTitle.validate(),
                            style: boldTextStyle(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis)
                        .paddingLeft(8),
                    Row(
                      children: [
                        Icon(Entypo.dot_single),
                        Text(widget.mPost.humanTimeDiff!,
                                style: secondaryTextStyle(color: Colors.black))
                            .expand(),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: boxDecorationWithShadowWidget(
                              backgroundColor: Colors.white.withOpacity(0.6)),
                          child: bookMarkComponent(widget.mPost, context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ).paddingAll(8),
        ),
      ),
    );
  }
}
