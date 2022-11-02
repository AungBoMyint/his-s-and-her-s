
import '../utils/AppImages.dart';

class BlogTypeModel {
  final String title;
  final String url;
  final String img;

  BlogTypeModel(this.title, this.url, this.img);
}

List<BlogTypeModel> mTypeList = [
  BlogTypeModel("Blog", "https://meetmighty.com/mobile/mightystore/wp-json/", ic_placeHolder),
  BlogTypeModel("Fashion", "https://meetmighty.com/mobile/mightygrocery/wp-json/", ic_placeHolder),
  BlogTypeModel("Food", "https://meetmighty.com/mobile/health-nutrition/wp-json/",  ic_placeHolder),
  BlogTypeModel("Travel", "https://meetmighty.com/mobile/smartwatch/wp-json/",  ic_placeHolder),
  BlogTypeModel("Music", "https://meetmighty.com/mobile/mobile-cover/wp-json/", ic_placeHolder),
  BlogTypeModel("LifeStyle", "https://meetmighty.com/mobile/energy-drink/wp-json/",  ic_placeHolder),
  BlogTypeModel("Fitness", "https://meetmighty.com/mobile/mightypharmacy/wp-json/",  ic_placeHolder),
  BlogTypeModel("Diy", "https://meetmighty.com/mobile/cycle-store/wp-json/",  ic_placeHolder),
  BlogTypeModel("Sports", "https://meetmighty.com/mobile/cycle-store/wp-json/",  ic_placeHolder),
  BlogTypeModel("Finance", "https://meetmighty.com/mobile/cycle-store/wp-json/",  ic_placeHolder),
  BlogTypeModel("Personal", "https://meetmighty.com/mobile/cycle-store/wp-json/",  ic_placeHolder),
  BlogTypeModel("News", "https://meetmighty.com/mobile/cycle-store/wp-json/",  ic_placeHolder),
];
