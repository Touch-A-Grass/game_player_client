part of 'stats_bloc.dart';

@freezed
class StatsEvent with _$StatsEvent {
  const factory StatsEvent.started() = _Started;

  const factory StatsEvent.characterChanged(Character? character) = _CharacterChanged;
}
