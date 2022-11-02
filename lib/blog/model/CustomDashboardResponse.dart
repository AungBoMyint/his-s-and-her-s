import '../model/DefaultPostResponse.dart';

import 'CategoryResponse.dart';

class CustomDashboardResponse {
  String? title;
  String? type;
  String? displayOption;
  List<String>? category;

  // List<Null>? author;
  // List<Null>? tags;
  String? orderby;
  List<dynamic>? data;
  bool? viewAll;

  CustomDashboardResponse(
      {this.title,
      this.type,
      this.displayOption,
      this.category,
      // this.author,
      // this.tags,
      this.orderby,
      this.data,
      this.viewAll});

  CustomDashboardResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    displayOption = json['display_option'];
    category = json['category'].cast<String>();
    // if (json['author'] != null) {
    //   author = <Null>[];
    //   json['author'].forEach((v) {
    //     author!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['tags'] != null) {
    //   tags = <Null>[];
    //   json['tags'].forEach((v) {
    //     tags!.add(new Null.fromJson(v));
    //   });
    // }
    orderby = json['orderby'];
    if (json['data'] != null) {
      data = <dynamic>[];
      print("typee" + type.toString());
      if (type == "category") {
        data = <CategoryResponse>[];
        json['data'].forEach((v) {
          data!.add(new CategoryResponse.fromJson(v));
        });
      } else {
        data = <DefaultPostResponse>[];
        json['data'].forEach((v) {
          data!.add(new DefaultPostResponse.fromJson(v));
        });
      }
    }
    viewAll = json['view_all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['display_option'] = this.displayOption;
    data['category'] = this.category;
    // if (this.author != null) {
    //   data['author'] = this.author!.map((v) => v.toJson()).toList();
    // }
    // if (this.tags != null) {
    //   data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    // }
    data['orderby'] = this.orderby;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['view_all'] = this.viewAll;
    return data;
  }
}
