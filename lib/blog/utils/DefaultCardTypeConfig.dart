import '../../main.dart';
import '../utils/AppConstant.dart';

String getHomeWidget() {
  if (dashboardStore.dashboardType == DEFAULT) {
    return listCardType;
  } else if (dashboardStore.dashboardType == FASHION) {
    return gridCardType;
  } else if (dashboardStore.dashboardType == FOOD) {
    return listCardType;
  } else if (dashboardStore.dashboardType == TRAVEL) {
    return listCardType;
  } else if (dashboardStore.dashboardType == MUSIC) {
    return listCardType;
  } else if (dashboardStore.dashboardType == LIFESTYLE) {
    return gridCardType;
  } else if (dashboardStore.dashboardType == FITNESS) {
    return listCardType;
  } else if (dashboardStore.dashboardType == DIY) {
    return listCardType;
  } else if (dashboardStore.dashboardType == SPORTS) {
    return gridCardType;
  } else if (dashboardStore.dashboardType == FINANCE) {
    return gridCardType;
  } else if (dashboardStore.dashboardType == PERSONAL) {
    return listCardType;
  } else if (dashboardStore.dashboardType == NEWS) {
    return listCardType;
  } else {
    return listCardType;
  }
}
