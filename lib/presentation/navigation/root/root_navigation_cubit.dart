import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/data/storage/token_storage.dart';
import 'package:game_player_client/presentation/navigation/common/navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_state.dart';
import 'package:game_player_client/presentation/util/bloc_util.dart';

class RootNavigationCubit extends Cubit<RootNavigationState> with NavigationCubit, SubscriptionBloc {
  final TokenStorage _tokenStorage;

  RootNavigationCubit(this._tokenStorage) : super(const HomeState(null)) {
    subscribe(_tokenStorage.watch(), (token) {
      if (token != null && state is AuthState) {
        emit(const HomeState(null));
      } else if (token == null && state is! AuthState) {
        emit(const AuthState(null));
      }
    });
  }
}
