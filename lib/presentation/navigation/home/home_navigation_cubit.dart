import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/navigation/common/navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/home/home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> with NavigationCubit {
  HomeNavigationCubit() : super(const LobbiesState());

  void navigateToProfile() {
    emit(const ProfileState());
  }

  void navigateToLobbies() {
    emit(const LobbiesState());
  }
}
