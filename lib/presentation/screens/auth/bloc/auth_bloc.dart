import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<_LoginRequested>((event, emit) {
      emit(const AuthState(isLoading: true));
    });
    on<_RegisterRequested>((event, emit) {
      emit(const AuthState(isLoading: true));
    });
  }
}
