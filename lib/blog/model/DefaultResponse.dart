import 'CategoryResponse.dart';
import 'DefaultPostResponse.dart';

class DefaultResponse {
  int? recentNumPages;
  List<DefaultPostResponse>? recentPost;
  int? featureNumPages;
  List<DefaultPostResponse>? featurePost;
  int? storyNumPages;
  List<DefaultPostResponse>? storyPost;
  List<CategoryResponse>? category;

  DefaultResponse({this.recentNumPages, this.recentPost, this.featureNumPages, this.featurePost, this.storyNumPages, this.storyPost, this.category});

  DefaultResponse.fromJson(Map<String, dynamic> json) {
    recentNumPages = json['recent_num_pages'];
    if (json['recent_post'] != null) {
      recentPost = <DefaultPostResponse>[];
      json['recent_post'].forEach((v) {
        recentPost!.add(new DefaultPostResponse.fromJson(v));
      });
    }
    featureNumPages = json['feature_num_pages'];
    if (json['feature_post'] != null) {
      featurePost = <DefaultPostResponse>[];
      json['feature_post'].forEach((v) {
        featurePost!.add(new DefaultPostResponse.fromJson(v));
      });
    }
    storyNumPages = json['story_num_pages'];
    if (json['story_post'] != null) {
      storyPost = <DefaultPostResponse>[];
      json['story_post'].forEach((v) {
        storyPost!.add(new DefaultPostResponse.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <CategoryResponse>[];
      json['category'].forEach((v) {
        category!.add(new CategoryResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recent_num_pages'] = this.recentNumPages;
    if (this.recentPost != null) {
      data['recent_post'] = this.recentPost!.map((v) => v.toJson()).toList();
    }
    data['feature_num_pages'] = this.featureNumPages;
    if (this.featurePost != null) {
      data['feature_post'] = this.featurePost!.map((v) => v.toJson()).toList();
    }
    data['story_num_pages'] = this.storyNumPages;
    if (this.storyPost != null) {
      data['story_post'] = this.storyPost!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
