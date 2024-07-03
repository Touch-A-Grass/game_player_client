import 'package:freezed_annotation/freezed_annotation.dart';

part 'roll.freezed.dart';

part 'roll.g.dart';

@freezed
class Roll with _$Roll {
  const factory Roll({
    @Default([]) List<int> dices,
  }) = _Roll;

  factory Roll.fromJson(Map<String, dynamic> json) => _$RollFromJson(json);
}

@freezed
class RollResult with _$RollResult {
  const factory RollResult({
    @Default([]) List<int> values,
  }) = _RollResult;

  factory RollResult.fromJson(Map<String, dynamic> json) => _$RollResultFromJson(json);
}
