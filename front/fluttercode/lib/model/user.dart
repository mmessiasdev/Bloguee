import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  int? id;
  String? email;
  String? createdAt;
  String? updatedAt;
  Null? age;
  String? fullName;
  Null? image;

  User(
      {this.id,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.age,
      this.fullName,
      this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    age = json['age'];
    fullName = json['fullName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['age'] = this.age;
    data['fullName'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}

