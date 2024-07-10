
class PostsAttributes {
  int? id;
  String? title;
  String? desc;
  String? content;
  String? plname;
  bool? chunkfixed;
  Chunk? chunk;
  Profile? profile;
  Category? category;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  PostsAttributes(
      {this.id,
      this.title,
      this.desc,
      this.content,
      this.plname,
      this.chunkfixed,
      this.chunk,
      this.profile,
      this.category,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,});

  PostsAttributes.fromJson(Map<String, dynamic> json) {
    id = json['data']['id'];
    title = json['data']['title'];
    desc = json['data']['desc'];
    content = json['data']['content'];
    plname = json['data']['profile']['lname'];
    chunkfixed = json['data']['chunkfixed'];
    chunk = json['data']['chunk'] != null ? new Chunk.fromJson(json['data']['chunk']) : null;
    profile =
        json['data']['profile'] != null ? new Profile.fromJson(json['data']['profile']) : null;
    category = json['data']['category'] != null
        ? new Category.fromJson(json['data']['category'])
        : null;
    publishedAt = json['data']['published_at'];
    createdAt = json['data']['created_at'];
    updatedAt = json['data']['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data']['id'] = this.id;
    data['data']['title'] = this.title;
    data['data']['desc'] = this.desc;
    data['data']['content'] = this.content;
    data['data']['chunkfixed'] = this.chunkfixed;
    if (this.chunk != null) {
      data['data']['chunk'] = this.chunk!.toJson();
    }
    if (this.profile != null) {
      data['data']['profile'] = this.profile!.toJson();
    }
    if (this.category != null) {
      data['data']['category'] = this.category!.toJson();
    }
    data['data']['published_at'] = this.publishedAt;
    data['data']['created_at'] = this.createdAt;
    data['data']['updated_at'] = this.updatedAt;
    return data;
  }
}

class Chunk {
  int? id;
  String? title;
  String? subtitle;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Chunk(
      {this.id,
      this.title,
      this.subtitle,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Chunk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Profile {
  int? id;
  String? fname;
  String? lname;
  String? email;
  int? user;
  int? chunk;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.fname,
      this.lname,
      this.email,
      this.user,
      this.chunk,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    user = json['user'];
    chunk = json['chunk'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['user'] = this.user;
    data['chunk'] = this.chunk;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  int? chunk;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.name,
      this.chunk,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    chunk = json['chunk'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['chunk'] = this.chunk;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
