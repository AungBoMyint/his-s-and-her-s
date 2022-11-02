import '../../main.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/Widget_extensions.dart';

import '../screen/Default/DefaultDetailScreen.dart';
import '../screen/Diy/DiyDetailScreen.dart';
import '../screen/Fashion/FashionDetailScreen.dart';
import '../screen/Finance/FinanceDetailScreen.dart';
import '../screen/Fitness/FitnessDetailScreen.dart';
import '../screen/Food/FoodDetailScreen.dart';
import '../screen/LifeStyle/LifeStyleDetailScreen.dart';
import '../screen/Music/MusicDetailScreen.dart';
import '../screen/News/NewsDetailScreen.dart';
import '../screen/Personal/PersonalDetailScreen.dart';
import '../screen/Sport/SportDetailScreen.dart';
import '../screen/Travel/TravelDetailScreen.dart';

getDetailScreenWidget(context, data) {
  if (dashboardStore.dashboardType == DEFAULT) {
    return DefaultDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == FASHION) {
    return FashionDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == FOOD) {
    return FoodDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == TRAVEL) {
    return TravelDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == MUSIC) {
    return MusicDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == LIFESTYLE) {
    return LifeStyleDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == FITNESS) {
    return FitnessDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == DIY) {
    return DiyDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == SPORTS) {
    return SportDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == FINANCE) {
    return FinanceDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == PERSONAL) {
    return PersonalDetailScreen(postId: data.iD).launch(context);
  } else if (dashboardStore.dashboardType == NEWS) {
    return NewsDetailScreen(postId: data.iD).launch(context);
  } else {
    return DefaultDetailScreen(postId: data.iD).launch(context);
  }
}
