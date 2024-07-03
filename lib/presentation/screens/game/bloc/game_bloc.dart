import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/models/character.dart';
import 'package:game_player_client/data/models/lobby.dart';
import 'package:game_player_client/data/models/roll.dart';
import 'package:game_player_client/data/repository/lobby_repository.dart';
import 'package:game_player_client/presentation/util/bloc_util.dart';

part 'game_event.dart';

part 'game_state.dart';

part 'game_bloc.freezed.dart';

class GameBloc extends Bloc<GameEvent, GameState> with SubscriptionBloc {
  final LobbyRepository _lobbyRepository;

  GameBloc(this._lobbyRepository) : super(const GameState()) {
    on<_Started>((event, emit) {});
    on<_Leave>((event, emit) async {
      await _lobbyRepository.leave();
    });
    on<_RollChanged>((event, emit) {
      emit(state.copyWith(roll: event.roll));
    });
    on<_RollCompleted>((event, emit) {
      _lobbyRepository.completeRoll(event.result);
      emit(state.copyWith(roll: null));
    });

    subscribe(_lobbyRepository.watchRoll(), (roll) {
      add(GameEvent.rollChanged(roll));
    });
  }
}
