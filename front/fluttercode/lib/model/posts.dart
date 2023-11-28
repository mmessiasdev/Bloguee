class PostsAttributes {
  int? id;
  String? title;
  String? desc;
  String? content;
  int? pid;
  String? pfname;
  String? plname;
  String? pemail;
  String? cname;
  String? createdAt;
  String? updatedAt;

  PostsAttributes({
    this.id,
    this.title,
    this.desc,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.pid,
    this.pfname,
    this.plname,
    this.pemail,
    this.cname,
  });

  PostsAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['attributes']['title'];
    desc = json['attributes']['desc'];
    content = json['attributes']['content'];
    pid = json['attributes']['profile']['data']['id'];
    pfname = json['attributes']['profile']['data']['attributes']['fname'];
    plname = json['attributes']['profile']['data']['attributes']['lname'];
    pemail = json['attributes']['profile']['data']['attributes']['email'];
    cname = json['attributes']['chunk']['data']['attributes']['title'];
    createdAt = json['attributes']['createdAt'];
    updatedAt = json['attributes']['updatedAt'];  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['fname'] = this.pfname;
    data['lname'] = this.plname;
    data['email'] = this.pemail;
    data['title'] = this.cname;

    return data;
  }
}

// class Meta {
//   Pagination? pagination;

//   Meta({this.pagination});

//   Meta.fromJson(Map<String, dynamic> json) {
//     pagination = json['pagination'] != null
//         ? new Pagination.fromJson(json['pagination'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.pagination != null) {
//       data['pagination'] = this.pagination!.toJson();
//     }
//     return data;
//   }
// }

// class Pagination {
//   int? page;
//   int? pageSize;
//   int? pageCount;
//   int? total;

//   Pagination({this.page, this.pageSize, this.pageCount, this.total});

//   Pagination.fromJson(Map<String, dynamic> json) {
//     page = json['page'];
//     pageSize = json['pageSize'];
//     pageCount = json['pageCount'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['page'] = this.page;
//     data['pageSize'] = this.pageSize;
//     data['pageCount'] = this.pageCount;
//     data['total'] = this.total;
//     return data;
//   }
// }
