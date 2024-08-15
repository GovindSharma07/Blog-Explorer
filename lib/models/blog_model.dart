class BlogModel {
  final String id;
  final String image_url;
  final String title;

  BlogModel({required this.id, required this.image_url, required this.title});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
        id: json["id"]!, image_url: json["image_url"]!, title: json["title"]);
  }

  Map<String, String> toJson() {
    return {"id": id, "image_url": image_url, "title": title};
  }
}
