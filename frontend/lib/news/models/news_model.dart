class NewsModel {
  String? title;
  String? image;
  String? time;
  String? desc;

  NewsModel({this.title, this.image, this.time, this.desc});

  NewsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    time = json['time'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['image'] = image;
    data['time'] = time;
    data['desc'] = desc;
    return data;
  }
}
