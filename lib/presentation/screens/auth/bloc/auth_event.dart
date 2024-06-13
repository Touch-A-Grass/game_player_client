part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginRequested() = _LoginRequested;

  const factory AuthEvent.registerRequested() = _RegisterRequested;
}
