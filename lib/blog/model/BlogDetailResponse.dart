import 'CategoryResponse.dart';
import 'DefaultPostResponse.dart';

class BlogDetailResponse {
  int? iD;
  String? image;
  String? fullImage;
  String? postTitle;
  String? postType;
  String? postContent;
  String? postExcerpt;
  String? postDate;
  String? postDateGmt;
  String? readableDate;
  String? shareUrl;
  String? humanTimeDiff;
  String? noOfComments;
  String? noOfCommentsText;
  bool? isBookmark;
  bool? isLike;
  int? likeCount;
  int? postAuthorId;
  String? postAuthorName;
  int? mbPostView;
  bool? isStory;
  List<CategoryResponse>? category;
  List<Tags>? tags;
  List<DefaultPostResponse>? relatedNews;

  BlogDetailResponse(
      {this.iD,
      this.image,
      this.fullImage,
      this.postTitle,
      this.postType,
      this.postContent,
      this.postExcerpt,
      this.postDate,
      this.postDateGmt,
      this.readableDate,
      this.shareUrl,
      this.humanTimeDiff,
      this.noOfComments,
      this.noOfCommentsText,
      this.isBookmark,
      this.isLike,
      this.likeCount,
      this.postAuthorId,
      this.postAuthorName,
      this.mbPostView,
      this.isStory,
      this.category,
      this.tags,
      this.relatedNews});

  BlogDetailResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    image = json['image'];
    fullImage = json['full_image'];
    postTitle = json['post_title'];
    postType = json['post_type'];
    postContent = json['post_content'];
    postExcerpt = json['post_excerpt'];
    postDate = json['post_date'];
    postDateGmt = json['post_date_gmt'];
    readableDate = json['readable_date'];
    shareUrl = json['share_url'];
    humanTimeDiff = json['human_time_diff'];
    noOfComments = json['no_of_comments'];
    noOfCommentsText = json['no_of_comments_text'];
    isBookmark = json['is_bookmark'];
    isLike = json['is_like'];
    likeCount = json['like_count'];
    postAuthorId = json['post_author_id'];
    postAuthorName = json['post_author_name'];
    mbPostView = json['mb_post_view'];
    isStory = json['is_story'];
    if (json['category'] != null) {
      category = <CategoryResponse>[];
      json['category'].forEach((v) {
        category!.add(new CategoryResponse.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    if (json['related_news'] != null) {
      relatedNews = <DefaultPostResponse>[];
      json['related_news'].forEach((v) {
        relatedNews!.add(new DefaultPostResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['image'] = this.image;
    data['full_image'] = this.fullImage;
    data['post_title'] = this.postTitle;
    data['post_type'] = this.postType;
    data['post_content'] = this.postContent;
    data['post_excerpt'] = this.postExcerpt;
    data['post_date'] = this.postDate;
    data['post_date_gmt'] = this.postDateGmt;
    data['readable_date'] = this.readableDate;
    data['share_url'] = this.shareUrl;
    data['human_time_diff'] = this.humanTimeDiff;
    data['no_of_comments'] = this.noOfComments;
    data['no_of_comments_text'] = this.noOfCommentsText;
    data['is_bookmark'] = this.isBookmark;
    data['is_like'] = this.isLike;
    data['like_count'] = this.likeCount;
    data['post_author_id'] = this.postAuthorId;
    data['post_author_name'] = this.postAuthorName;
    data['mb_post_view'] = this.mbPostView;
    data['is_story'] = this.isStory;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.relatedNews != null) {
      data['related_news'] = this.relatedNews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;

  Tags({this.termId, this.name, this.slug, this.termGroup, this.termTaxonomyId, this.taxonomy, this.description, this.parent, this.count, this.filter});

  Tags.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_id'] = this.termId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['term_group'] = this.termGroup;
    data['term_taxonomy_id'] = this.termTaxonomyId;
    data['taxonomy'] = this.taxonomy;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['count'] = this.count;
    data['filter'] = this.filter;
    return data;
  }
}
