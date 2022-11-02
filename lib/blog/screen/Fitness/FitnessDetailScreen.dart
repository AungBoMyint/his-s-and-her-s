import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kzn/main.dart';
import '../../model/BlogDetailResponse.dart';
import '../../network/RestApi.dart';
import '../../screen/SignInScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
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
import '../../component/Fitness/FitnessSuggestForYouComponent.dart';
import '../../component/HtmlWidget.dart';
import '../../component/ReadAloudDialog.dart';
import '../../utils/Extensions/Commons.dart';
import '../ViewAllScreen.dart';

class FitnessDetailScreen extends StatefulWidget {
  static String tag = '/FitnessDetailScreen';
  final int? postId;

  FitnessDetailScreen({this.postId});

  @override
  FitnessDetailScreenState createState() => FitnessDetailScreenState();
}

class FitnessDetailScreenState extends State<FitnessDetailScreen> {
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
                        ReadAloudDialog(parseHtmlString(snap.data!.postContent))
                            .fit(),
                      ],
                    )
                  ],
                ).paddingTop(context.statusBarHeight + 4),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category
                      snap.data!.category != null &&
                              snap.data!.category!.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                              decoration: boxDecorationWithShadowWidget(
                                  border: Border.all(width: 0.1),
                                  borderRadius: radius(6),
                                  backgroundColor: appStore.isDarkMode
                                      ? context.cardColor
                                      : primaryColor),
                              child: Text(
                                  snap.data!.category!.first.name.validate(),
                                  style: boldTextStyle(
                                      color: Colors.white, size: 14)),
                            )
                          : SizedBox(),
                      // Title
                      Text(parseHtmlString(snap.data!.postTitle!.validate()),
                              style: boldTextStyle(size: 20))
                          .paddingAll(16),

                      // Load image
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          commonCacheImageWidget(snap.data!.image.validate(),
                              fit: BoxFit.cover,
                              height: context.height() * 0.40,
                              width: context.width()),
                          Container(
                            height: context.height() * 0.40,
                            width: context.width(),
                            decoration: boxDecorationWithShadowWidget(
                                backgroundColor: Colors.black38),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.timelapse,
                                      size: 14, color: Colors.white),
                                  2.width,
                                  Text(snap.data!.humanTimeDiff.validate(),
                                      style: primaryTextStyle(
                                          size: 14, color: Colors.white)),
                                ],
                              ),
                              8.width,
                              Row(
                                children: [
                                  Icon(Icons.person,
                                      size: 14, color: Colors.white),
                                  2.width,
                                  Text(
                                          snap.data!.postAuthorName
                                              .validate()
                                              .capitalizeFirstLetter(),
                                          style: primaryTextStyle(
                                              size: 14, color: Colors.white))
                                      .expand(),
                                ],
                              ).onTap(() {
                                ViewAllScreen(
                                        name: snap.data!.postAuthorName
                                            .validate(),
                                        authId: snap.data!.postAuthorId,
                                        text: snap.data!.postAuthorName)
                                    .launch(context);
                              }).expand(),
                              Row(
                                children: [
                                  Icon(FontAwesome.commenting_o,
                                      size: 16, color: Colors.white),
                                  4.width,
                                  Text(
                                      snap.data!.noOfComments != "0"
                                          ? snap.data!.noOfCommentsText
                                              .toString()
                                              .splitBefore('Comment')
                                          : "0 ",
                                      style: secondaryTextStyle(
                                          color: Colors.white)),
                                ],
                              ),
                              8.width,
                              Row(
                                children: [
                                  Icon(Icons.favorite_border,
                                      size: 16, color: Colors.white),
                                  4.width,
                                  Text(snap.data!.likeCount.toString(),
                                      style: secondaryTextStyle(
                                          color: Colors.white)),
                                ],
                              )
                            ],
                          ).paddingSymmetric(vertical: 8, horizontal: 16),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                        margin: EdgeInsets.only(right: 8),
                                        padding: EdgeInsets.all(8),
                                        decoration:
                                            boxDecorationWithShadowWidget(
                                                boxShape: BoxShape.circle,
                                                backgroundColor: primaryColor),
                                        child: Icon(FontAwesome.commenting_o,
                                            size: 18, color: Colors.white))
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
                                          : Colors.white,
                                      size: 18),
                                ).onTap(() async {
                                  likeDislike(widget.postId.validate(), context,
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
                          ),
                        ],
                      ),

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
                        ).paddingOnly(left: 16, bottom: 16, top: 16),

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
                                  return FitnessSuggestForYouComponent(
                                      snap.data!.relatedNews![index]);
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
