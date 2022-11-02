import '../utils/AppImages.dart';

import '../utils/AppConstant.dart';

class ServerModal {
  String? title;
  String? url;
  String? img;
  String? type;

  ServerModal(this.title, this.url, this.img, this.type);
}

List<ServerModal> mServerList = [
  ServerModal("Blog", "https://hisandher.info/wp-json/", ic_blog, DEFAULT),
  ServerModal(
      "Fashion", "https://hisandher.info/wp-json/", ic_fashion, FASHION),
  ServerModal("Food", "https://hisandher.info/wp-json/", ic_food, FOOD),
  ServerModal("Travel", "https://hisandher.info/wp-json/", ic_travel, TRAVEL),
  ServerModal("Music", "https://hisandher.info/wp-json/", ic_music, MUSIC),
  ServerModal(
      "LifeStyle", "https://hisandher.info/wp-json/", ic_lifestyle, LIFESTYLE),
  ServerModal(
      "Fitness", "https://hisandher.info/wp-json/", ic_fitness, FITNESS),
  ServerModal("Diy", "https://hisandher.info/wp-json/", ic_diy, DIY),
  ServerModal("Sports", "https://hisandher.info/wp-json/", ic_sport, SPORTS),
  ServerModal(
      "Finance", "https://hisandher.info/wp-json/", ic_finance, FINANCE),
  ServerModal(
      "Personal", "https://hisandher.info/wp-json/", ic_personal, PERSONAL),
  ServerModal("News", "https://hisandher.info/wp-json/", ic_news, NEWS),
];
