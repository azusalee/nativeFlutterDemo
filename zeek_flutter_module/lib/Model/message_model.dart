
class MessageModel {
  String title;
  String time;

  MessageModel({required this.title, required this.time});

  /// 从字典创建对象
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      title: json["title"],
      time: json["time"]
  );
}