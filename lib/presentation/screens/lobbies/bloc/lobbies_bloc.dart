import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/repository/lobby_repository.dart';

part 'lobbies_event.dart';

part 'lobbies_state.dart';

part 'lobbies_bloc.freezed.dart';

class LobbiesBloc extends Bloc<LobbiesEvent, LobbiesState> {
  final LobbyRepository _lobbyRepository;

  LobbiesBloc(this._lobbyRepository) : super(const LobbiesState()) {
    on<_CodeChanged>((event, emit) {
      emit(state.copyWith(code: event.code.trim().toUpperCase()));
    });

    on<_JoinRequested>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await _lobbyRepository.join(state.code);
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
      emit(state.copyWith(isLoading: false, error: null));
    });
  }
}
