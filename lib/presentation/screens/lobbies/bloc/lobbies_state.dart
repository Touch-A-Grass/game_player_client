part of 'lobbies_bloc.dart';

@freezed
class LobbiesState with _$LobbiesState {
  const LobbiesState._();

  const factory LobbiesState({
    @Default('') String code,
    @Default(6) int codeLength,
    @Default(false) bool isLoading,
    String? error,
  }) = _LobbiesState;

  bool get isValidCode => code.length == codeLength;
}
