import '../model/DefaultPostResponse.dart';

class CategoryResponse {
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
  int? catID;
  int? categoryCount;
  String? categoryDescription;
  String? catName;
  String? categoryNicename;
  int? categoryParent;
  String? image;
  bool? isSelected = false;
  List<DefaultPostResponse>? blog;

  CategoryResponse(
      {this.termId,
      this.name,
      this.slug,
      this.termGroup,
      this.termTaxonomyId,
      this.taxonomy,
      this.description,
      this.parent,
      this.count,
      this.filter,
      this.catID,
      this.categoryCount,
      this.categoryDescription,
      this.catName,
      this.categoryNicename,
      this.categoryParent,
      this.image,
      this.isSelected,
      this.blog});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
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
    catID = json['cat_ID'];
    categoryCount = json['category_count'];
    categoryDescription = json['category_description'];
    catName = json['cat_name'];
    categoryNicename = json['category_nicename'];
    categoryParent = json['category_parent'];
    image = json['image'];
    if (json['blog'] != null) {
      blog = <DefaultPostResponse>[];
      json['blog'].forEach((v) {
        blog!.add(new DefaultPostResponse.fromJson(v));
      });
    }
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
    data['cat_ID'] = this.catID;
    data['category_count'] = this.categoryCount;
    data['category_description'] = this.categoryDescription;
    data['cat_name'] = this.catName;
    data['category_nicename'] = this.categoryNicename;
    data['category_parent'] = this.categoryParent;
    data['image'] = this.image;
    if (this.blog != null) {
      data['blog'] = this.blog!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
