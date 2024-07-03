import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/models/character.dart';
import 'package:game_player_client/data/repository/lobby_repository.dart';
import 'package:game_player_client/presentation/util/bloc_util.dart';

part 'stats_event.dart';

part 'stats_state.dart';

part 'stats_bloc.freezed.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> with SubscriptionBloc {
  final LobbyRepository _lobbyRepository;

  StatsBloc(this._lobbyRepository) : super(const StatsState()) {
    on<_Started>((event, emit) {});

    on<_CharacterChanged>((event, emit) {
      emit(state.copyWith(character: event.character));
    });

    subscribe(_lobbyRepository.watchMyCharacter(), (character) => add(_CharacterChanged(character)));
  }
}
