class Autogenerated {
  Data? data;

  Autogenerated({this.data});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  Attributes? attributes;

  Data({this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? title;
  String? createdAt;
  String? updatedAt;
  String? subtitle;

  Attributes({this.title, this.createdAt, this.updatedAt, this.subtitle});

  Attributes.fromJson(Map<String, dynamic> json) {
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

class ProfileAttributes {
  String? fname;
  String? createdAt;
  String? updatedAt;
  String? lname;
  String? email;

  ProfileAttributes(
      {this.fname, this.createdAt, this.updatedAt, this.lname, this.email});

  ProfileAttributes.fromJson(Map<String, dynamic> json) {
    fname = json['attributes']['fname'];
    createdAt = json['attributes']['createdAt'];
    updatedAt = json['attributes']['updatedAt'];
    lname = json['attributes']['lname'];
    email = json['attributes']['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['lname'] = this.lname;
    data['email'] = this.email;

    return data;
  }
}
