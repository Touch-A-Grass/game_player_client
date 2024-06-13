part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginRequested(String username, String password) = _LoginRequested;

  const factory AuthEvent.registerRequested(String username, String password) = _RegisterRequested;
}
