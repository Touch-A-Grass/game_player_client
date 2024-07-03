import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill.freezed.dart';

part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill({
    required String name,
    required int value,
    required String attribute,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
