import 'package:game_player_client/presentation/navigation/common/navigation_state.dart';

sealed class RootNavigationState implements NavigationState<RootNavigationState> {
  final RootNavigationState? prevState;

  RootNavigationState(this.prevState);

  @override
  getPrevState() => prevState;
}

class AuthState extends RootNavigationState {
  AuthState(super.prevState);
}

class HomeState extends RootNavigationState {
  HomeState(super.prevState);
}
