part of 'game_bloc.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    Character? character,
    Lobby? lobby,
    Roll? roll,
  }) = _GameState;
}
