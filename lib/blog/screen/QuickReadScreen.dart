import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../main.dart';
import '../component/HtmlWidget.dart';
import '../language/language.dart';
import '../network/RestApi.dart';
import '../utils/AppColor.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../component/VideoPlayDialog.dart';
import '../model/DefaultPostResponse.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstant.dart';
import '../utils/DetailScreenConfig.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Loader.dart';
import '../utils/Extensions/text_styles.dart';

class QuickReadScreen extends StatefulWidget {
  static String tag = '/QuickReadScreen';
  final List<DefaultPostResponse>? blogList;

  QuickReadScreen({required this.blogList});

  @override
  _QuickReadScreenState createState() => _QuickReadScreenState();
}

class _QuickReadScreenState extends State<QuickReadScreen> {
  PageController pageController = PageController();

  int page = 1;
  int numPage = 1;

  bool hasError = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    init();

    loadNews();
  }

  Future<void> init() async {
    pageController.addListener(() {
      if ((pageController.page!.toInt() + 1) == widget.blogList!.length) {
        if (page < numPage) {
          page++;

          appStore.setLoading(true);
          loadNews();
        }
      }
    });
  }

  Future<void> loadNews() async {
    await blogFilterApi(page, filter: 'recent').then((value) async {
      appStore.setLoading(false);

      hasError = false;

      numPage = value.numPages.validate(value: 1);

      if (page == 1) {
        widget.blogList!.clear();
      }
      widget.blogList!.addAll(value.posts!);

      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);

      hasError = true;
      error = e.toString();
      setState(() {});
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
            ),
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: pageController,
              physics: BouncingScrollPhysics(),
              children: List.generate(widget.blogList!.length, (index) {
                return GestureDetector(
                  onHorizontalDragEnd: (v) {
                    if (v.velocity.pixelsPerSecond.dx.isNegative) {
                      getDetailScreenWidget(context, widget.blogList![index]);
                    }
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            commonCacheImageWidget(
                                widget.blogList![index].image,
                                width: context.width(),
                                fit: BoxFit.cover,
                                height: 300),
                            Icon(
                              Icons.play_circle_outline_rounded,
                              size: 50,
                              color: Colors.white,
                            ).visible(widget.blogList![index].postType ==
                                postVideoType)
                          ],
                        ),
                        16.height,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                parseHtmlString(widget
                                    .blogList![index].postTitle
                                    .validate()),
                                style: boldTextStyle(size: 20),
                                maxLines: 4,
                                textAlign: TextAlign.start),
                            4.height,
                            Text(
                                widget.blogList![index].humanTimeDiff
                                    .validate(),
                                style: secondaryTextStyle()),
                            8.height,
                            HtmlWidget(
                                    postContent: widget
                                        .blogList![index].postContent
                                        .validate())
                                .expand()
                                .visible(widget.blogList![index].postType ==
                                    postType),
                            16.height,
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                color: context.cardColor,
                                alignment: Alignment.bottomRight,
                                child: Text(LanguageEn.lblReadMore,
                                        style:
                                            boldTextStyle(color: primaryColor))
                                    .paddingAll(8)
                                    .visible(widget.blogList![index].postType ==
                                        postType)),
                          ],
                        ).paddingSymmetric(horizontal: 12).expand(),
                      ],
                    ),
                  ).onTap(() {
                    if (widget.blogList![index].postType == postType)
                      getDetailScreenWidget(context, widget.blogList![index]);
                    else
                      VideoPlayDialog(widget.blogList![index].videoType!,
                              widget.blogList![index].videoUrl!)
                          .launch(context);
                  }),
                );
              }),
            ),
          ),
          BackButton().paddingTop(context.statusBarHeight),
          Observer(builder: (_) => Loader().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
