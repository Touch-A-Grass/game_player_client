import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/data/models/lobby.dart';
import 'package:game_player_client/data/repository/lobby_repository.dart';
import 'package:game_player_client/data/storage/token_storage.dart';
import 'package:game_player_client/presentation/navigation/common/navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_state.dart';
import 'package:game_player_client/presentation/util/bloc_util.dart';
import 'package:rxdart/rxdart.dart';

class NavigationStreamState {
  final String? token;
  final Lobby? lobby;

  const NavigationStreamState(this.token, this.lobby);
}

class RootNavigationCubit extends Cubit<RootNavigationState> with NavigationCubit, SubscriptionBloc {
  final TokenStorage _tokenStorage;
  final LobbyRepository _lobbyRepository;

  RootNavigationCubit(this._tokenStorage, this._lobbyRepository) : super(const HomeState(null)) {
    subscribe(
      Rx.combineLatest2(
        _tokenStorage.watch(),
        _lobbyRepository.watchLobby(),
        (token, lobby) => NavigationStreamState(token, lobby),
      ),
      (status) {
        if (status.lobby != null && status.token != null && state is! GameState) {
          emit(const GameState(null));
          return;
        }
        if (status.token != null && state is! HomeState) {
          emit(const HomeState(null));
        } else if (status.token == null && state is! AuthState) {
          emit(const AuthState(null));
        }
      },
    );
  }
}
