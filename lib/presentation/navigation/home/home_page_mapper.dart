import 'package:flutter/material.dart';
import 'package:game_player_client/presentation/navigation/common/page_mapper.dart';
import 'package:game_player_client/presentation/navigation/home/home_navigation_state.dart';
import 'package:game_player_client/presentation/screens/lobbies/lobbies_screen.dart';
import 'package:game_player_client/presentation/screens/profile/profile_screen.dart';

class HomePageMapper extends PageMapper<HomeNavigationState> {
  const HomePageMapper();

  @override
  Page map(BuildContext context, HomeNavigationState state) => switch (state) {
        LobbiesState _ => page(const LobbiesScreen()),
        ProfileState _ => page(const ProfileScreen()),
      };
}
