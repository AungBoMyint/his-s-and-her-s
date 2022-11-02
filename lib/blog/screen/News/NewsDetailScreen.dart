import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kzn/main.dart';
import '../../model/BlogDetailResponse.dart';
import '../../network/RestApi.dart';
import '../../screen/SignInScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppImages.dart';
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
import '../../component/News/NewsFeatureComponent.dart';
import '../../component/ReadAloudDialog.dart';
import '../../utils/Extensions/Commons.dart';
import '../ViewAllScreen.dart';

class NewsDetailScreen extends StatefulWidget {
  static String tag = '/NewsDetailScreen';
  final int? postId;

  NewsDetailScreen({this.postId});

  @override
  NewsDetailScreenState createState() => NewsDetailScreenState();
}

class NewsDetailScreenState extends State<NewsDetailScreen> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Share.share(
                                'Share ${snap.data!.postTitle} app\n$playStoreBaseURL${snap.data!.shareUrl}');
                          },
                          icon: Icon(Ionicons.share_social_outline,
                              color: context.iconColor),
                        ),
                        Observer(builder: (context) {
                          return ReadAloudDialog(
                                  parseHtmlString(snap.data!.postContent))
                              .fit();
                        }),
                      ],
                    )
                  ],
                ).paddingTop(context.statusBarHeight + 4),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Load image
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          !snap.data!.image!.isEmptyOrNull
                              ? commonCacheImageWidget(
                                      snap.data!.image.validate(),
                                      fit: BoxFit.fill,
                                      height: context.height() * 0.45,
                                      width: context.width())
                                  .paddingOnly(bottom: 16)
                              : Image.asset(ic_placeHolder,
                                      fit: BoxFit.fill,
                                      height: context.height() * 0.45,
                                      width: context.width())
                                  .paddingOnly(bottom: 16),
                          Positioned(
                            bottom: -20,
                            right: 16,
                            left: 16,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 8),
                                      padding: EdgeInsets.all(8),
                                      decoration: boxDecorationWithShadowWidget(
                                          borderRadius: radius(),
                                          backgroundColor: primaryColor),
                                      child: Row(
                                        children: [
                                          Icon(
                                                  MaterialCommunityIcons
                                                      .timer_outline,
                                                  size: 14,
                                                  color: Colors.white)
                                              .visible(snap.data!.postDate
                                                  .validate()
                                                  .isNotEmpty),
                                          4.width.visible(snap.data!.postDate
                                              .validate()
                                              .isNotEmpty),
                                          if (snap.data!.postDate
                                              .validate()
                                              .isNotEmpty)
                                            Text(
                                                snap.data!.humanTimeDiff
                                                    .validate(),
                                                style: secondaryTextStyle(
                                                    color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    SizedBox().expand(),
                                    Container(
                                            margin: EdgeInsets.only(right: 8),
                                            padding: EdgeInsets.all(8),
                                            decoration:
                                                boxDecorationWithShadowWidget(
                                                    boxShape: BoxShape.circle,
                                                    backgroundColor:
                                                        primaryColor),
                                            child: Icon(
                                                FontAwesome.commenting_o,
                                                size: 18,
                                                color: Colors.white))
                                        .onTap(() async {
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
                                    }),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: boxDecorationWithShadowWidget(
                                          boxShape: BoxShape.circle,
                                          backgroundColor: primaryColor),
                                      child: Icon(
                                          snap.data!.isLike != true
                                              ? Icons.favorite_border
                                              : Icons.favorite,
                                          color: snap.data!.isLike != true
                                              ? Colors.white
                                              : Colors.red,
                                          size: 18),
                                    ).onTap(() async {
                                      likeDislike(
                                          widget.postId.validate(), context,
                                          onCall: () {
                                        setState(() {
                                          mGetDetail =
                                              getBlogDetail(widget.postId!);
                                        });
                                      });
                                    }),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: boxDecorationWithShadowWidget(
                                          boxShape: BoxShape.circle,
                                          backgroundColor: primaryColor),
                                      child: Observer(builder: (context) {
                                        return bookMarkStore.isItemInBookMark(
                                                widget.postId.validate())
                                            ? Icon(Ionicons.bookmark,
                                                color: Colors.white, size: 18)
                                            : Icon(Ionicons.bookmark_outline,
                                                color: Colors.white, size: 18);
                                      }),
                                    ).onTap(() {
                                      if (userStore.isLoggedIn) {
                                        addToBookMark(snap.data!);
                                        setState(() {});
                                      } else {
                                        SignInScreen().launch(context);
                                      }
                                    })
                                  ],
                                ),
                                8.height,
                                Container(
                                  decoration: boxDecorationWithShadowWidget(
                                      backgroundColor: context.cardColor,
                                      borderRadius: radius(),
                                      blurRadius: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      8.height,
                                      // Category
                                      snap.data!.category != null &&
                                              snap.data!.category!.isNotEmpty
                                          ? Container(
                                              margin: EdgeInsets.only(left: 16),
                                              padding: EdgeInsets.fromLTRB(
                                                  8, 4, 8, 4),
                                              decoration:
                                                  boxDecorationWithShadowWidget(
                                                      border: Border.all(
                                                          width: 0.1),
                                                      borderRadius: radius(),
                                                      backgroundColor:
                                                          primaryColor),
                                              child: Text(
                                                  snap.data!.category!.first
                                                      .name
                                                      .validate(),
                                                  style: boldTextStyle(
                                                      color: Colors.white,
                                                      size: 14)),
                                            )
                                          : SizedBox(),
                                      8.height,
                                      Text(
                                              parseHtmlString(snap
                                                  .data!.postTitle
                                                  .validate()),
                                              style: boldTextStyle(size: 20))
                                          .paddingSymmetric(horizontal: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(FontAwesome.user_o, size: 14)
                                                  .visible(snap
                                                      .data!.postAuthorName
                                                      .validate()
                                                      .isNotEmpty),
                                              4.width.visible(snap
                                                  .data!.postAuthorName
                                                  .validate()
                                                  .isNotEmpty),
                                              if (snap.data!.postAuthorName
                                                  .validate()
                                                  .isNotEmpty)
                                                Text(
                                                    snap.data!.postAuthorName
                                                        .validate()
                                                        .capitalizeFirstLetter(),
                                                    style: secondaryTextStyle(
                                                        color:
                                                            textPrimaryColorGlobal)),
                                            ],
                                          ).onTap(() {
                                            ViewAllScreen(
                                                    name: snap
                                                        .data!.postAuthorName
                                                        .validate(),
                                                    authId:
                                                        snap.data!.postAuthorId,
                                                    text: snap
                                                        .data!.postAuthorName)
                                                .launch(context);
                                          }).expand(),
                                          Row(
                                            children: [
                                              Icon(FontAwesome.commenting_o,
                                                  size: 16,
                                                  color:
                                                      textSecondaryColorGlobal),
                                              4.width,
                                              Text(
                                                  snap.data!.noOfComments != "0"
                                                      ? snap.data!
                                                          .noOfCommentsText
                                                          .toString()
                                                          .splitBefore(
                                                              'Comment')
                                                      : "0 ",
                                                  style: secondaryTextStyle()),
                                            ],
                                          ),
                                          8.width,
                                          Row(
                                            children: [
                                              Icon(Icons.favorite_border,
                                                  size: 16,
                                                  color:
                                                      textSecondaryColorGlobal),
                                              4.width,
                                              Text(
                                                  snap.data!.likeCount
                                                      .toString(),
                                                  style: secondaryTextStyle()),
                                            ],
                                          ),
                                        ],
                                      ).paddingSymmetric(
                                          horizontal: 16, vertical: 8),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      28.height,

                      // Tag
                      Wrap(
                        runSpacing: 4,
                        children: List.generate(
                          snap.data!.tags!.length,
                          (index) {
                            Tags data = snap.data!.tags![index];
                            return GestureDetector(
                              onTap: (() {
                                ViewAllScreen(
                                        name: 'by_tag',
                                        text: data.name.splitAfter("#"),
                                        tagId: data.termId)
                                    .launch(context);
                                setState(() {});
                              }),
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: boxDecorationWithShadowWidget(
                                      backgroundColor: primaryColor,
                                      borderRadius: radius(8)),
                                  child: Text(data.name.validate() + " ",
                                      style: secondaryTextStyle(
                                          color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis)),
                            );
                          },
                        ),
                      ).paddingOnly(left: 16, bottom: 16, top: 16).visible(
                          snap.data!.tags != null &&
                              snap.data!.tags!.isNotEmpty),
                      8.height.visible(
                          snap.data!.tags == null && snap.data!.tags!.isEmpty),

                      //Description
                      HtmlWidget(postContent: snap.data!.postContent.validate())
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
                            8.height,
                            HorizontalList(
                                itemCount: snap.data!.relatedNews!.length,
                                padding: EdgeInsets.only(
                                    bottom: 20, right: 16, left: 16),
                                itemBuilder: (_, index) {
                                  return NewsFeaturedComponent(
                                      snap.data!.relatedNews![index],
                                      isSlider: true);
                                }),
                          ],
                        ),
                    ],
                  ),
                ).expand(),
              ],
            );
          }
          if (snap.hasError) {
            apiErrorComponent(snap.error, context);
          }
          return snapWidgetHelper(snap);
        },
      ),
    );
  }
}
