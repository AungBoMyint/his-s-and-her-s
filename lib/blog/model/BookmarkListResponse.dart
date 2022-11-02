import 'DefaultPostResponse.dart';

class BookmarkListResponse {
  int? numPages;
  List<DefaultPostResponse>? posts;

  BookmarkListResponse({this.numPages, this.posts});

  BookmarkListResponse.fromJson(Map<String, dynamic> json) {
    numPages = json['num_pages'];
    if (json['posts'] != null) {
      posts = <DefaultPostResponse>[];
      json['posts'].forEach((v) {
        posts!.add(new DefaultPostResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num_pages'] = this.numPages;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

