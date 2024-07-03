import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/repository/auth_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository _authRepository;

  HomeBloc(this._authRepository) : super(const HomeState()) {
    on<_Started>((event, emit) {
      _authRepository.fetchUser();
    });
  }
}
