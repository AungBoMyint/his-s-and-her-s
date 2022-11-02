import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kzn/blog/language/language.dart';
import '../../main.dart';
import '../model/CategoryResponse.dart';
import '../model/DefaultPostResponse.dart';
import '../network/RestApi.dart';
import '../utils/AppImages.dart';
import '../utils/DefaultCardConfig.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/HorizontalList.dart';
import '../utils/Extensions/Loader.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../component/AppWidget.dart';
import '../component/NoDataWidget.dart';
import '../utils/AppConstant.dart';
import '../utils/DefaultCardTypeConfig.dart';

class SubCategoryScreen extends StatefulWidget {
  final int? catId;
  final String? catName;
  final bool? isDashboard;

  SubCategoryScreen({this.catId, this.catName, this.isDashboard = false});

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  List<DefaultPostResponse> defaultPostResponseList = [];
  ScrollController scrollController = ScrollController();

  int page = 1;
  int numPage = 1;

  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    appStore.setLoading(true);
    init();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !appStore.isLoading) {
        print("numPage" + numPage.toString());
        if (page < numPage) {
          page++;
          init();
        }
      }
    });
  }

  void init() async {
    loadBlogData();
  }

  Future<void> loadBlogData() async {
    isLoading = true;
    appStore.setLoading(true);
    blogFilterApi(page, filter: "by_category", cat: widget.catId)
        .then((res) async {
      appStore.setLoading(false);
      isLoading = false;
      setState(() {});
      numPage = res.numPages.validate(value: 1);
      isLastPage = false;
      if (page == 1) {
        defaultPostResponseList.clear();
      }
      defaultPostResponseList.addAll(res.posts!);
      setState(() {});
    }).catchError((e) {
      isLastPage = true;
      isLoading = false;
      setState(() {});
      appStore.setLoading(false);
      apiErrorComponent(e, context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(widget.catName.validate(),
          elevation: 0, showBack: true, textColor: Colors.white),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<CategoryResponse>>(
              future: getCategory(widget.catId),
              builder: (context, snap) {
                if (snap.hasData) {
                  if (snap.data!.isNotEmpty)
                    return HorizontalList(
                        itemCount: snap.data!.length,
                        padding: EdgeInsets.all(16),
                        itemBuilder: (_, i) {
                          CategoryResponse data = snap.data![i];
                          return AnimationConfiguration.staggeredGrid(
                            duration: const Duration(milliseconds: 750),
                            columnCount: 1,
                            position: i,
                            child: FlipAnimation(
                              curve: Curves.linear,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: (() {
                                    SubCategoryScreen(
                                            catId: data.catID,
                                            catName: data.name)
                                        .launch(context);
                                  }),
                                  child: Column(
                                    children: [
                                      !data.image.validate().isEmptyOrNull
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  context.cardColor,
                                              backgroundImage: NetworkImage(
                                                  data.image.validate()),
                                              radius: 40)
                                          : CircleAvatar(
                                              backgroundColor:
                                                  context.cardColor,
                                              backgroundImage:
                                                  AssetImage(ic_placeHolder),
                                              maxRadius: 40),
                                      8.height,
                                      Text(data.name.validate(),
                                          style: boldTextStyle(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ).paddingRight(12),
                                ),
                              ),
                            ),
                          );
                        });
                }
                return snapWidgetHelper(snap, loadingWidget: SizedBox());
              }),
          AnimationLimiter(
            child: Stack(
              children: [
                getHomeWidget() == listCardType
                    ? ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        controller: scrollController,
                        itemCount: defaultPostResponseList.length,
                        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                        itemBuilder: (_, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 1,
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              verticalOffset: 20.0,
                              child: FadeInAnimation(
                                child: defaultCardConfig(
                                    context, defaultPostResponseList[index]),
                              ),
                            ),
                          );
                        },
                      )
                    : AnimationLimiter(
                        child: Wrap(
                          runSpacing: 8,
                          spacing: 8,
                          children: List.generate(
                            defaultPostResponseList.length,
                            (index) {
                              return AnimationConfiguration.staggeredGrid(
                                duration: const Duration(milliseconds: 750),
                                columnCount: 1,
                                position: index,
                                child: FlipAnimation(
                                  curve: Curves.linear,
                                  child: FadeInAnimation(
                                    child: defaultCardConfig(context,
                                        defaultPostResponseList[index]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ).paddingOnly(top: 16, left: 16, bottom: 16),
                      ),
                NoDataWidget(LanguageEn.lblNoBlogAvailable).visible(
                    !appStore.isLoading && defaultPostResponseList.isEmpty),
                Observer(builder: (context) {
                  return Loader().center().visible(appStore.isLoading);
                }),
              ],
            ),
          ).expand(),
        ],
      ),
    );
  }
}
