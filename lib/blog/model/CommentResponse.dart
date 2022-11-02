class CommentResponse {
  int? id;
  int? post;
  int? parent;
  int? author;
  String? authorName;
  String? authorUrl;
  String? date;
  String? dateGmt;
  Content? content;
  String? link;
  String? status;
  String? type;
  AuthorAvatarUrls? authorAvatarUrls;
  Links? lLinks;

  CommentResponse(
      {this.id, this.post, this.parent, this.author, this.authorName, this.authorUrl, this.date, this.dateGmt, this.content, this.link, this.status, this.type, this.authorAvatarUrls, this.lLinks});

  CommentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post = json['post'];
    parent = json['parent'];
    author = json['author'];
    authorName = json['author_name'];
    authorUrl = json['author_url'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    content = json['content'] != null ? new Content.fromJson(json['content']) : null;
    link = json['link'];
    status = json['status'];
    type = json['type'];
    authorAvatarUrls = json['author_avatar_urls'] != null ? new AuthorAvatarUrls.fromJson(json['author_avatar_urls']) : null;
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post'] = this.post;
    data['parent'] = this.parent;
    data['author'] = this.author;
    data['author_name'] = this.authorName;
    data['author_url'] = this.authorUrl;
    data['date'] = this.date;
    data['date_gmt'] = this.dateGmt;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['link'] = this.link;
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.authorAvatarUrls != null) {
      data['author_avatar_urls'] = this.authorAvatarUrls!.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class Content {
  String? rendered;

  Content({this.rendered});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class AuthorAvatarUrls {
  String? s24;
  String? s48;
  String? s96;

  AuthorAvatarUrls({this.s24, this.s48, this.s96});

  AuthorAvatarUrls.fromJson(Map<String, dynamic> json) {
    s24 = json['24'];
    s48 = json['48'];
    s96 = json['96'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['24'] = this.s24;
    data['48'] = this.s48;
    data['96'] = this.s96;
    return data;
  }
}

class Links {
  List<Self>? self;
  List<Collection>? collection;
  List<Author>? author;
  List<Up>? up;

  Links({this.self, this.collection, this.author, this.up});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <Self>[];
      json['self'].forEach((v) {
        self!.add(new Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <Collection>[];
      json['collection'].forEach((v) {
        collection!.add(new Collection.fromJson(v));
      });
    }
    if (json['author'] != null) {
      author = <Author>[];
      json['author'].forEach((v) {
        author!.add(new Author.fromJson(v));
      });
    }
    if (json['up'] != null) {
      up = <Up>[];
      json['up'].forEach((v) {
        up!.add(new Up.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    if (this.author != null) {
      data['author'] = this.author!.map((v) => v.toJson()).toList();
    }
    if (this.up != null) {
      data['up'] = this.up!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Collection {
  String? href;

  Collection({this.href});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Author {
  bool? embeddable;
  String? href;

  Author({this.embeddable, this.href});

  Author.fromJson(Map<String, dynamic> json) {
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}

class Up {
  bool? embeddable;
  String? postType;
  String? href;

  Up({this.embeddable, this.postType, this.href});

  Up.fromJson(Map<String, dynamic> json) {
    embeddable = json['embeddable'];
    postType = json['post_type'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embeddable'] = this.embeddable;
    data['post_type'] = this.postType;
    data['href'] = this.href;
    return data;
  }
}
