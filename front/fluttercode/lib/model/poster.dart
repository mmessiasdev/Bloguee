class PosterAttributes {
  String? fname;
  String? createdAt;
  String? updatedAt;
  String? lname;
  String? email;

  PosterAttributes(
      {this.fname, this.createdAt, this.updatedAt, this.lname, this.email});

  PosterAttributes.fromJson(Map<String, dynamic> json) {
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