class PostSearch {
  int? id;
  String? title;
  String? desc;
  String? content;
  bool? chunkfixed;
  Chunk? chunk;
  Profile? profile;
  Category? category;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  List<Files>? files;

  PostSearch(
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

  PostSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    content = json['content'];
    chunkfixed = json['chunkfixed'];
    chunk = json['chunk'] != null ? new Chunk.fromJson(json['chunk']) : null;
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
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
    if (this.chunk != null) {
      data['chunk'] = this.chunk!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
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
