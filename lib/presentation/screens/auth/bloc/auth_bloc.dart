import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/repository/auth_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<_LoginRequested>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await _authRepository.login(event.username, event.password);
      } catch (_) {
        emit(state.copyWith(error: 'Failed to login'));
      }
      emit(state.copyWith(isLoading: false));
    }, transformer: droppable());

    on<_RegisterRequested>((event, emit) async {
      emit(const AuthState(isLoading: true));
      try {
        await _authRepository.register(event.username, event.password);
      } catch (_) {
        emit(const AuthState(error: 'Failed to register'));
      }
      emit(const AuthState(isLoading: false));
    }, transformer: droppable());
  }
}
