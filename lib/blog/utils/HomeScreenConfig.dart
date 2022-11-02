import 'dart:developer';

import 'package:flutter/material.dart';
import '../../main.dart';
import '../screen/Default/DefaultDashboardScreen.dart';
import '../screen/Fashion/FashionDashboardScreen.dart';
import '../screen/Fitness/FitnessDashboardScreen.dart';
import '../utils/AppConstant.dart';

import '../screen/Diy/DiyDashboardScreen.dart';
import '../screen/Finance/FinanceDashboardScreen.dart';
import '../screen/Fitness/FitnessDashboardScreen.dart';
import '../screen/Food/FoodDashboardScreen.dart';
import '../screen/LifeStyle/LifeStyleDashboardScreen.dart';
import '../screen/Music/MusicDashboardScreen.dart';
import '../screen/News/NewsDashboardScreen.dart';
import '../screen/Personal/PersonalDashboardScreen.dart';
import '../screen/Sport/SportDashboardScreen.dart';
import '../screen/Travel/TravelDashboardScreen.dart';

Widget getHomeWidget() {
  log("****Dashboard: ${dashboardStore.dashboardType}");
  if (dashboardStore.dashboardType == DEFAULT) {
    return DefaultDashboardScreen();
  } else if (dashboardStore.dashboardType == FASHION) {
    return FashionDashboardScreen();
  } else if (dashboardStore.dashboardType == FOOD) {
    return FoodDashboardScreen();
  } else if (dashboardStore.dashboardType == TRAVEL) {
    return TravelDashboardScreen();
  } else if (dashboardStore.dashboardType == MUSIC) {
    return MusicDashboardScreen();
  } else if (dashboardStore.dashboardType == LIFESTYLE) {
    return LifeStyleDashboardScreen();
  } else if (dashboardStore.dashboardType == FITNESS) {
    return FitnessDashboardScreen();
  } else if (dashboardStore.dashboardType == DIY) {
    return DiyDashboardScreen();
  } else if (dashboardStore.dashboardType == SPORTS) {
    return SportDashboardScreen();
  } else if (dashboardStore.dashboardType == FINANCE) {
    return FinanceDashboardScreen();
  } else if (dashboardStore.dashboardType == PERSONAL) {
    return PersonalDashboardScreen();
  } else if (dashboardStore.dashboardType == NEWS) {
    return NewsDashboardScreen();
  } else {
    return DefaultDashboardScreen();
  }
}
