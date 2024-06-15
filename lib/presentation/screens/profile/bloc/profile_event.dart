part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;

  const factory ProfileEvent.logout() = _Logout;

  const factory ProfileEvent.userChanged(User? user) = _UserChanged;
}
