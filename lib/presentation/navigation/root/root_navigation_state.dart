import 'package:game_player_client/presentation/navigation/common/navigation_state.dart';

sealed class RootNavigationState implements NavigationState<RootNavigationState> {
  final RootNavigationState? prevState;

  const RootNavigationState(this.prevState);

  @override
  getPrevState() => prevState;
}

class AuthState extends RootNavigationState {
  const AuthState(super.prevState);
}

class HomeState extends RootNavigationState {
  const HomeState(super.prevState);
}

class GameState extends RootNavigationState {
  const GameState(super.prevState);
}
