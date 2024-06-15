import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/models/user.dart';
import 'package:game_player_client/data/repository/auth_repository.dart';
import 'package:game_player_client/presentation/util/bloc_util.dart';

part 'profile_event.dart';

part 'profile_state.dart';

part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with SubscriptionBloc {
  final AuthRepository _authRepository;

  ProfileBloc(this._authRepository) : super(const ProfileState()) {
    on<_Started>((event, emit) async {
      await _authRepository.fetchUser();
    });

    on<_UserChanged>((event, emit) {
      emit(state.copyWith(
        username: event.user?.username ?? '',
        avatar: event.user?.avatar ?? '',
      ));
    });

    on<_Logout>((event, emit) async {
      await _authRepository.logout();
    });

    subscribe(_authRepository.watchUser(), (event) {
      add(_UserChanged(event));
    });
  }
}
