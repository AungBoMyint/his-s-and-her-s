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
import '../../component/LifeStyle/LifeStyleFeatureComponent.dart';
import '../../component/ReadAloudDialog.dart';
import '../ViewAllScreen.dart';

class LifeStyleDetailScreen extends StatefulWidget {
  static String tag = '/LifeStyleDetailScreen';
  final int? postId;

  LifeStyleDetailScreen({this.postId});

  @override
  LifeStyleDetailScreenState createState() => LifeStyleDetailScreenState();
}

class LifeStyleDetailScreenState extends State<LifeStyleDetailScreen> {
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
                              ? Icon(Ionicons.bookmark, color: primaryColor)
                              : Icon(Ionicons.bookmark_outline,
                                  color: context.iconColor);
                        })),
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
                        })
                      ],
                    )
                  ],
                ).paddingTop(context.statusBarHeight + 4),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      35.height,
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(ic_lifeStyleBg,
                              height: 300,
                              width: context.width(),
                              fit: BoxFit.fill),
                          Positioned(
                            top: -40,
                            left: 16,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: context.width() * 0.55,
                                    height: 230,
                                    margin: EdgeInsets.only(
                                      top: 16,
                                      right: 10,
                                    ),
                                    decoration: boxDecorationWithShadowWidget(
                                        border: Border.all(
                                            width: 4, color: primaryColor),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    child: commonCacheImageWidget(
                                            snap.data!.image
                                                .validate()
                                                .toString(),
                                            fit: BoxFit.cover,
                                            height: 230,
                                            width: context.width() * 0.55)
                                        .cornerRadiusWithClipRRectOnly(
                                            bottomLeft: 16, topRight: 16),
                                  ),
                                ),

                                // Title
                                snap.data!.category != null &&
                                        snap.data!.category!.isNotEmpty
                                    ? Container(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 4, 8, 4),
                                        decoration:
                                            boxDecorationWithShadowWidget(
                                                border: Border.all(width: 0.1),
                                                borderRadius: radius(6),
                                                backgroundColor: primaryColor),
                                        child: Text(
                                            snap.data!.category!.first.name
                                                .validate(),
                                            style: boldTextStyle(
                                                color: Colors.white, size: 14)),
                                      )
                                    : SizedBox(),
                                8.height,
                                Text(
                                    parseHtmlString(
                                        snap.data!.postTitle.validate()),
                                    style: boldTextStyle(size: 20),
                                    maxLines: 2),
                              ],
                            ),
                          ),
                        ],
                      ),
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.timelapse,
                                  size: 14, color: context.iconColor),
                              2.width,
                              Text(snap.data!.humanTimeDiff.validate(),
                                  style: primaryTextStyle(size: 14)),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(FontAwesome.commenting_o,
                                      size: 20,
                                      color: textSecondaryColorGlobal),
                                  4.width,
                                  Text(
                                      snap.data!.noOfComments != "0"
                                          ? snap.data!.noOfCommentsText
                                              .toString()
                                              .splitBefore("Comment")
                                          : "Add Comments",
                                      style: secondaryTextStyle(size: 16)),
                                ],
                              ).onTap(() async {
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
                              8.width,
                              Row(
                                children: [
                                  Icon(
                                      snap.data!.isLike != true
                                          ? Icons.favorite_border
                                          : Icons.favorite,
                                      size: 20,
                                      color: textSecondaryColorGlobal),
                                  4.width,
                                  Text(snap.data!.likeCount.toString(),
                                      style: secondaryTextStyle(size: 16)),
                                ],
                              ).onTap(() {
                                likeDislike(widget.postId.validate(), context,
                                    onCall: () {
                                  setState(() {
                                    mGetDetail = getBlogDetail(widget.postId!);
                                  });
                                });
                              }),
                            ],
                          )
                        ],
                      ).paddingSymmetric(horizontal: 16),

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
                                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: boxDecorationDefaultWidget(
                                      borderRadius: radius(30),
                                      color: primaryColor),
                                  child: Text(data.name.validate(),
                                      style: secondaryTextStyle(
                                          color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              );
                            },
                          ),
                        ).paddingOnly(left: 16, top: 10, bottom: 16),

                      //Description
                      Text("By " + snap.data!.postAuthorName.validate(),
                              style: primaryTextStyle(size: 14))
                          .onTap(() {
                            ViewAllScreen(
                                    name: snap.data!.postAuthorName.validate(),
                                    authId: snap.data!.postAuthorId,
                                    text: snap.data!.postAuthorName)
                                .launch(context);
                          })
                          .paddingTop(16)
                          .paddingSymmetric(horizontal: 16),
                      HtmlWidget(postContent: snap.data!.postContent.validate())
                          .paddingOnly(left: 16, top: 10, right: 16),

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
                                  return LifeStyleFeatureComponent(
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
