import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../main.dart';
import '../component/CategoryComponent.dart';
import '../model/CategoryResponse.dart';
import '../model/DefaultPostResponse.dart';
import '../network/RestApi.dart';
import '../utils/AppConstant.dart';
import '../utils/DefaultCardConfig.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Loader.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../component/AppWidget.dart';
import '../utils/AppCommon.dart';
import '../utils/DefaultCardTypeConfig.dart';

class ViewAllScreen extends StatefulWidget {
  final String? name;
  final String? text;
  final int? authId;
  final int? tagId;
  final int? customId;
  final String? catData;

  ViewAllScreen(
      {this.name,
      this.text,
      this.authId,
      this.tagId,
      this.customId,
      this.catData});

  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  List<DefaultPostResponse> defaultPostResponseList = [];
  List<CategoryResponse> categoryResponse = [];
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
    !dashboardStore.enableCustomDashboard
        ? blogFilterApi(page,
                filter: widget.name.validate(),
                authId: widget.authId,
                tagId: widget.tagId,
                cat: widget.catData)
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
          })
        : customViewAllApi(widget.customId).then((value) {
            appStore.setLoading(false);
            isLoading = false;
            setState(() {});
            isLastPage = false;
            if (page == 1) {
              defaultPostResponseList.clear();
              categoryResponse.clear();
            }
            if (value.type == "post" || value.type == postVideoType) {
              Iterable it = value.data!;
              it.map((e) => defaultPostResponseList.add(e)).toList();
              log(defaultPostResponseList);
            } else {
              Iterable it = value.data!;
              it.map((e) => categoryResponse.add(e)).toList();
              log(categoryResponse);
            }
          }).catchError((e) {
            isLastPage = true;
            isLoading = false;
            setState(() {});
            appStore.setLoading(false);
          });
  }

  @override
  void didUpdateWidget(covariant ViewAllScreen oldWidget) {
    page = 1;
    loadBlogData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        widget.text.validate().isNotEmpty
            ? widget.text.capitalizeFirstLetter()
            : widget.name.capitalizeFirstLetter(),
        elevation: 0,
        showBack: true,
        textColor: Colors.white,
      ),
      body: SafeArea(
        child: AnimationLimiter(
          child: Stack(
            children: [
              defaultPostResponseList.isNotEmpty
                  ? getHomeWidget() == listCardType
                      ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: defaultPostResponseList.length,
                          padding: EdgeInsets.only(
                              left: 16, bottom: 8, right: 16, top: 16),
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
                      : SingleChildScrollView(
                          child: Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            children: List.generate(
                              defaultPostResponseList.length,
                              (index) {
                                return defaultCardConfig(
                                    context, defaultPostResponseList[index]);
                              },
                            ),
                          ).paddingOnly(top: 16, left: 16, bottom: 16),
                        )
                  : CategoryComponent(data: categoryResponse)
                      .paddingSymmetric(vertical: 16),
              Observer(builder: (context) {
                return Loader().center().visible(appStore.isLoading);
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: showBannerAds(),
    );
  }
}
