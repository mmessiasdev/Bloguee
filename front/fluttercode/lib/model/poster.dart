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
		attributes = json['attributes'] != null ? new Attributes.fromJson(json['attributes']) : null;
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
	String? desc;
	String? createdAt;
	String? updatedAt;
	String? content;
	Profile? profile;
	Profile? chunk;

	Attributes({this.title, this.desc, this.createdAt, this.updatedAt, this.content, this.profile, this.chunk});

	Attributes.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		desc = json['desc'];
		createdAt = json['createdAt'];
		updatedAt = json['updatedAt'];
		content = json['content'];
		profile = json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
		chunk = json['chunk'] != null ? new Profile.fromJson(json['chunk']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['desc'] = this.desc;
		data['createdAt'] = this.createdAt;
		data['updatedAt'] = this.updatedAt;
		data['content'] = this.content;
		if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
		if (this.chunk != null) {
      data['chunk'] = this.chunk!.toJson();
    }
		return data;
	}
}

class Profile {
	Data? data;

	Profile({this.data});

	Profile.fromJson(Map<String, dynamic> json) {
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

class AttributesProfile {
	String? fname;
	String? lname;
	String? createdAt;
	String? updatedAt;
	String? email;

	AttributesProfile({this.fname, this.lname, this.createdAt, this.updatedAt, this.email});

	AttributesProfile.fromJson(Map<String, dynamic> json) {
		fname = json['fname'];
		lname = json['lname'];
		createdAt = json['createdAt'];
		updatedAt = json['updatedAt'];
		email = json['email'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['fname'] = this.fname;
		data['lname'] = this.lname;
		data['createdAt'] = this.createdAt;
		data['updatedAt'] = this.updatedAt;
		data['email'] = this.email;
		return data;
	}
}

class AttributesChunk {
	String? title;
	String? createdAt;
	String? updatedAt;

	AttributesChunk({this.title, this.createdAt, this.updatedAt});

	AttributesChunk.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		createdAt = json['createdAt'];
		updatedAt = json['updatedAt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['createdAt'] = this.createdAt;
		data['updatedAt'] = this.updatedAt;
		return data;
	}
}


class AttributesPoster {
	String? title;
	String? desc;
	String? createdAt;
	String? updatedAt;
	String? content;
	Profile? profile;
	Profile? chunk;

	AttributesPoster({this.title, this.desc, this.createdAt, this.updatedAt, this.content, this.profile, this.chunk});

	AttributesPoster.fromJson(Map<String, dynamic> json) {
		title = json["attributes"]['title'];
		desc = json["attributes"]['desc'];
		createdAt = json["attributes"]['createdAt'];
		updatedAt = json["attributes"]['updatedAt'];
		content = json["attributes"]['content'];
		profile = json["attributes"]['profile'] != null ? new Profile.fromJson(json['profile']) : null;
		chunk = json["attributes"]['chunk'] != null ? new Profile.fromJson(json['chunk']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['desc'] = this.desc;
		data['createdAt'] = this.createdAt;
		data['updatedAt'] = this.updatedAt;
		data['content'] = this.content;
		if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
		if (this.chunk != null) {
      data['chunk'] = this.chunk!.toJson();
    }
		return data;
	}
}
