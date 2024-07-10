class ProfileAttributes {
  String? fname;
  String? createdAt;
  String? updatedAt;
  String? lname;
  String? email;

  ProfileAttributes(
      {this.fname, this.createdAt, this.updatedAt, this.lname, this.email});

  ProfileAttributes.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lname = json['lname'];
    email = json['email'];
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