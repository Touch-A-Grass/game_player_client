import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/models/attribute.dart';
import 'package:game_player_client/data/models/skill.dart';

part 'character.freezed.dart';

part 'character.g.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String id,
    required String name,
    required String description,
    required String user,
    required List<Skill> skills,
    required List<Attribute> attributes,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
}
