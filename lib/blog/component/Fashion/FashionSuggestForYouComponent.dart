import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/DefaultPostResponse.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../screen/Fashion/FashionDetailScreen.dart';
import '../VideoPlayDialog.dart';

class FashionSuggestForYouComponent extends StatefulWidget {
  final DefaultPostResponse? blogResponse;

  FashionSuggestForYouComponent(this.blogResponse);

  @override
  _FashionSuggestForYouComponentState createState() =>
      _FashionSuggestForYouComponentState();
}

class _FashionSuggestForYouComponentState
    extends State<FashionSuggestForYouComponent> {
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
    return GestureDetector(
      onTap: () {
        widget.blogResponse!.postType == postVideoType
            ? VideoPlayDialog(widget.blogResponse!.videoType!,
                    widget.blogResponse!.videoUrl!)
                .launch(context)
            : FashionDetailScreen(postId: widget.blogResponse!.iD)
                .launch(context);
      },
      child: Container(
        width: context.width(),
        padding: EdgeInsets.only(left: 7, right: 9),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                commonCacheImageWidget(widget.blogResponse!.image.toString(),
                    fit: BoxFit.cover,
                    width: context.width() * 0.67,
                    height: context.height() * 0.4),
                Container(
                  width: context.width() * 0.67,
                  height: context.height() * 0.4,
                  color: Colors.black12,
                ),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                    .visible(widget.blogResponse!.postType == postVideoType),
                Positioned(
                  right: -90,
                  child: Container(
                    width: context.width() * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.blogResponse!.postTitle.validate(),
                            style: GoogleFonts.redressed(
                                backgroundColor:
                                    context.cardColor.withOpacity(0.6),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis),
                        8.height,
                        Text(
                            parseHtmlString(widget.blogResponse!.postContent)
                                .validate(),
                            style: primaryTextStyle(
                                backgroundColor:
                                    context.cardColor.withOpacity(0.6)),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis),
                        16.height,
                        Text("Explore",
                            style: secondaryTextStyle(
                                backgroundColor:
                                    context.cardColor.withOpacity(0.6))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
