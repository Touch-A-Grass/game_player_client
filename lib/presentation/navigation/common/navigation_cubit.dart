import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/navigation/common/navigation_state.dart';

mixin NavigationCubit<S extends NavigationState> on Cubit<S> {
  void syncState(S state) {
    emit(state);
  }

  void back() {
    final prevState = state.getPrevState();
    if (prevState != null) {
      emit(prevState);
    }
  }
}
