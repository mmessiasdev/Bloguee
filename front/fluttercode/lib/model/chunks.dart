class ChunksAttributes {
  String? title;
  String? createdAt;
  String? updatedAt;
  String? subtitle;

  ChunksAttributes({this.title, this.createdAt, this.updatedAt, this.subtitle});

  ChunksAttributes.fromJson(Map<String, dynamic> json) {
    title = json['attributes']['title'];
    createdAt = json['attributes']['createdAt'];
    updatedAt = json['attributes']['updatedAt'];
    subtitle = json['attributes']['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['subtitle'] = this.subtitle;
    return data;
  }
}

// class PostsAttributes {
//   int? id;
//   String? title;
//   String? desc;
//   String? content;
//   String? createdAt;
//   String? updatedAt;
//   bool? chunkfixed;

//   PostsAttributes(
//       {this.id,
//       this.title,
//       this.desc,
//       this.content,
//       this.createdAt,
//       this.updatedAt,
//       this.chunkfixed});

//   PostsAttributes.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['attributes']['title'];
//     desc = json['attributes']['desc'];
//     content = json['attributes']['content'];
//     createdAt = json['attributes']['createdAt'];
//     updatedAt = json['attributes']['updatedAt'];
//     chunkfixed = json['attributes']['chunkfixed'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['desc'] = this.desc;
//     data['content'] = this.content;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['id'] = this.id;
//     data['chunkfixed'] = this.chunkfixed;

//     return data;
//   }
// }
