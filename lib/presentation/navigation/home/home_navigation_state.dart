import 'package:game_player_client/presentation/navigation/common/navigation_state.dart';

sealed class HomeNavigationState implements NavigationState<HomeNavigationState> {
  final HomeNavigationState? prevState;

  const HomeNavigationState(this.prevState);

  @override
  getPrevState() => prevState;
}

class LobbiesState extends HomeNavigationState {
  const LobbiesState() : super(null);
}

class ProfileState extends HomeNavigationState {
  const ProfileState() : super(null);
}
