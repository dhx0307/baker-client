import '../basic/basic_data.dart';

class StackImage extends IacpPojo{
  final int? id;
  final String? title;
  String? imageUrl; //移除 final，允许后续修改

  StackImage({
    this.id,
    this.title,
    this.imageUrl,
  });

  factory StackImage.fromJson(Map<String, dynamic> json) {
    return StackImage(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
    };
    jsonMap.removeWhere((key, value) => value == null);
    return jsonMap;
  }
}