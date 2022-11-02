import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/VideoPlayDialog.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/Travel/TravelDetailScreen.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

import '../../utils/AppColor.dart';

class TravelBlogItemWidget extends StatefulWidget {
  static String tag = '/TravelBlogItemWidget';
  final DefaultPostResponse mPost;
  final Function? onCall;

  TravelBlogItemWidget(this.mPost, {this.onCall});

  @override
  TravelBlogItemWidgetState createState() => TravelBlogItemWidgetState();
}

class TravelBlogItemWidgetState extends State<TravelBlogItemWidget> {
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
        widget.mPost.postType == postVideoType ? VideoPlayDialog(widget.mPost.videoType!, widget.mPost.videoUrl!).launch(context) : TravelDetailScreen(postId: widget.mPost.iD).launch(context);
      },
      child: widget.mPost.postType == postVideoType
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: Container(
                    width: /* widget.isSlider == true ? */ context.width() * 0.7 /*: context.width() * 0.52 - 28*/,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        commonCacheImageWidget(widget.mPost.image.toString(), fit: BoxFit.cover, height: 250, width: context.width() * 0.7).cornerRadiusWithClipRRect(16),
                        Container(
                          padding: EdgeInsets.all(8),
                          width: context.width() * 0.7,
                          decoration: boxDecorationWithShadowWidget(backgroundColor: primaryColor.withOpacity(0.2), borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.mPost.postTitle.validate(), style: primaryTextStyle(color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis),
                              8.height,
                              Row(
                                children: [
                                  Text(widget.mPost.humanTimeDiff!, style: secondaryTextStyle(color: Colors.white)).expand(),
                                  Row(
                                    children: [
                                      Icon(Icons.favorite_border, size: 18, color: Colors.white),
                                      2.width,
                                      Text(widget.mPost.likeCount!.validate().toString(), style: primaryTextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  8.width,
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesome.commenting_o,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      2.width,
                                      Text(widget.mPost.noOfComments!.validate().toString(), style: primaryTextStyle(color: Colors.white)),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
              ],
            )
          : Container(
              child: Container(
                width: /* widget.isSlider == true ? */ context.width() * 0.7 /*: context.width() * 0.52 - 28*/,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    commonCacheImageWidget(widget.mPost.image.toString(), fit: BoxFit.cover, height: 250, width: context.width() * 0.7).cornerRadiusWithClipRRect(16),
                    Container(
                      padding: EdgeInsets.all(8),
                      width: context.width() * 0.7,
                      decoration: boxDecorationWithShadowWidget(backgroundColor: primaryColor.withOpacity(0.2), borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.mPost.postTitle.validate(), style: primaryTextStyle(color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis),
                          8.height,
                          Row(
                            children: [
                              Text(widget.mPost.humanTimeDiff!, style: secondaryTextStyle(color: Colors.white)).expand(),
                              Row(
                                children: [
                                  Icon(Icons.favorite_border, size: 18, color: Colors.white),
                                  2.width,
                                  Text(widget.mPost.likeCount!.validate().toString(), style: primaryTextStyle(color: Colors.white)),
                                ],
                              ),
                              8.width,
                              Row(
                                children: [
                                  Icon(
                                    FontAwesome.commenting_o,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  2.width,
                                  Text(widget.mPost.noOfComments!.validate().toString(), style: primaryTextStyle(color: Colors.white)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
