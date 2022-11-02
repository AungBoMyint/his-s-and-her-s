class AddBookmarkResponse {
  bool? isBookmark;
  String? message;

  AddBookmarkResponse({this.isBookmark, this.message});

  AddBookmarkResponse.fromJson(Map<String, dynamic> json) {
    isBookmark = json['is_bookmark'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_bookmark'] = this.isBookmark;
    data['message'] = this.message;
    return data;
  }
}
