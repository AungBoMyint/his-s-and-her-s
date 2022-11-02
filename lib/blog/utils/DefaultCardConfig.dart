import 'package:flutter/material.dart';
import '../../main.dart';
import '../component/Default/DefaultBlogItemWidget.dart';
import '../component/Fashion/FashionRecentComponent.dart';
import '../component/LifeStyle/LifeStyleBlogItemWidget.dart';
import '../component/Music/MusicSuggestForYouComponent.dart';
import '../component/News/NewsSuggestForYouComponent.dart';
import '../component/Personal/PersonalFeatureComponent.dart';
import '../component/Travel/TravelFeaturedComponent.dart';
import '../model/DefaultPostResponse.dart';
import '../screen/Fitness/FitnessDetailScreen.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../component/Diy/DiyFeaturedComponent.dart';
import '../component/Finance/FinanceFeatureComponent.dart';
import '../component/Fitness/FitnessSuggestForYouComponent.dart';
import '../component/Food/FoodBlogItemWidget.dart';
import '../component/Sport/SportSuggestForYouComponent.dart';
import '../screen/Food/FoodDetailScreen.dart';

Widget defaultCardConfig(
    BuildContext context, DefaultPostResponse defaultPostResponseList) {
  if (dashboardStore.dashboardType == DEFAULT) {
    return DefaultBlogItemWidget(defaultPostResponseList);
  } else if (dashboardStore.dashboardType == FASHION) {
    return FashionRecentComponent(defaultPostResponseList, isSlider: false);
  } else if (dashboardStore.dashboardType == FOOD) {
    return FoodBlogItemWidget(
      defaultPostResponseList,
      onCall: () {
        FoodDetailScreen(postId: defaultPostResponseList.iD).launch(context);
      },
    );
  } else if (dashboardStore.dashboardType == TRAVEL) {
    return TravelFeaturedComponent(defaultPostResponseList, isCardConfig: true);
  } else if (dashboardStore.dashboardType == MUSIC) {
    return MusicSuggestForYouComponent(defaultPostResponseList);
  } else if (dashboardStore.dashboardType == LIFESTYLE) {
    return LifeStyleBlogItemWidget(defaultPostResponseList, isConfig: true);
  } else if (dashboardStore.dashboardType == FITNESS) {
    return FitnessSuggestForYouComponent(
      defaultPostResponseList,
      isEven: false,
      isConfig: true,
      onCall: () {
        FitnessDetailScreen(postId: defaultPostResponseList.iD).launch(context);
      },
    );
  } else if (dashboardStore.dashboardType == DIY) {
    return DiyFeaturedComponent(defaultPostResponseList);
  } else if (dashboardStore.dashboardType == SPORTS) {
    return SportSuggestForYouComponent(defaultPostResponseList);
  } else if (dashboardStore.dashboardType == FINANCE) {
    return FinanceFeatureComponent(
      defaultPostResponseList,
    );
  } else if (dashboardStore.dashboardType == PERSONAL) {
    return PersonalFeatureComponent(
      defaultPostResponseList,
      isSlider: false,
      isEven: true,
    );
  } else if (dashboardStore.dashboardType == NEWS) {
    return NewsSuggestForYouComponent(defaultPostResponseList);
  } else {
    return DefaultBlogItemWidget(defaultPostResponseList);
  }
}
