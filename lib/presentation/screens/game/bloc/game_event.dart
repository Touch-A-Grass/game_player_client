part of 'game_bloc.dart';

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent.started() = _Started;

  const factory GameEvent.leave() = _Leave;

  const factory GameEvent.rollChanged(Roll? roll) = _RollChanged;

  const factory GameEvent.rollCompleted(RollResult result) = _RollCompleted;
}
