import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/navigation/common/navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_state.dart';

class RootNavigationCubit extends Cubit<RootNavigationState> with NavigationCubit {
  RootNavigationCubit() : super(HomeState(null));
}
