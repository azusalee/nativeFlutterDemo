class FormItemModel {
  String title;
  String subTitle;
  String hint;

  FormItemModel({required this.title, required this.subTitle, required this.hint});

  /// 从字典创建对象
  factory FormItemModel.fromJson(Map<String, dynamic> json) => FormItemModel(
      title: json["title"],
      subTitle: json["subTitle"],
      hint: json["hint"]
  );
}