part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default('') String username,
    String? avatar,
    @Default(false) bool isSavingUser,
    String? error,
  }) = _ProfileState;
}
