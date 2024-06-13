import 'package:flutter/material.dart';
import 'package:game_player_client/presentation/navigation/common/page_mapper.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_state.dart';
import 'package:game_player_client/presentation/screens/auth/auth_screen.dart';
import 'package:game_player_client/presentation/screens/home/home_screen.dart';

class RootPageMapper extends PageMapper<RootNavigationState> {
  @override
  Page map(BuildContext context, RootNavigationState state) => switch (state) {
        AuthState _ => page(const AuthScreen()),
        HomeState _ => page(const HomeScreen()),
      };
}
