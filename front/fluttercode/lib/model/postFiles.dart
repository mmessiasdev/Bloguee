class PostFiles {
	String? name;
	Null alternativeText;
	Null caption;
	Null width;
	Null height;
	Null formats;
	String? hash;
	String? ext;
	String? mime;
	double? size;
	String? url;
	Null previewUrl;
	String? provider;
	String? createdAt;
	String? updatedAt;

	PostFiles({this.name, this.alternativeText, this.caption, this.width, this.height, this.formats, this.hash, this.ext, this.mime, this.size, this.url, this.previewUrl, this.provider, this.createdAt, this.updatedAt});

	PostFiles.fromJson(Map<String, dynamic> json) {
		name = json['attributes']['name'];
		alternativeText = json['attributes']['alternativeText'];
		caption = json['attributes']['caption'];
		width = json['attributes']['width'];
		height = json['attributes']['height'];
		formats = json['attributes']['formats'];
		hash = json['attributes']['hash'];
		ext = json['attributes']['ext'];
		mime = json['attributes']['mime'];
		size = json['attributes']['size'];
		url = json['attributes']['url'];
		previewUrl = json['attributes']['previewUrl'];
		provider = json['attributes']['provider'];
		createdAt = json['attributes']['createdAt'];
		updatedAt = json['attributes']['updatedAt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
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
		data['createdAt'] = this.createdAt;
		data['updatedAt'] = this.updatedAt;
		return data;
	}
}