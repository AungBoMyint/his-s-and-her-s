import 'package:get/route_manager.dart';

import '../binding/expert_binding.dart';
import '../screen/create_expert.dart';
import '../screen/manage.dart';
import '../screen/purchase.dart';
import '../screen/template.dart';


const String homePage = '/home';
const String detailPage = '/detail';
const String bookingPage = '/booking';
const String createExpertPage = '/createExpertPage';
const String purchasePage = '/purchasePage';
const String managePage = '/managePage';
List<GetPage> routes = [
  GetPage(
    name: homePage,
    page: () => Template(),
    // binding: TemplateBinding(),
  ),
  // GetPage(
  //   name: detailPage,
  //   page: () => DetailPage(),
  //   // binding: TemplateBinding(),
  // ),
  // GetPage(
  //   name: bookingPage,
  //   page: () => BookingPage(),
  //   // binding: TemplateBinding(),
  // ),
  GetPage(
    name: createExpertPage,
    page: () => CreateExpertPage(),
    binding: ExpertBinding(),
  ),
  GetPage(
    name: purchasePage,
    page: () => PurchasePage(),
  ),
  GetPage(
    name: managePage,
    page: () => ManagePage(),
  ),
];
