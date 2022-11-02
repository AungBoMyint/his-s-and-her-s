import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/AppWidget.dart';
import '../../component/Music/MusicFeatureComponent.dart';
import 'package:kzn/main.dart';
import '../../model/BlogDetailResponse.dart';
import '../../network/RestApi.dart';
import '../../screen/SignInScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Colors.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import 'package:share_plus/share_plus.dart';
import '../../component/AppWidget.dart';
import '../../component/HtmlWidget.dart';
import '../../component/ReadAloudDialog.dart';

class MusicDetailScreen extends StatefulWidget {
  static String tag = '/MusicDetailScreen';
  final int? postId;

  MusicDetailScreen({this.postId});

  @override
  MusicDetailScreenState createState() => MusicDetailScreenState();
}

class MusicDetailScreenState extends State<MusicDetailScreen> {
  bool? isLike;

  Future<BlogDetailResponse>? mGetDetail;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    loadInterstitialAds();
    mGetDetail = getBlogDetail(widget.postId!);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    showInterstitialAds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<BlogDetailResponse>(
        future: mGetDetail,
        builder: (context, snap) {
          if (snap.hasData) {
            return Column(
              children: [
                //AppBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(),
                    Row(
                      children: [
                        IconButton(onPressed: () {
                          if (userStore.isLoggedIn) {
                            addToBookMark(snap.data!);
                            setState(() {});
                          } else {
                            SignInScreen().launch(context);
                          }
                        }, icon: Observer(builder: (context) {
                          return bookMarkStore
                                  .isItemInBookMark(widget.postId.validate())
                              ? Icon(MaterialIcons.bookmark_border,
                                  color: primaryColor)
                              : Icon(Ionicons.bookmark_outline,
                                  color: context.iconColor);
                        })),
                        if (!snap.data!.shareUrl.isEmptyOrNull)
                          IconButton(
                            onPressed: () {
                              Share.share(
                                  'Share ${snap.data!.postTitle} app\n$playStoreBaseURL${snap.data!.shareUrl}');
                            },
                            icon: Icon(Ionicons.share_social_outline,
                                color: context.iconColor),
                          ),
                        ReadAloudDialog(parseHtmlString(snap.data!.postContent))
                            .fit(),
                      ],
                    )
                  ],
                ).paddingOnly(
                    top: context.statusBarHeight + 4, right: 16, left: 16),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Load image
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          commonCacheImageWidget(snap.data!.image.validate(),
                                  fit: BoxFit.fill,
                                  height: context.height() * 0.41,
                                  width: context.width())
                              .paddingOnly(top: 6, bottom: 16),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    likeDislike(
                                        widget.postId.validate(), context,
                                        onCall: () {
                                      setState(() {
                                        mGetDetail =
                                            getBlogDetail(widget.postId!);
                                      });
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                        boxDecorationWithRoundedCornersWidget(
                                            borderRadius: radius(8),
                                            backgroundColor: primaryColor),
                                    padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                            snap.data!.isLike != true
                                                ? Icons.favorite_border
                                                : Icons.favorite,
                                            size: 16,
                                            color: whiteColor),
                                        16.width,
                                        Text(snap.data!.likeCount.toString(),
                                            style: secondaryTextStyle(
                                                color: whiteColor)),
                                      ],
                                    ).paddingAll(4),
                                  ),
                                ),
                                16.width,
                                GestureDetector(
                                  onTap: () async {
                                    commentFuc(
                                        context: context,
                                        data: snap.data!,
                                        id: widget.postId,
                                        onCall: () {
                                          init();
                                          setState(() {});
                                        },
                                        onRefresh: () {
                                          setState(() {});
                                        });
                                  },
                                  child: Container(
                                    decoration:
                                        boxDecorationWithRoundedCornersWidget(
                                            borderRadius: radius(8),
                                            backgroundColor: primaryColor),
                                    padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(FontAwesome.commenting_o,
                                            size: 16, color: whiteColor),
                                        16.width,
                                        Text(
                                            snap.data!.noOfComments != "0"
                                                ? snap.data!.noOfComments
                                                    .toString()
                                                : "0",
                                            style: secondaryTextStyle(
                                                color: whiteColor)),
                                      ],
                                    ).paddingAll(4),
                                  ),
                                ),
                              ],
                            ).paddingLeft(20),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesome.user_o,
                                      size: 14, color: textPrimaryColorGlobal)
                                  .visible(snap.data!.postAuthorName
                                      .validate()
                                      .isNotEmpty),
                              4.width.visible(snap.data!.postAuthorName
                                  .validate()
                                  .isNotEmpty),
                              if (snap.data!.postAuthorName
                                  .validate()
                                  .isNotEmpty)
                                Text(snap.data!.postAuthorName.validate(),
                                    style: secondaryTextStyle(
                                        color: textPrimaryColorGlobal)),
                            ],
                          ),
                          16.width,
                          Row(
                            children: [
                              Icon(MaterialCommunityIcons.timer_outline,
                                      size: 14, color: textPrimaryColorGlobal)
                                  .visible(snap.data!.postDate
                                      .validate()
                                      .isNotEmpty),
                              4.width.visible(
                                  snap.data!.postDate.validate().isNotEmpty),
                              if (snap.data!.postDate.validate().isNotEmpty)
                                Text(snap.data!.humanTimeDiff.validate(),
                                    style: secondaryTextStyle(
                                        color: textPrimaryColorGlobal)),
                            ],
                          ),
                        ],
                      ).paddingOnly(right: 16),

                      // Tag
                      if (snap.data!.tags != null &&
                          snap.data!.tags!.isNotEmpty)
                        Wrap(
                          runSpacing: 4,
                          children: List.generate(
                            snap.data!.tags!.length,
                            (index) {
                              Tags data = snap.data!.tags![index];
                              return GestureDetector(
                                onTap: (() {
                                  setState(() {});
                                }),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  margin: EdgeInsets.only(right: 10, top: 8),
                                  color: primaryColor,
                                  child: Text(data.name.validate(),
                                      style: secondaryTextStyle(
                                          color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              );
                            },
                          ),
                        ).paddingOnly(left: 16),

                      // Title
                      Text(parseHtmlString(snap.data!.postTitle.validate()),
                              style: boldTextStyle(size: 20))
                          .paddingAll(16),

                      //Description
                      HtmlWidget(
                              postContent: snap.data!.postContent!.validate())
                          .paddingOnly(left: 16, right: 16),

                      //related post
                      if (snap.data!.relatedNews != null &&
                          snap.data!.relatedNews!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.height,
                            Text("Relatable Post",
                                    style: boldTextStyle(size: 18))
                                .paddingSymmetric(horizontal: 16),
                            HorizontalList(
                                itemCount: snap.data!.relatedNews!.length,
                                padding: EdgeInsets.only(
                                    bottom: 20, right: 16, left: 16, top: 8),
                                itemBuilder: (_, index) {
                                  return MusicFeatureComponent(
                                    snap.data!.relatedNews![index],
                                    isSlider: true,
                                  );
                                }),
                          ],
                        ),
                    ],
                  ),
                ).expand(),
              ],
            );
          }
          return snapWidgetHelper(snap);
        },
      ),
    );
  }
}
