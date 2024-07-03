import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute.freezed.dart';

part 'attribute.g.dart';

enum AttributeType {
  string,
  int,
  bool,
}

@freezed
class Attribute with _$Attribute {
  const factory Attribute({
    required String name,
    required String value,
    required AttributeType type,
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}
