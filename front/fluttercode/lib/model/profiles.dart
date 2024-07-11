class ProfilesModel{
  int? id;
  String? fname;
  String? lname;
  String? email;
  User? user;
  Chunk? chunk;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  List<Posts>? posts;

  ProfilesModel(
      {this.id,
      this.fname,
      this.lname,
      this.email,
      this.user,
      this.chunk,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.posts});

  ProfilesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    chunk = json['chunk'] != null ? new Chunk.fromJson(json['chunk']) : null;
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.chunk != null) {
      data['chunk'] = this.chunk!.toJson();
    }
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  int? role;
  Null? profile;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.role,
      this.profile,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    role = json['role'];
    profile = json['profile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['role'] = this.role;
    data['profile'] = this.profile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

class Posts {
  int? id;
  String? title;
  String? desc;
  String? content;
  bool? chunkfixed;
  int? chunk;
  int? profile;
  int? category;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  List<Files>? files;

  Posts(
      {this.id,
      this.title,
      this.desc,
      this.content,
      this.chunkfixed,
      this.chunk,
      this.profile,
      this.category,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.files});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    content = json['content'];
    chunkfixed = json['chunkfixed'];
    chunk = json['chunk'];
    profile = json['profile'];
    category = json['category'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['content'] = this.content;
    data['chunkfixed'] = this.chunkfixed;
    data['chunk'] = this.chunk;
    data['profile'] = this.profile;
    data['category'] = this.category;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  int? id;
  String? name;
  String? alternativeText;
  String? caption;
  Null? width;
  Null? height;
  Null? formats;
  String? hash;
  String? ext;
  String? mime;
  double? size;
  String? url;
  Null? previewUrl;
  String? provider;
  Null? providerMetadata;
  String? createdAt;
  String? updatedAt;

  Files(
      {this.id,
      this.name,
      this.alternativeText,
      this.caption,
      this.width,
      this.height,
      this.formats,
      this.hash,
      this.ext,
      this.mime,
      this.size,
      this.url,
      this.previewUrl,
      this.provider,
      this.providerMetadata,
      this.createdAt,
      this.updatedAt});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    formats = json['formats'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    url = json['url'];
    previewUrl = json['previewUrl'];
    provider = json['provider'];
    providerMetadata = json['provider_metadata'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alternativeText'] = this.alternativeText;
    data['caption'] = this.caption;
    data['width'] = this.width;
    data['height'] = this.height;
    data['formats'] = this.formats;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['size'] = this.size;
    data['url'] = this.url;
    data['previewUrl'] = this.previewUrl;
    data['provider'] = this.provider;
    data['provider_metadata'] = this.providerMetadata;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
