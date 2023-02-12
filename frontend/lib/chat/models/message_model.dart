class MessageModel {
  String text;
  String query;

  MessageModel({required this.text, this.query = "0"});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(text: json['message'], query: json['query']);
  }
}
