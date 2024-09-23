import 'dart:convert';

class MyImage {
  final String imageName;
  final String downloadUrl;

  const MyImage({
    required this.imageName,
    required this.downloadUrl,
  });

  factory MyImage.fromJson(String source) =>
      MyImage.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(covariant MyImage other) {
    if (identical(this, other)) return true;

    return other.imageName == imageName && other.downloadUrl == downloadUrl;
  }

  @override
  int get hashCode => imageName.hashCode ^ downloadUrl.hashCode;

  @override
  String toString() => 'MyImage(imageName: $imageName, downloadUrl: $downloadUrl)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageName': imageName,
      'downloadUrl': downloadUrl,
    };
  }

  factory MyImage.fromMap(Map<String, dynamic> map) {
    return MyImage(
      imageName: map['imageName'] as String,
      downloadUrl: map['downloadUrl'] as String,
    );
  }
}
